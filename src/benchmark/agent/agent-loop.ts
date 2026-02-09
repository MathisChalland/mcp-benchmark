import type {
  ChatCompletionMessageFunctionToolCall,
  ChatCompletionMessageParam,
  ChatCompletionTool,
} from "openai/resources";
import { callLLM, type LLMCaller, type LLMCallResult } from "./call-llm";
import {
  executeToolCalls,
  type ToolCaller,
  type ToolCallResult,
} from "./execute-tool-calls";
import type { Tool } from "@modelcontextprotocol/sdk/types.js";
import { MetricTracker, type TaskMetrics } from "./metric-tracker";
import type { LLMModelKey } from "@/components/benchmark/setup/llm-models";
import { type TestCaseValidator } from "../validator";

interface AgentLoopConfig {
  instruction: string;
  validator?: TestCaseValidator;
  systemPrompt?: string;
  tools: Tool[];
  maxIterations?: number;
  model: LLMModelKey;
  signal?: AbortSignal;
  llmCaller: LLMCaller;
  toolCaller: ToolCaller;
}

export interface AgentLoopEvents {
  onStart?: () => void;
  onLlmCall?: (callNumber: number) => void;
  onLlmCallResult?: (callNumber: number, result: LLMCallResult) => void;
  onReasoning?: (content: string) => void;
  onResponse?: (content: string) => void;
  onToolCalls?: (calls: ChatCompletionMessageFunctionToolCall[]) => void;
  onToolResult?: (
    call: ChatCompletionMessageFunctionToolCall,
    result: ToolCallResult,
  ) => void;
}

interface AgentLoopInput {
  config: AgentLoopConfig;
  events?: AgentLoopEvents;
}

export interface AgentLoopResult {
  isError: boolean;
  answer?: string | null;
  error?: string | null;
  metrics: TaskMetrics;
}

export async function runAgentLoop({
  config,
  events = {},
}: AgentLoopInput): Promise<AgentLoopResult> {
  const {
    instruction,
    validator,
    systemPrompt,
    tools,
    maxIterations = 10,
    model,
    signal,
    llmCaller,
    toolCaller,
  } = config;

  const metricTracker = new MetricTracker();

  const messages: ChatCompletionMessageParam[] = [];
  const openAITools = convertToOpenAITools(tools);

  if (systemPrompt) {
    messages.push({ role: "system", content: systemPrompt });
  }
  messages.push({ role: "user", content: instruction });

  const checkAborted = () => {
    if (signal?.aborted) {
      throw new Error("Task cancelled");
    }
  };

  events.onStart?.();
  metricTracker.start();

  try {
    while (metricTracker.getCallCount() < maxIterations + 1) {
      checkAborted();
      metricTracker.addLLMCall();

      events.onLlmCall?.(metricTracker.getCallCount());
      const llmResult = await callLLM({
        caller: llmCaller,
        params: {
          model,
          messages,
          tools: openAITools,
        },
      });
      metricTracker.track(llmResult.metrics);
      messages.push(llmResult.newMessage);

      events.onLlmCallResult?.(metricTracker.getCallCount(), llmResult);
      if (llmResult.reasoning) events.onReasoning?.(llmResult.reasoning);
      if (llmResult.response) events.onResponse?.(llmResult.response);

      if (!llmResult.toolCalls) {
        metricTracker.finish();
        return {
          isError: false,
          answer: llmResult.response,
          metrics: metricTracker.getFinalMetrics(llmResult.response, validator),
        };
      }

      events.onToolCalls?.(llmResult.toolCalls);
      const toolResults = await executeToolCalls({
        toolCalls: llmResult.toolCalls,
        caller: toolCaller,
        onToolResult(toolCall, result) {
          events.onToolResult?.(toolCall, result);
        },
      });

      messages.push(...toolResults);
    }
  } catch (err) {
    metricTracker.finish();
    return {
      isError: true,
      error: err instanceof Error ? err.message : String(err),
      metrics: metricTracker.getFinalMetrics(),
    };
  }
  metricTracker.finish();

  return {
    isError: true,
    error: "Max iterations reached without a final answer",
    metrics: metricTracker.getFinalMetrics(),
  };
}

function convertToOpenAITools(tools: Tool[]): ChatCompletionTool[] {
  return tools.map((tool) => ({
    type: "function",
    function: {
      name: tool.name,
      description: tool.description ?? "",
      parameters: tool.inputSchema,
    },
  }));
}
