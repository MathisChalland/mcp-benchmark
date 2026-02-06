import {
  LLM_MODELS,
  type LLMModelKey,
} from "@/components/benchmark/setup/llm-models";
import { TEST_CASES, type TestCase } from "../test-cases";
import { AGENT_TYPES, type AgentType } from "./setup";
import * as p from "@clack/prompts";
import { isCancel } from "@clack/prompts";

export interface BenchmarkConfig {
  testCase: TestCase;
  agents: AgentType[];
  models: LLMModelKey[];
  runs: number;
}

export async function configureBenchmark(): Promise<BenchmarkConfig | null> {
  p.intro("Configure Benchmark");

  const testCaseId = await p.select({
    message: "Select test case to benchmark:",
    options: TEST_CASES.map((tc) => ({
      label: `${tc.id} (${tc.toolDependency}, ${tc.dataComplexity})`,
      value: tc.id,
      hint: tc.instruction,
    })),
  });

  if (isCancel(testCaseId)) {
    p.cancel("Benchmark configuration cancelled.");
    return null;
  }

  const testCase = TEST_CASES.find((tc) => tc.id === testCaseId);

  if (!testCase) return null;

  const agents = await p.multiselect({
    message: "Select agents to benchmark:",
    options: AGENT_TYPES.map((agent) => ({
      label: agent.title,
      value: agent.value,
    })),
    initialValues: AGENT_TYPES.map((agent) => agent.value),
    required: true,
  });

  if (isCancel(agents)) {
    p.cancel("Benchmark configuration cancelled.");
    return null;
  }

  if (!agents || agents.length === 0) return null;

  const models = await p.multiselect({
    message: "Select LLM models to test:",
    options: Object.entries(LLM_MODELS).map(([key, model]) => ({
      label: `${model.name} (${key})`,
      value: key as LLMModelKey,
    })),
    initialValues: Object.keys(LLM_MODELS) as LLMModelKey[],
    required: true,
  });

  if (isCancel(models)) {
    p.cancel("Benchmark configuration cancelled.");
    return null;
  }

  if (!models || models.length === 0) return null;

  const runs = await p.text({
    message: "Number of runs per combination (1-100):",
    placeholder: "3",
    initialValue: "3",
    validate: (value) => {
      if (!value) return "Please enter a number";
      const num = parseInt(value);
      if (isNaN(num) || num < 1 || num > 100) {
        return "Please enter a number between 1 and 100";
      }
    },
  });

  if (isCancel(runs)) {
    p.cancel("Benchmark configuration cancelled.");
    return null;
  }

  const runsNum = parseInt(runs as string);
  if (!runsNum || runsNum < 1 || runsNum > 100) return null;

  p.outro("Configuration complete!");

  return {
    testCase,
    agents: agents as AgentType[],
    models: models as LLMModelKey[],
    runs: runsNum,
  };
}
