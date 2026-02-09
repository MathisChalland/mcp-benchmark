"use client";
import { useState, useMemo, useCallback } from "react";
import { type MCP_SERVERS } from "@/contexts/useMcpClientContext";
import type {
  Effort,
  LLMModelKey,
} from "@/components/benchmark/setup/llm-models";
import { TEST_CASES, type TestCase } from "@/benchmark/test-cases";

export interface TestSetupConfig {
  model: LLMModelKey;
  reasoning: Effort;
  mcpServer: Record<keyof typeof MCP_SERVERS, boolean>;
}

export interface TestSetupResult {
  prompt: string;
  testCase?: TestCase;
  config: TestSetupConfig;
}

const defaultConfig: TestSetupConfig = {
  model: "google/gemini-3-flash-preview",
  reasoning: "minimal",
  mcpServer: {
    toolCall: true,
    codeGen: true,
  },
};

export function useTestSetup() {
  const [selectedTestId, setSelectedTestId] = useState<string | null>(null);
  const [customPrompt, setCustomPrompt] = useState("");
  const [config, setConfig] = useState<TestSetupConfig>(defaultConfig);

  const selectedTest = useMemo(
    () => TEST_CASES.find((t) => t.id === selectedTestId),
    [selectedTestId],
  );

  const prompt = selectedTest?.instruction ?? customPrompt;
  const isTestCase = selectedTestId !== null;
  const canSubmit = prompt.trim().length > 0;

  const handlePromptChange = useCallback(
    (value: string) => {
      if (value === selectedTest?.instruction) {
        return;
      }
      setSelectedTestId(null);
      setCustomPrompt(value);
    },
    [selectedTest],
  );

  const selectTestCase = useCallback((testId: string) => {
    setSelectedTestId(testId);
  }, []);

  const clearTestCase = useCallback(() => {
    setSelectedTestId(null);
  }, []);

  const updateConfig = useCallback((updates: Partial<TestSetupConfig>) => {
    setConfig((prev) => ({ ...prev, ...updates }));
  }, []);

  const getResult = useCallback((): TestSetupResult => {
    return {
      prompt,
      testCase: selectedTest ?? undefined,
      config,
    };
  }, [prompt, selectedTest, config]);

  const reset = useCallback(() => {
    setSelectedTestId(null);
    setCustomPrompt("");
    setConfig(defaultConfig);
  }, []);

  return {
    // State
    prompt,
    isTestCase,
    selectedTestId,
    config,
    canSubmit,
    // Actions
    handlePromptChange,
    selectTestCase,
    clearTestCase,
    updateConfig,
    getResult,
    reset,
  };
}
