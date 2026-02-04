import type { CompletionUsage } from "openai/resources";

export interface TokenUsage {
  totalTokens: number;
  inputTokens: number;
  outputTokens: number;
  reasoningTokens: number;
}

export interface LLMMetrics extends TokenUsage {
  durationMs: number;
  toolCalls: number;
}

export function extractTokenUsage(usage: CompletionUsage): TokenUsage {
  return {
    totalTokens: usage.total_tokens,
    inputTokens: usage.prompt_tokens,
    outputTokens: usage.completion_tokens,
    reasoningTokens: usage.completion_tokens_details?.reasoning_tokens ?? 0,
  };
}
