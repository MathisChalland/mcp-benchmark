import { createMcpHandler, withMcpAuth } from "mcp-handler";
import { verifyMcpToken } from "../../verify-token";
import { setupCodeGenServer } from "@/benchmark/mcp-server/code-gen";

const handler = createMcpHandler(
  (server) => {
    setupCodeGenServer(server);
  },
  {},
  { basePath: "/api/mcp/code-gen", maxDuration: 60, verboseLogs: true },
);

const authHandler = withMcpAuth(handler, verifyMcpToken, {
  required: true,
  requiredScopes: ["mcp:execute"],
});

export { authHandler as GET, authHandler as POST };
