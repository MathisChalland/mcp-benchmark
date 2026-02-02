import { createMcpHandler, withMcpAuth } from "mcp-handler";
import { verifyMcpToken } from "../../verify-token";
import {
  execute_code,
  executeCodeSchema,
} from "@/benchmark/code-approach/execute_code";
import { getToolsAPI } from "@/benchmark/code-approach/api";

const handler = createMcpHandler(
  (server) => {
    server.registerTool(
      "execute_code",
      {
        title: "Execute Code",
        description: `Execute JavaScript code to solve the given task.

IMPORTANT: Your code is executed directly as the body of an async function - do NOT wrap it in another function.
Write your code as if you are already inside an async function body.

WRONG - Do not do this:
async function main() {
  const product = await getProductById({ productId: 1 });
  const supplier = await getSupplierById({ supplierId: product.supplierId });
  return { productName: product.name, supplierName: supplier.companyName };
}
main();

CORRECT - Write code directly like this:
const product = await getProductById({ productId: 1 });
const supplier = await getSupplierById({ supplierId: product.supplierId });
return { productName: product.name, supplierName: supplier.companyName };

Your code can use await directly and must end with a return statement containing the final result.

Available functions (already in scope, use directly):
${getToolsAPI()}
`,
        ...executeCodeSchema,
      },
      async ({ code }) => {
        const output = await execute_code(code);
        return {
          content: [{ type: "text", text: JSON.stringify(output, null, 2) }],
          isError: !!output.error,
        };
      },
    );
  },
  {},
  { basePath: "/api/mcp/code-gen", maxDuration: 60, verboseLogs: true },
);

const authHandler = withMcpAuth(handler, verifyMcpToken, {
  required: true,
  requiredScopes: ["mcp:execute"],
});

export { authHandler as GET, authHandler as POST };
