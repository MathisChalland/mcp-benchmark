import { useCallback, useRef, useState } from "react";

export interface TaskMetrics {
  totalTokens: number;
  promptTokens: number;
  completionTokens: number;
  llmCalls: number;
  toolCalls: number;
  durationMs: number;
}

interface LLMUsage {
  total_tokens?: number;
  prompt_tokens?: number;
  completion_tokens?: number;
}

const initialMetrics: TaskMetrics = {
  totalTokens: 0,
  promptTokens: 0,
  completionTokens: 0,
  llmCalls: 0,
  toolCalls: 0,
  durationMs: 0,
};

export function useMetricTracker() {
  const [metrics, setMetrics] = useState<TaskMetrics>(initialMetrics);
  const startTimeRef = useRef<number>(0);

  const start = useCallback(() => {
    startTimeRef.current = Date.now();
    setMetrics(initialMetrics);
  }, []);

  const reset = useCallback(() => {
    startTimeRef.current = 0;
    setMetrics(initialMetrics);
  }, []);

  const recordLLMCall = useCallback((usage?: LLMUsage) => {
    setMetrics((prev) => ({
      ...prev,
      llmCalls: prev.llmCalls + 1,
      totalTokens: prev.totalTokens + (usage?.total_tokens ?? 0),
      promptTokens: prev.promptTokens + (usage?.prompt_tokens ?? 0),
      completionTokens: prev.completionTokens + (usage?.completion_tokens ?? 0),
    }));
  }, []);

  const recordToolCall = useCallback(() => {
    setMetrics((prev) => ({
      ...prev,
      toolCalls: prev.toolCalls + 1,
    }));
  }, []);

  const stop = useCallback(() => {
    const duration = Date.now() - startTimeRef.current;
    setMetrics((prev) => ({
      ...prev,
      durationMs: duration,
    }));
    return duration;
  }, []);

  const getMetrics = useCallback((): TaskMetrics => {
    return {
      ...metrics,
      durationMs: startTimeRef.current
        ? Date.now() - startTimeRef.current
        : metrics.durationMs,
    };
  }, [metrics]);

  return {
    metrics,
    start,
    stop,
    reset,
    recordLLMCall,
    recordToolCall,
    getMetrics,
  };
}
