import { useCallback, useRef, useState } from "react";
import { useMcpClient, type Tool } from "@/hooks/useMcpClient";
import { useMetricTracker, type TaskMetrics } from "@/hooks/useMetricTracker";
import { api } from "@/trpc/react";
import type OpenAI from "openai";
import type { ToolCall, ToolContent } from "@/app/api/mcp/types";

type Message = OpenAI.Chat.ChatCompletionMessageParam;

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
  serverUrl: string;
  model?: string;
  maxIterations?: number;
  onToolCall?: (toolName: string, args: Record<string, unknown>) => void;
  onIteration?: (iteration: number, message: Message) => void;
}

export function useAgent({
  serverUrl,
  model = "gpt-5.1-2025-11-13",
  maxIterations = 15,
  onToolCall,
  onIteration,
}: UseAgentOptions) {
  const mcpClient = useMcpClient({ serverUrl, autoConnect: true });
  const metricTracker = useMetricTracker();
  const utils = api.useUtils();

  const [messages, setMessages] = useState<Message[]>([]);
  const [currentIteration, setCurrentIteration] = useState(0);
  const [result, setResult] = useState<TaskResult | null>(null);
  const [isProcessing, setIsProcessing] = useState(false);

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

  const checkAborted = useCallback(() => {
    if (abortControllerRef.current?.signal.aborted) {
      throw new Error("Task cancelled");
    }
  }, []);

  const executeTool = useCallback(
    async (toolCall: ToolCall): Promise<string> => {
      const args = JSON.parse(toolCall.function.arguments) as Record<
        string,
        unknown
      >;
      onToolCall?.(toolCall.function.name, args);

      try {
        const result = await mcpClient.callTool<{ content: ToolContent[] }>(
          toolCall.function.name,
          args,
        );
        metricTracker.recordToolCall();
        return extractTextFromToolResult(result.content);
      } catch (err) {
        const errorMsg = err instanceof Error ? err.message : String(err);
        return `Error calling ${toolCall.function.name}: ${errorMsg}`;
      }
    },
    [mcpClient, metricTracker, onToolCall],
  );

  const executeToolCalls = useCallback(
    async (
      toolCalls: OpenAI.Chat.ChatCompletionMessageToolCall[],
      taskMessages: Message[],
    ) => {
      await Promise.all(
        toolCalls.map(async (toolCall) => {
          checkAborted();
          if (toolCall.type !== "function") return Promise.resolve();

          const resultText = await executeTool(toolCall);
          const toolMessage: Message = {
            role: "tool",
            tool_call_id: toolCall.id,
            content: resultText,
          };

          taskMessages.push(toolMessage);
          setMessages([...taskMessages]);
          return Promise.resolve();
        }),
      );
    },
    [checkAborted, executeTool],
  );

  const callLLM = useCallback(
    async (taskMessages: Message[]) => {
      const response = await utils.client.llm.chat.mutate({
        model,
        messages: taskMessages,
        tools: convertToOpenAITools(mcpClient.tools),
      });

      metricTracker.recordLLMCall(response.usage);

      const assistantMessage = response.choices[0]?.message;
      if (!assistantMessage) {
        throw new Error("No response from LLM");
      }

      const newMessage: Message = {
        role: "assistant",
        content: assistantMessage.content,
        tool_calls: assistantMessage.tool_calls,
      };

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

      const taskResult = {
        ...outcome,
        iterations,
        metrics: metricTracker.getMetrics(),
        messages: taskMessages,
      };

      setResult(taskResult);
      setIsProcessing(false);

      console.log("Task Result:", taskResult);

      return taskResult;
    },
    [metricTracker],
  );

  const runTask = useCallback(
    async (instruction: string): Promise<TaskResult> => {
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
          onIteration?.(iterations, taskMessages[taskMessages.length - 1]!);

          if (!assistantMessage.tool_calls?.length) {
            return finalizeTask(taskMessages, iterations, {
              success: true,
              answer: assistantMessage.content,
            });
          }

          await executeToolCalls(assistantMessage.tool_calls, taskMessages);
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
      onIteration,
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
    metricTracker.reset();
  }, [metricTracker]);

  return {
    status: status,
    messages,
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

function convertToOpenAITools(tools: Tool[]): OpenAI.Chat.ChatCompletionTool[] {
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
