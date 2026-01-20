import { useMcpClient } from "@/hooks/useMcpClient";
import type { TestSetupResult } from "./setup/useTestSetup";
import { useEffect, useState } from "react";
import { FlowNode } from "./agent-flow/flow-node";
import { Agent } from "./agent";
import { Bot, Loader2 } from "lucide-react";
import { Button } from "../ui/button";
import { MetricOverview } from "./metric-overview";
import type { TaskMetrics } from "@/hooks/useMetricTracker";

interface Props {
  setup: TestSetupResult;
  onNewSetup?: () => void;
}

const AGENTS = [
  { key: "toolCall", serverUrl: "/api/mcp/tool-call/mcp", name: "Tool Call" },
  { key: "codeGen", serverUrl: "/api/mcp/code-gen/mcp", name: "Code Gen" },
] as const;

export function RunTestcase({ setup, onNewSetup }: Props) {
  const toolCallMcp = useMcpClient({ serverUrl: "/api/mcp/tool-call/mcp" });
  const codeGenMcp = useMcpClient({ serverUrl: "/api/mcp/code-gen/mcp" });
  const [metrics, setMetrics] = useState<Record<string, TaskMetrics>>({});

  const mcpClients = { toolCall: toolCallMcp, codeGen: codeGenMcp };
  const isConnected = Object.values(mcpClients).every(
    (client) => client.status === "connected",
  );

  useEffect(() => {
    void Promise.all([toolCallMcp.connect(), codeGenMcp.connect()]);
  }, [toolCallMcp, codeGenMcp]);

  return (
    <div className="bg-muted max-h-dvh w-full">
      <HeaderBar onNewSetup={onNewSetup} />
      <div className="max-h-dvh overflow-auto pt-16">
        <div className="mx-auto max-w-4xl px-6 pt-8">
          <FlowNode node={{ type: "request", content: setup.prompt }} />
        </div>
        {!isConnected ? (
          <div className="mx-auto mt-5 flex w-fit gap-5">
            <Loader2 className="size-4 animate-spin" /> Connecting to MCP
            servers...
          </div>
        ) : (
          <div className="container mx-auto">
            <div className="mt-3 grid w-full grid-cols-2 items-start pb-40">
              {AGENTS.map(({ key, name }) => (
                <AgentColumn
                  key={key}
                  mcpClient={mcpClients[key]}
                  setup={setup}
                  serverName={name}
                  metrics={metrics[key]}
                  onComplete={(m) =>
                    setMetrics((prev) => ({ ...prev, [key]: m }))
                  }
                />
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

function AgentColumn({
  mcpClient,
  setup,
  serverName,
  metrics,
  onComplete,
}: {
  mcpClient: ReturnType<typeof useMcpClient>;
  setup: TestSetupResult;
  serverName: string;
  metrics?: TaskMetrics;
  onComplete: (metrics: TaskMetrics) => void;
}) {
  return (
    <div className="sticky top-0 flex flex-col gap-8">
      <Agent mcpClient={mcpClient} setup={setup} onComplete={onComplete} />
      {metrics && metrics.llmCalls > 1 && (
        <div className="flex flex-col gap-8 px-6">
          <div className="border-border border-t" />
          <MetricOverview metrics={metrics} serverName={serverName} />
        </div>
      )}
    </div>
  );
}

function HeaderBar({ onNewSetup }: { onNewSetup?: () => void }) {
  return (
    <header className="border-border bg-muted/40 absolute top-0 z-50 w-full border-b backdrop-blur-lg">
      <div className="px-20 py-3">
        <Button
          variant="ghost"
          className="hover:bg-accent/0 cursor-pointer gap-2"
          onClick={onNewSetup}
        >
          <Bot className="text-muted-foreground size-5 stroke-[1.5]" />
          <h1 className="text-primary/90 text-center font-serif text-lg font-extralight">
            Agent playground & benchmark
          </h1>
        </Button>
      </div>
    </header>
  );
}
