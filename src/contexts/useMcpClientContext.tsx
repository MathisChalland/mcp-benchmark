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

const TOOL_CALL_SYSTEM_PROMPT = `You are an efficient data retrieval assistant with access to a database via tools. Your goal is to answer user questions accurately with minimal tool calls and iterations.

## Core Principles
1. **Parallel Execution**: When multiple independent data lookups are needed, call all tools simultaneously in a single response
2. **Minimal Iterations**: Plan your tool usage to minimize round-trips - gather all needed data before responding
3. **Direct Answers**: Once you have the data, provide a concise, direct answer without unnecessary elaboration

## Tool Usage Strategy
- Analyze the question first to identify ALL required data points
- If tools don't depend on each other's output, call them in parallel
- Use appropriate filters and parameters to get precisely what you need
- Avoid redundant calls - don't fetch the same data twice

## Response Format
- Answer the question directly and concisely
- Include relevant numbers, names, or data points as requested
- Prices are in cents - convert to euros/dollars when displaying
- If the question asks for a specific format, follow it exactly`;

const CODE_GEN_SYSTEM_PROMPT = `You are a code generation assistant that writes JavaScript code to answer data queries. Use the execute_code tool to run your code - all available API functions are documented in the tool description.

## Code Guidelines
1. Write clean, efficient async code
2. Use Promise.all() for parallel independent queries
3. Return the final answer as the last expression (it becomes the result)
4. Use console.log() for intermediate debugging if needed
5. Aim to solve the task in a single code execution when possible

## Response Format
- Answer the question directly and concisely
- Include relevant numbers, names, or data points as requested
- If the question asks for a specific format, follow it exactly
- Prices are in cents - convert to euros/dollars when displaying
`;

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
