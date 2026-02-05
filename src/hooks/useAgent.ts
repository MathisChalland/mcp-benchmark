import { useCallback, useMemo, useRef, useState } from "react";
import { useMcpClient } from "@/hooks/useMcpClient";
import { api } from "@/trpc/react";
import type { FlowNode } from "@/components/benchmark/agent-flow/flow-node";
import type { LLMModelKey } from "@/components/benchmark/setup/llm-models";
import {
  runAgentLoop,
  type AgentLoopResult,
  type AgentLoopEvents,
} from "@/benchmark/agent/agent-loop";

interface UseAgentOptions {
  mcpClient: ReturnType<typeof useMcpClient>;
  model?: LLMModelKey;
  maxIterations?: number;
  agentType?: string;
}

const appendNode = (node: FlowNode) => (prev: FlowNode[]) => [...prev, node];

const updateLastNode =
  <T extends FlowNode["type"]>(
    type: T,
    updater: (node: Extract<FlowNode, { type: T }>) => FlowNode,
  ) =>
  (prev: FlowNode[]): FlowNode[] => {
    const lastNode = prev.at(-1);
    if (lastNode?.type !== type) return prev;
    return [
      ...prev.slice(0, -1),
      updater(lastNode as Extract<FlowNode, { type: T }>),
    ];
  };

const createInitialFlow = (agentType?: string): FlowNode[] =>
  agentType ? [{ type: "agent", agentType }] : [];

export function useAgent({
  mcpClient,
  model = "openai/gpt-5-mini",
  maxIterations = 15,
  agentType,
}: UseAgentOptions) {
  const utils = api.useUtils();

  const [result, setResult] = useState<AgentLoopResult | null>(null);
  const [isProcessing, setIsProcessing] = useState(false);
  const [flow, setFlow] = useState<FlowNode[]>(() =>
    createInitialFlow(agentType),
  );

  const abortControllerRef = useRef<AbortController | null>(null);
  const isRunningRef = useRef(false);

  const isReady = mcpClient.status === "connected";
  const error = result?.error ?? mcpClient.error ?? null;

  const agentEvents = useMemo<AgentLoopEvents>(
    () => ({
      onLlmCall: (callNumber) => {
        setFlow(appendNode({ type: "llm-call", callNumber, isLoading: true }));
      },
      onLlmCallResult: () => {
        setFlow(
          updateLastNode("llm-call", (node) => ({ ...node, isLoading: false })),
        );
      },
      onReasoning: (content) => {
        setFlow(appendNode({ type: "reasoning", content }));
      },
      onResponse: (content) => {
        setFlow(appendNode({ type: "response", content }));
      },
      onToolCalls: (calls) => {
        setFlow(appendNode({ type: "tool-calls", calls }));
      },
      onToolResult: (toolCall, result) => {
        setFlow(
          updateLastNode("tool-calls", (node) => ({
            ...node,
            calls: node.calls.map((call) =>
              call.id === toolCall.id ? { ...call, result } : call,
            ),
          })),
        );
      },
    }),
    [],
  );

  const runTask = useCallback(
    async (instruction: string): Promise<AgentLoopResult> => {
      if (isRunningRef.current) {
        throw new Error("Agent is already running a task");
      }

      isRunningRef.current = true;
      abortControllerRef.current = new AbortController();
      setIsProcessing(true);
      setResult(null);

      try {
        const loopResult = await runAgentLoop({
          config: {
            instruction,
            systemPrompt: mcpClient.systemPrompt,
            tools: mcpClient.tools,
            maxIterations,
            model,
            signal: abortControllerRef.current.signal,
            llmCaller: utils.client.llm.chat.mutate,
            toolCaller: mcpClient.callTool,
          },
          events: agentEvents,
        });

        setResult(loopResult);
        return loopResult;
      } finally {
        isRunningRef.current = false;
        setIsProcessing(false);
      }
    },
    [maxIterations, model, mcpClient, utils, agentEvents],
  );

  const cancel = useCallback(() => {
    abortControllerRef.current?.abort();
  }, []);

  const reset = useCallback(() => {
    isRunningRef.current = false;
    abortControllerRef.current = null;
    setIsProcessing(false);
    setResult(null);
    setFlow(createInitialFlow(agentType));
  }, [agentType]);

  return {
    flow,
    result,
    error,
    metrics: result?.metrics,

    tools: mcpClient.tools,
    mcpStatus: mcpClient.status,

    runTask,
    cancel,
    reset,

    isReady,
    isProcessing,
  };
}
