import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { InMemoryTransport } from "@modelcontextprotocol/sdk/inMemory.js";
import { setupToolCallServer } from "../mcp-server/tool-calling";
import { setupCodeGenServer } from "../mcp-server/code-gen";
import type { Tool } from "@modelcontextprotocol/sdk/types.js";
import type { AgentType } from "../agent/agents";

interface McpSetup {
  client: Client;
  server: McpServer;
  tools: Tool[];
  cleanup: () => Promise<void>;
}

export async function setupMcpServer(agentType: AgentType): Promise<McpSetup> {
  const serverName =
    agentType === "tool-calling" ? "tool-calling-server" : "code-gen-server";

  const server = new McpServer({
    name: serverName,
    version: "1.0.0",
  });

  if (agentType === "tool-calling") {
    setupToolCallServer(server);
  } else {
    setupCodeGenServer(server);
  }

  const [clientTransport, serverTransport] =
    InMemoryTransport.createLinkedPair();

  const client = new Client({
    name: `${serverName}-client`,
    version: "1.0.0",
  });

  await Promise.all([
    client.connect(clientTransport),
    server.server.connect(serverTransport),
  ]);

  const toolsResult = await client.listTools();
  const tools = toolsResult.tools;

  const cleanup = async () => {
    await client.close();
    await server.server.close();
  };

  return {
    client,
    server,
    tools,
    cleanup,
  };
}

export interface BenchmarkAgentSetup {
  agentType: AgentType;
  client: Client;
  tools: Tool[];
  cleanup: () => Promise<void>;
}

export async function setupBenchmarkAgents(
  agentTypes: AgentType[],
): Promise<BenchmarkAgentSetup[]> {
  try {
    return await Promise.all(
      agentTypes.map(async (agentType) => {
        const mcpSetup = await setupMcpServer(agentType);
        return {
          agentType,
          client: mcpSetup.client,
          tools: mcpSetup.tools,
          cleanup: mcpSetup.cleanup,
        };
      }),
    );
  } catch (error) {
    console.error("Failed to setup benchmark agents:", error);
    throw error;
  }
}
