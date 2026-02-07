import type { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import {
  execute_code,
  executeCodeToolDefinition,
} from "@/benchmark/code-approach/execute_code";

export function setupCodeGenServer(server: McpServer) {
  server.registerTool(
    "execute_code",
    executeCodeToolDefinition,
    async ({ code }) => {
      const output = await execute_code(code);
      return {
        content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
        isError: !!output.error,
      };
    },
  );
}
