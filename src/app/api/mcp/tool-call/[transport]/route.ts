import { createMcpHandler, withMcpAuth } from "mcp-handler";
import { verifyMcpToken } from "../../verify-token";
import { setupToolCallServer } from "@/benchmark/mcp-server/tool-calling";

const handler = createMcpHandler(
  (server) => {
    setupToolCallServer(server);
  },
  {},
  { basePath: "/api/mcp/tool-call", maxDuration: 60, verboseLogs: true },
);

const authHandler = withMcpAuth(handler, verifyMcpToken, {
  required: true,
  requiredScopes: ["mcp:execute"],
});

export { authHandler as GET, authHandler as POST };
