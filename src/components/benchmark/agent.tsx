import { useAgent } from "@/hooks/useAgent";
import type { useMcpClient } from "@/hooks/useMcpClient";
import type { TestSetupResult } from "./setup/useTestSetup";
import { useEffect } from "react";
import { FlowNode } from "./agent-flow/flow-node";

interface Props {
  mcpClient: ReturnType<typeof useMcpClient>;
  setup: TestSetupResult;
}

export function Agent({ mcpClient, setup }: Props) {
  const agent = useAgent({ mcpClient });

  // Auto-start the test when component mounts
  useEffect(() => {
    if (agent.isReady && agent.messages.length === 0) {
      agent.runTask(setup.prompt);
    }
  }, [agent.isReady]);

  return (
    <div className="mx-auto flex w-full max-w-4xl flex-col gap-4 px-6 pt-8 pb-20">
      {agent.flow.map((node, index) => (
        <FlowNode key={index} node={node} />
      ))}
    </div>
  );
}
