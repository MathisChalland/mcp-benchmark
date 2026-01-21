import { useCallback, useEffect, useRef, useState } from "react";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";

export interface Tool {
  name: string;
  description?: string;
  inputSchema?: Record<string, unknown>;
}

type ConnectionStatus = "idle" | "connecting" | "connected" | "error";

interface UseMcpClientOptions {
  serverUrl: string;
  systemPrompt?: string;
}

export function useMcpClient({ serverUrl,systemPrompt }: UseMcpClientOptions) {
  const [tools, setTools] = useState<Tool[]>([]);
  const [status, setStatus] = useState<ConnectionStatus>("idle");
  const [error, setError] = useState<string | null>(null);

  const clientRef = useRef<Client | null>(null);

  const connect = useCallback(async () => {
    if (clientRef.current) return;

    setStatus("connecting");
    setError(null);

    try {
      const client = new Client({ name: "mcp-client", version: "1.0.0" });
      const transport = new StreamableHTTPClientTransport(
        new URL(serverUrl, window.location.origin),
      );

      await client.connect(transport);
      clientRef.current = client;

      const { tools } = await client.listTools();
      setTools(tools as Tool[]);
      setStatus("connected");
    } catch (err) {
      console.error("Failed to connect:", err);
      setError(err instanceof Error ? err.message : "Connection failed");
      setStatus("error");
      clientRef.current = null;
    }
  }, [serverUrl]);

  const callTool = useCallback(
    async <T = unknown>(
      toolName: string,
      args: Record<string, unknown> = {},
    ): Promise<T> => {
      if (!clientRef.current) {
        throw new Error("Not connected");
      }
      const result = await clientRef.current.callTool({
        name: toolName,
        arguments: args,
      });
      return result as T;
    },
    [],
  );

  const refreshTools = useCallback(async () => {
    if (!clientRef.current) return;
    const { tools } = await clientRef.current.listTools();
    setTools(tools as Tool[]);
  }, []);

  useEffect(() => {
    return () => {
      if (clientRef.current) {
        clientRef.current.close().catch(console.error);
      }
    };
  }, []);

  const disconnect = useCallback(async () => {
    if (!clientRef.current) return;

    try {
      await clientRef.current.close();
    } catch (err) {
      console.error("Error during disconnect:", err);
    } finally {
      clientRef.current = null;
      setTools([]);
      setStatus("idle");
      setError(null);
    }
  }, []);

  return {
    tools,
    status,
    error,
    systemPrompt,

    connect,
    callTool,
    refreshTools,
    disconnect,
  };
}
