import {
  execute_code,
  executeCodeSchema,
} from "@/benchmark/tools/execute_code";
import { getToolsAPI } from "@/benchmark/tools/tools-api-def";
import { createMcpHandler } from "mcp-handler";

const handler = createMcpHandler(
  (server) => {
    server.registerTool(
      "execute_code",
      {
        title: "Execute Code",
        description: `Execute JavaScript code to solve the given task. The code will be wrapped in an async function an should always include a return statement with the final result.
  
  Within the code you have acces to the following functions which can be used directly:

  ${getToolsAPI()}

  The code should use these functions to gather data, process it, and return the final answer.
  Here is an example on how to retrieve a customer:

  const customer = await getCustomer({ customerId: 1 });
  return customer;`,
        ...executeCodeSchema,
      },
      async ({ code }) => {
        const output = await execute_code(code);
        return {
          content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
          structuredContent: output,
          isError: !!output.error,
        };
      },
    );
  },
  {},
  { basePath: "/api/mcp/code-gen", maxDuration: 60, verboseLogs: true },
);

export { handler as GET, handler as POST };
