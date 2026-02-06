"use client";

import { createContext, useContext, useEffect, type ReactNode } from "react";
import { useMcpClient } from "@/hooks/useMcpClient";
import { CODE_GEN_SYSTEM_PROMPT } from "@/benchmark/mcp-server/code-gen";
import { TOOL_CALL_SYSTEM_PROMPT } from "@/benchmark/mcp-server/tool-calling";

export const MCP_SERVERS = {
  toolCall: { url: "/api/mcp/tool-call/mcp", name: "Tool Calling" },
  codeGen: { url: "/api/mcp/code-gen/mcp", name: "Code Generation" },
} as const;

export type McpClientType = ReturnType<typeof useMcpClient>;

interface McpClientContextValue {
  toolCall: McpClientType;
  codeGen: McpClientType;
  isConnected: boolean;
  isConnecting: boolean;
}

const McpClientContext = createContext<McpClientContextValue | null>(null);

export function McpClientProvider({ children }: { children: ReactNode }) {
  const toolCall = useMcpClient({
    serverUrl: MCP_SERVERS.toolCall.url,
    systemPrompt: TOOL_CALL_SYSTEM_PROMPT,
  });
  const codeGen = useMcpClient({
    serverUrl: MCP_SERVERS.codeGen.url,
    systemPrompt: CODE_GEN_SYSTEM_PROMPT,
  });

  const isConnected =
    toolCall.status === "connected" && codeGen.status === "connected";
  const isConnecting =
    toolCall.status === "connecting" || codeGen.status === "connecting";

  useEffect(() => {
    void Promise.all([toolCall.connect(), codeGen.connect()]);
  }, [toolCall, codeGen]);

  return (
    <McpClientContext.Provider
      value={{ toolCall, codeGen, isConnected, isConnecting }}
    >
      {children}
    </McpClientContext.Provider>
  );
}

export function useMcpClients() {
  const context = useContext(McpClientContext);
  if (!context) {
    throw new Error("useMcpClients must be used within a McpClientProvider");
  }
  return context;
}
