"use client";

import { createContext, useContext, useEffect, type ReactNode } from "react";
import { useMcpClient } from "@/hooks/useMcpClient";

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
  const toolCall = useMcpClient({ serverUrl: MCP_SERVERS.toolCall.url });
  const codeGen = useMcpClient({ serverUrl: MCP_SERVERS.codeGen.url });

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
