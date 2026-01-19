import { useMcpClient } from "@/hooks/useMcpClient";
import type { TestSetupResult } from "./setup/useTestSetup";
import { useEffect } from "react";
import { FlowNode } from "./agent-flow/flow-node";
import { Agent } from "./agent";
import { Bot, Loader2 } from "lucide-react";
import { Button } from "../ui/button";

interface Props {
  setup: TestSetupResult;
  onNewSetup?: () => void;
}

export function RunTestcase({ setup, onNewSetup }: Props) {
  const toolCallMcp = useMcpClient({ serverUrl: "/api/mcp/tool-call/mcp" });
  const codeGenMcp = useMcpClient({ serverUrl: "/api/mcp/code-gen/mcp" });

  useEffect(() => {
    async function run() {
      await toolCallMcp.connect();
      await codeGenMcp.connect();
    }
    run();
  }, [toolCallMcp, codeGenMcp]);

  return (
    <div className="bg-muted max-h-dvh w-full">
      <HeaderBar onNewSetup={onNewSetup} />
      <div className="max-h-dvh overflow-auto pt-16">
        <div className="mx-auto max-w-4xl px-6 pt-8">
          <FlowNode node={{ type: "request", content: setup.prompt }} />
        </div>
        {toolCallMcp.status !== "connected" ||
        codeGenMcp.status !== "connected" ? (
          <div className="mx-auto mt-5 flex w-fit gap-5">
            <Loader2 className="size-4 animate-spin" /> Connecting to MCP
            servers...
          </div>
        ) : (
          <div className="container mx-auto">
            <div className="mt-3 grid w-full grid-cols-2">
              <Agent mcpClient={toolCallMcp} setup={setup} />
              <Agent mcpClient={codeGenMcp} setup={setup} />
            </div>
          </div>
        )}
      </div>
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
