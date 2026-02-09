import "dotenv/config";
import { type LLMModelKey } from "@/components/benchmark/setup/llm-models";
import { runAgentLoop, type AgentLoopResult } from "../agent/agent-loop";
import { executeLLMCall } from "@/lib/execute-llm-call";
import { setupBenchmarkAgents } from "./setup";
import {
  CODE_GEN_SYSTEM_PROMPT,
  TOOL_CALL_SYSTEM_PROMPT,
  type AgentType,
} from "../agent/agents";
import { configureBenchmark, type BenchmarkConfig } from "./config";
import * as p from "@clack/prompts";
import path from "path";
import fs from "fs";

const SYSTEM_PROMPTS: Record<AgentType, string> = {
  "tool-calling": TOOL_CALL_SYSTEM_PROMPT,
  "code-gen": CODE_GEN_SYSTEM_PROMPT,
};

export interface BenchmarkResult {
  config: BenchmarkConfig;
  results: GroupedResults;
}

type GroupedResults = Record<LLMModelKey, Record<AgentType, AgentLoopResult[]>>;

async function runBenchmark(config: BenchmarkConfig): Promise<void> {
  const results: BenchmarkResult = {
    config,
    results: {} as GroupedResults,
  };

  const totalRuns = config.agents.length * config.models.length * config.runs;

  p.note(
    `Test case: ${config.testCase.id}\nInstruction: ${config.testCase.instruction}\nTotal runs: ${totalRuns}`,
    "Benchmark Configuration",
  );

  const s = p.spinner();
  s.start("Setting up MCP servers");
  const agentSetups = await setupBenchmarkAgents(config.agents);
  s.stop("MCP servers ready");

  try {
    for (const model of config.models) {
      results.results[model] = {} as Record<AgentType, AgentLoopResult[]>;
      p.note(`Testing model: ${model}`, "Model");

      for (const agentSetup of agentSetups) {
        results.results[model][agentSetup.agentType] = [];
        p.intro(`${agentSetup.agentType}`);

        for (let run = 1; run <= config.runs; run++) {
          const spinner = p.spinner();
          spinner.start(`Run ${run} in progress...`);

          const result = await runAgentLoop({
            config: {
              instruction: config.testCase.instruction,
              validator: config.testCase.validator,
              systemPrompt: SYSTEM_PROMPTS[agentSetup.agentType],
              tools: agentSetup.tools,
              maxIterations: 15,
              model,
              llmCaller: executeLLMCall,
              toolCaller: agentSetup.client.callTool.bind(agentSetup.client),
            },
            events: {
              onLlmCall: (callCount) => {
                spinner.message(`Run ${run}: LLM call #${callCount}`);
              },
              onLlmCallResult(callNumber) {
                spinner.message(`Run ${run}: LLM call #${callNumber}`);
              },
              onToolResult: (toolCall) => {
                spinner.message(
                  `Run ${run}: Tool call: ${toolCall.function.name}`,
                );
              },
            },
          });

          results.results[model][agentSetup.agentType].push(result);

          if (result.isError) {
            spinner.error(`Error: ${result.error}`);
          } else {
            spinner.stop(
              `Run ${run}: ${(result.metrics.durationMs / 1000).toFixed(2)}s | ${result.metrics.llmCalls} LLM calls | ${result.metrics.toolCalls} tool calls | ${result.metrics.totalTokens} tokens`,
            );
          }
        }
        p.outro();
      }
    }
  } finally {
    const cleanupSpinner = p.spinner();
    cleanupSpinner.start("Cleaning up MCP connections");
    for (const setup of agentSetups) {
      await setup.cleanup();
    }
    cleanupSpinner.stop("Completed");
  }

  const outputPath = writeOutputFile(results);
  p.outro(`Results saved to: ${outputPath}`);
}

async function main(): Promise<void> {
  try {
    const config = await configureBenchmark();
    if (!config) {
      process.exit(0);
    }

    await runBenchmark(config);
  } catch (error) {
    p.log.error(`Fatal error: ${String(error)}`);
    process.exit(1);
  }
}

main().catch(console.error);

export function writeOutputFile(output: BenchmarkResult): string {
  const outputDir = path.join(process.cwd(), "output");

  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
  const filename = `benchmark-${output.config.testCase.id}-${timestamp}.json`;
  const filepath = path.join(outputDir, filename);

  fs.writeFileSync(filepath, JSON.stringify(output, null, 2));

  return filepath;
}

export function printProgress(
  current: number,
  total: number,
  agent: AgentType,
  model: string,
  run: number,
): void {
  const percentage = Math.round((current / total) * 100);
  console.log(
    `[${percentage}%] (${current}/${total}) | Agent: ${agent} | Model: ${model} | Run: ${run}`,
  );
}
