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

export const CODE_GEN_SYSTEM_PROMPT = `You are a code generation assistant that writes JavaScript code to answer data queries. Use the execute_code tool to run your code - all available API functions are documented in the tool description.

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
`;
