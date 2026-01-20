import { useCallback, useRef, useState } from "react";

export interface TaskMetrics {
  totalTokens: number;
  promptTokens: number;
  completionTokens: number;
  llmCalls: number;
  toolCalls: number;
  durationMs: number;
  finished: boolean;
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
  finished: false,
};

export function useMetricTracker() {
  const [metrics, setMetrics] = useState<TaskMetrics>(initialMetrics);
  const startTimeRef = useRef<number>(0);
  const metricsRef = useRef<TaskMetrics>(initialMetrics);

  const start = useCallback(() => {
    startTimeRef.current = Date.now();
    metricsRef.current = initialMetrics;
    setMetrics(initialMetrics);
  }, []);

  const reset = useCallback(() => {
    startTimeRef.current = 0;
    metricsRef.current = initialMetrics;
    setMetrics(initialMetrics);
  }, []);

  const recordLLMCall = useCallback((usage?: LLMUsage) => {
    metricsRef.current = {
      ...metricsRef.current,
      llmCalls: metricsRef.current.llmCalls + 1,
      totalTokens: metricsRef.current.totalTokens + (usage?.total_tokens ?? 0),
      promptTokens:
        metricsRef.current.promptTokens + (usage?.prompt_tokens ?? 0),
      completionTokens:
        metricsRef.current.completionTokens + (usage?.completion_tokens ?? 0),
    };
    setMetrics(metricsRef.current);
  }, []);

  const recordToolCall = useCallback(() => {
    metricsRef.current = {
      ...metricsRef.current,
      toolCalls: metricsRef.current.toolCalls + 1,
    };
    setMetrics(metricsRef.current);
  }, []);

  const stop = useCallback(() => {
    const duration = Date.now() - startTimeRef.current;
    metricsRef.current = {
      ...metricsRef.current,
      durationMs: duration,
      finished: true,
    };
    setMetrics(metricsRef.current);
    return duration;
  }, []);

  const getMetrics = useCallback((): TaskMetrics => {
    return {
      ...metricsRef.current,
      durationMs: startTimeRef.current
        ? Date.now() - startTimeRef.current
        : metricsRef.current.durationMs,
    };
  }, []);

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
