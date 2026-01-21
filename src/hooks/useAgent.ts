import { useCallback, useRef, useState } from "react";
import { useMcpClient, type Tool } from "@/hooks/useMcpClient";
import { useMetricTracker, type TaskMetrics } from "@/hooks/useMetricTracker";
import { api } from "@/trpc/react";
import type { ToolCall, ToolContent } from "@/app/api/mcp/types";
import type { FlowNode } from "@/components/benchmark/agent-flow/flow-node";
import type {
  Message,
  ChatMessageToolCall,
  ToolDefinitionJson,
} from "@openrouter/sdk/models";
import type {
  Effort,
  LLMModelKey,
} from "@/components/benchmark/setup/llm-models";

interface TaskResult {
  success: boolean;
  answer?: string | null;
  error?: string;
  iterations: number;
  metrics: TaskMetrics;
  messages: Message[];
}

type AgentStatus =
  | "initializing"
  | "idle"
  | "processing"
  | "finished"
  | "error";

interface UseAgentOptions {
  mcpClient: ReturnType<typeof useMcpClient>;
  model?: LLMModelKey;
  reasoning?: Effort;
  maxIterations?: number;
  onToolCall?: (toolName: string, args: Record<string, unknown>) => void;
  onIteration?: (iteration: number, message: Message) => void;
}

export function useAgent({
  mcpClient,
  model = "openai/gpt-5-mini",
  reasoning = "minimal",
  maxIterations = 15,
}: UseAgentOptions) {
  const metricTracker = useMetricTracker();
  const utils = api.useUtils();

  const [messages, setMessages] = useState<Message[]>([]);
  const [currentIteration, setCurrentIteration] = useState(0);
  const [result, setResult] = useState<TaskResult | null>(null);
  const [isProcessing, setIsProcessing] = useState(false);
  const [flow, setFlow] = useState<FlowNode[]>([]);

  const error = result?.error ?? mcpClient.error ?? null;

  const isReady = mcpClient.status === "connected";

  const status: AgentStatus = !isReady
    ? "initializing"
    : isProcessing
      ? "processing"
      : error
        ? "error"
        : result
          ? "finished"
          : "idle";

  const abortControllerRef = useRef<AbortController | null>(null);
  const isRunningRef = useRef(false);

  const checkAborted = useCallback(() => {
    if (abortControllerRef.current?.signal.aborted) {
      throw new Error("Task cancelled");
    }
  }, []);

  const executeTool = useCallback(
    async (
      toolCall: ToolCall,
    ): Promise<{ result: string; error?: boolean }> => {
      const args = JSON.parse(toolCall.function.arguments) as Record<
        string,
        unknown
      >;

      try {
        const result = await mcpClient.callTool<{ content: ToolContent[] }>(
          toolCall.function.name,
          args,
        );
        metricTracker.recordToolCall();
        return { result: extractTextFromToolResult(result.content) };
      } catch (err) {
        const errorMsg = err instanceof Error ? err.message : String(err);
        return {
          result: `Error calling ${toolCall.function.name}: ${errorMsg}`,
          error: true,
        };
      }
    },
    [mcpClient, metricTracker],
  );

  const executeToolCalls = useCallback(
    async (toolCalls: ChatMessageToolCall[], taskMessages: Message[]) => {
      const functionCalls = toolCalls.filter((tc) => tc.type === "function");
      setFlow((prev) => [
        ...prev,
        {
          type: "tool-calls",
          calls: functionCalls.map((tc) => ({
            id: tc.id,
            name: tc.function.name,
            arguments: tc.function.arguments,
          })),
        },
      ]);
      await Promise.all(
        functionCalls.map(async (toolCall) => {
          checkAborted();

          const result = await executeTool(toolCall);
          const toolMessage: Message = {
            role: "tool",
            toolCallId: toolCall.id,
            content: result.result,
          };

          setFlow((prev) => {
            const toolCallsNode = prev[prev.length - 1];
            if (toolCallsNode?.type !== "tool-calls") {
              throw new Error("Expected tool-calls node");
            }
            const updatedCalls = toolCallsNode.calls.map((call) =>
              call.id === toolCall.id
                ? {
                    ...call,
                    ...(result.error
                      ? { error: result.result }
                      : { response: result.result }),
                  }
                : call,
            );
            return [
              ...prev.slice(0, -1),
              { ...toolCallsNode, calls: updatedCalls },
            ];
          });

          taskMessages.push(toolMessage);
          setMessages([...taskMessages]);
          return Promise.resolve();
        }),
      );
    },
    [checkAborted, executeTool, setFlow],
  );

  const callLLM = useCallback(
    async (taskMessages: Message[]) => {
      setFlow((prev) => [
        ...prev,
        {
          type: "llm-call",
          callNumber: prev.filter((n) => n.type === "llm-call").length + 1,
          isLoading: true,
        },
      ]);
      const response = await utils.client.llm.chat.mutate({
        model,
        //reasoning,
        messages: taskMessages,
        tools: convertToOpenAITools(mcpClient.tools),
      });
      setFlow((prev) => {
        const lastNode = prev[prev.length - 1];
        if (lastNode?.type !== "llm-call") {
          throw new Error("Expected llm-call node");
        }
        return [...prev.slice(0, -1), { ...lastNode, isLoading: false }];
      });

      metricTracker.recordLLMCall(response.usage);

      const assistantMessage = response.choices[0]?.message;
      if (!assistantMessage) {
        throw new Error("No response from LLM");
      }

      const newMessage: Message = {
        role: "assistant",
        content: assistantMessage.content,
        toolCalls: assistantMessage.toolCalls,
        ...(assistantMessage.reasoningDetails && {
          reasoningDetails: assistantMessage.reasoningDetails,
        }),
      };

      const reasoningContent =
        assistantMessage.reasoning ??
        assistantMessage.reasoningDetails
          ?.map((detail) => {
            if (detail.type === "reasoning.text" && detail.text) {
              return detail.text;
            }
            if (detail.type === "reasoning.summary" && detail.summary) {
              return detail.summary;
            }
            return null;
          })
          .filter(Boolean)
          .join("\n");

      if (reasoningContent) {
        setFlow((prev) => [
          ...prev,
          { type: "reasoning", content: reasoningContent },
        ]);
      }

      if (
        newMessage.content &&
        typeof newMessage.content === "string" &&
        newMessage.content.trim()
      ) {
        const content = newMessage.content;
        setFlow((prev) => [...prev, { type: "response", content }]);
      }

      taskMessages.push(newMessage);
      setMessages([...taskMessages]);

      return assistantMessage;
    },
    [mcpClient.tools, metricTracker, model, utils],
  );

  const finalizeTask = useCallback(
    (
      taskMessages: Message[],
      iterations: number,
      outcome:
        | { success: true; answer: string | null }
        | { success: false; error: string },
    ): TaskResult => {
      metricTracker.stop();
      isRunningRef.current = false;

      const taskResult = {
        ...outcome,
        iterations,
        metrics: metricTracker.getMetrics(),
        messages: taskMessages,
      };

      setResult(taskResult);
      setIsProcessing(false);

      return taskResult;
    },
    [metricTracker],
  );

  const runTask = useCallback(
    async (instruction: string): Promise<TaskResult> => {
      if (isRunningRef.current) {
        return {
          success: false,
          error: "Task already running",
          iterations: 0,
          metrics: metricTracker.getMetrics(),
          messages: [],
        };
      }
      isRunningRef.current = true;
      setIsProcessing(true);
      setCurrentIteration(0);
      metricTracker.start();
      abortControllerRef.current = new AbortController();

      const taskMessages: Message[] = [{ role: "user", content: instruction }];
      setMessages([...taskMessages]);

      let iterations = 0;

      try {
        while (iterations < maxIterations) {
          checkAborted();
          iterations++;
          setCurrentIteration(iterations);

          const assistantMessage = await callLLM(taskMessages);

          if (!assistantMessage.toolCalls?.length) {
            const answer =
              typeof assistantMessage.content === "string"
                ? assistantMessage.content
                : null;
            return finalizeTask(taskMessages, iterations, {
              success: true,
              answer,
            });
          }

          await executeToolCalls(assistantMessage.toolCalls, taskMessages);
        }

        return finalizeTask(taskMessages, iterations, {
          success: false,
          error: "Max iterations reached",
        });
      } catch (err) {
        const errorMessage = err instanceof Error ? err.message : String(err);
        return finalizeTask(taskMessages, iterations, {
          success: false,
          error: errorMessage,
        });
      }
    },
    [
      maxIterations,
      checkAborted,
      callLLM,
      executeToolCalls,
      finalizeTask,
      metricTracker,
    ],
  );

  const cancel = useCallback(() => {
    abortControllerRef.current?.abort();
  }, []);

  const reset = useCallback(() => {
    setIsProcessing(false);
    setMessages([]);
    setCurrentIteration(0);
    setResult(null);
    setFlow([]);
    metricTracker.reset();
  }, [metricTracker]);

  return {
    status: status,
    messages,
    flow,
    currentIteration,
    result,
    error: error ?? mcpClient.error,
    metrics: metricTracker.metrics,
    tools: mcpClient.tools,
    mcpStatus: mcpClient.status,
    runTask,
    cancel,
    reset,
    isReady,
    isProcessing: status === "processing",
  };
}

function convertToOpenAITools(tools: Tool[]): ToolDefinitionJson[] {
  return tools.map((tool) => ({
    type: "function" as const,
    function: {
      name: tool.name,
      description: tool.description ?? "",
      parameters: tool.inputSchema ?? { type: "object", properties: {} },
    },
  }));
}

function extractTextFromToolResult(content: ToolContent[]): string {
  return content
    .filter((c) => c.type === "text" && c.text)
    .map((c) => c.text)
    .join("\n");
}
