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

export interface TaskMetrics extends LLMMetrics {
  llmCalls: number;
  finished: boolean;
  success: boolean | undefined;
}

export function extractTokenUsage(usage: CompletionUsage): TokenUsage {
  return {
    totalTokens: usage.total_tokens,
    inputTokens: usage.prompt_tokens,
    outputTokens: usage.completion_tokens,
    reasoningTokens: usage.completion_tokens_details?.reasoning_tokens ?? 0,
  };
}

const INITIAL_METRICS: TaskMetrics = {
  totalTokens: 0,
  inputTokens: 0,
  outputTokens: 0,
  reasoningTokens: 0,
  durationMs: 0,
  toolCalls: 0,
  llmCalls: 0,
  finished: false,
  success: undefined,
};

export class MetricTracker {
  private metrics: TaskMetrics;
  private startTime: number;

  constructor() {
    this.metrics = { ...INITIAL_METRICS };
    this.startTime = 0;
  }

  start() {
    this.startTime = Date.now();
    this.metrics = { ...INITIAL_METRICS };
  }

  addLLMCall() {
    this.metrics.llmCalls += 1;
  }

  track(metrics: Partial<Omit<LLMMetrics, "durationMs">>) {
    this.metrics.totalTokens += metrics.totalTokens ?? 0;
    this.metrics.inputTokens += metrics.inputTokens ?? 0;
    this.metrics.outputTokens += metrics.outputTokens ?? 0;
    this.metrics.reasoningTokens += metrics.reasoningTokens ?? 0;
    this.metrics.toolCalls += metrics.toolCalls ?? 0;
  }

  finish() {
    this.metrics.finished = true;
    this.metrics.durationMs = Date.now() - this.startTime;
  }

  getMetrics() {
    return this.metrics;
  }

  getCallCount() {
    return this.metrics.llmCalls;
  }
}
