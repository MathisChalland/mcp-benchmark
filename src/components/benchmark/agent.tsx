import { useAgent } from "@/hooks/useAgent";
import type { useMcpClient } from "@/hooks/useMcpClient";
import type { TestSetupResult } from "./setup/useTestSetup";
import { useEffect, useImperativeHandle, useRef, type Ref } from "react";
import { FlowNode } from "./agent-flow/flow-node";
import type { TaskMetrics } from "@/benchmark/agent/metric-tracker";

interface Props {
  mcpClient: ReturnType<typeof useMcpClient>;
  setup: TestSetupResult;
  agentType?: string;
  onComplete?: (metrics: TaskMetrics) => void;
  ref: Ref<AgentHandle | null>;
}

export interface AgentHandle {
  cancel: () => void;
}

export function Agent({ mcpClient, setup, agentType, onComplete, ref }: Props) {
  const agent = useAgent({
    mcpClient,
    model: setup.config.model,
    agentType,
  });

  const hasStartedRef = useRef(false);

  useImperativeHandle(ref, () => ({
    cancel: agent.cancel,
  }));

  // Auto-start the test when component mounts
  useEffect(() => {
    if (agent.isReady && !hasStartedRef.current) {
      hasStartedRef.current = true;
      agent
        .runTask(setup.prompt)
        .then((result) => {
          onComplete?.(result.metrics);
        })
        .catch((error) => {
          console.error("Agent task failed:", error);
        });
    }
  }, [agent.isReady]);

  return (
    <div className="flex w-full flex-col gap-4">
      {agent.flow.map((node, index) => (
        <FlowNode key={index} node={node} />
      ))}
      {agent.error && (
        <FlowNode node={{ type: "error", content: agent.error }} />
      )}
    </div>
  );
}
