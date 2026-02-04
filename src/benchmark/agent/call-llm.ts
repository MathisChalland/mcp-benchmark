import type { CallLLMInput, executeLLMCall } from "@/lib/execute-llm-call";
import type {
  ChatCompletionMessage,
  ChatCompletionMessageFunctionToolCall,
  ChatCompletionMessageParam,
} from "openai/resources";
import { extractTokenUsage, type LLMCallMetrics } from "./metric-tracker";

interface Input {
  caller: typeof executeLLMCall;
  params: CallLLMInput;
}

export interface CallLLMResult {
  response: string | null;
  reasoning: string | null;
  metrics: LLMCallMetrics;
  toolCalls: ChatCompletionMessageFunctionToolCall[] | null;
  newMessage: ChatCompletionMessageParam;
}

export async function callLLM({
  caller,
  params,
}: Input): Promise<CallLLMResult> {
  const start = Date.now();
  const response = await caller(params);
  const durationMs = Date.now() - start;

  const assistantMessage = response.choices[0]?.message;
  if (!assistantMessage) throw new Error("No response from LLM");
  if (!response.usage) throw new Error("No usage data from LLM");

  const toolCalls = extractFunctionCalls(assistantMessage);

  const metrics = {
    ...extractTokenUsage(response.usage),
    durationMs,
    toolCalls: toolCalls ? toolCalls.length : 0,
  };

  const newMessage: ChatCompletionMessageParam = {
    role: "assistant",
    content: assistantMessage.content,
    tool_calls: assistantMessage.tool_calls,
  };

  return {
    response: assistantMessage.content,
    reasoning: extractReasoning(assistantMessage),
    metrics,
    toolCalls,
    newMessage,
  };
}

function extractFunctionCalls(message: ChatCompletionMessage) {
  if (!message.tool_calls || message.tool_calls.length < 1) return null;
  const functionCalls = message.tool_calls.filter(
    (tc) => tc.type === "function",
  );

  if (functionCalls.length < 1) return null;
  return functionCalls;
}

function extractReasoning(message: ChatCompletionMessage) {
  // OpenRouter may include reasoning in extended response
  const extendedMessage = message as {
    reasoning?: string;
  };
  const reasoningContent = extendedMessage.reasoning;
  return reasoningContent ?? null;
}
