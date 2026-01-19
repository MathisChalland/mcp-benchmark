import type { AuthInfo } from "@modelcontextprotocol/sdk/server/auth/types.js";
import { auth } from "@/server/better-auth";

export const verifyMcpToken = async (
  req: Request,
  bearerToken?: string,
): Promise<AuthInfo | undefined> => {
  try {
    const session = await auth.api.getSession({
      headers: req.headers,
    });

    if (!session) {
      return undefined;
    }

    return {
      token: bearerToken || "session-based",
      scopes: ["mcp:execute"],
      clientId: session.user.id,
      extra: {
        userId: session.user.id,
        email: session.user.email,
        name: session.user.name,
      },
    };
  } catch (error) {
    console.error("MCP auth verification failed:", error);
    return undefined;
  }
};
