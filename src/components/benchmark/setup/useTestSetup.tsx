"use client";
import { useState, useMemo, useCallback } from "react";
import { tests } from "@/benchmark/test-cases";
import { MCP_SERVERS } from "@/contexts/useMcpClientContext";
import type {
  Effort,
  LLMModelKey,
} from "@/components/benchmark/setup/llm-models";

export interface TestSetupConfig {
  model: LLMModelKey;
  reasoning: Effort;
  mcpServer: Record<keyof typeof MCP_SERVERS, boolean>;
}

export interface TestSetupResult {
  prompt: string;
  isTestCase: boolean;
  testCaseId: string | null;
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
    () => tests.find((t) => t.id === selectedTestId),
    [selectedTestId],
  );

  const prompt = selectedTest?.instruction ?? customPrompt;
  const isTestCase = selectedTestId !== null;
  const canSubmit = prompt.trim().length > 0;

  const handlePromptChange = useCallback(
    (value: string) => {
      if (selectedTest && value === selectedTest.instruction) {
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
      isTestCase,
      testCaseId: selectedTestId,
      config,
    };
  }, [prompt, isTestCase, selectedTestId, config]);

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
