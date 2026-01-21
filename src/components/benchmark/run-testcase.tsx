import type { TestSetupResult } from "./setup/useTestSetup";
import { useState } from "react";
import { FlowNode } from "./agent-flow/flow-node";
import { Agent } from "./agent";
import { Bot, Loader2, RotateCcw } from "lucide-react";
import { Button } from "../ui/button";
import { MetricOverview } from "./metric-overview";
import type { TaskMetrics } from "@/hooks/useMetricTracker";
import {
  MCP_SERVERS,
  useMcpClients,
  type McpClientType,
} from "@/contexts/useMcpClientContext";

interface Props {
  setup: TestSetupResult;
  onNewSetup?: (run?: TestSetupResult) => void;
}

export function RunTestcase({ setup, onNewSetup }: Props) {
  const mcpClients = useMcpClients();
  const [metrics, setMetrics] = useState<Record<string, TaskMetrics>>({});

  const AGENTS = Object.entries(setup.config.mcpServer)
    .filter(([, enabled]) => enabled)
    .map(([k]) => {
      const key = k as keyof typeof MCP_SERVERS;
      return { key: key, name: MCP_SERVERS[key].name };
    });

  const isFinished = AGENTS.every(({ key }) => metrics[key]?.finished);
  const onBack = () => onNewSetup?.(undefined);
  const onRerun = () => onNewSetup?.(setup);

  return (
    <div className="bg-muted max-h-dvh w-full">
      <HeaderBar isFinished={isFinished} onBack={onBack} onRerun={onRerun} />
      <div className="max-h-dvh overflow-auto pt-16 pb-40">
        <div className="mx-auto max-w-4xl px-6 pt-8">
          <FlowNode node={{ type: "request", content: setup.prompt }} />
        </div>
        {!mcpClients.isConnected ? (
          <div className="mx-auto mt-5 flex w-fit gap-5">
            <Loader2 className="size-4 animate-spin" /> Connecting to MCP
            servers...
          </div>
        ) : (
          <div className="container mx-auto">
            <div
              className="mt-3 grid w-full items-start"
              style={{
                gridTemplateColumns: `repeat(${AGENTS.length}, minmax(0, 1fr))`,
              }}
            >
              {AGENTS.map(({ key, name }) => (
                <AgentColumn
                  key={key}
                  mcpClient={mcpClients[key]}
                  setup={setup}
                  serverName={MCP_SERVERS[key].name}
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
  mcpClient: McpClientType;
  setup: TestSetupResult;
  serverName: string;
  metrics?: TaskMetrics;
  onComplete: (metrics: TaskMetrics) => void;
}) {
  return (
    <div className="sticky top-0 mx-auto flex w-full max-w-4xl flex-col gap-8 px-6">
      <Agent mcpClient={mcpClient} setup={setup} onComplete={onComplete} />
      {metrics && metrics.finished && (
        <>
          <div className="border-border border-t" />
          <MetricOverview
            metrics={metrics}
            serverName={serverName}
            model={setup.config.model}
          />
        </>
      )}
    </div>
  );
}

function HeaderBar({
  isFinished,
  onBack,
  onRerun,
}: {
  onBack?: () => void;
  isFinished?: boolean;
  onRerun?: () => void;
}) {
  return (
    <header className="border-border bg-muted/40 absolute top-0 z-50 w-full border-b backdrop-blur-lg">
      <div className="flex w-full items-center px-20 py-3">
        <Button
          variant="ghost"
          className="hover:bg-accent/0 cursor-pointer gap-2"
          onClick={onBack}
        >
          <Bot className="text-muted-foreground size-5 stroke-[1.5]" />
          <h1 className="text-primary/90 text-center font-serif text-lg font-extralight">
            Agent playground & benchmark
          </h1>
        </Button>
        {isFinished && (
          <Button variant="outline" onClick={onRerun} className="ml-auto">
            <RotateCcw /> Rerun test case
          </Button>
        )}
      </div>
    </header>
  );
}
