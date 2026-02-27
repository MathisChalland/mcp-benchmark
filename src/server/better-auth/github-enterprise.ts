import { env } from "@/env";
import type { GenericOAuthConfig } from "better-auth/plugins";

export const githubEnterpriseProvider: GenericOAuthConfig = {
  providerId: "github-enterprise",
  clientId: env.GITHUB_ENTERPRISE_CLIENT_ID,
  clientSecret: env.GITHUB_ENTERPRISE_CLIENT_SECRET,
  redirectURI: `${env.BETTER_AUTH_URL}/api/auth/callback/github-enterprise`,
  authorizationUrl: `${env.GITHUB_ENTERPRISE_URL}/login/oauth/authorize`,
  tokenUrl: `${env.GITHUB_ENTERPRISE_URL}/login/oauth/access_token`,
  userInfoUrl: `${env.GITHUB_ENTERPRISE_URL}/api/v3/user`,
  scopes: ["user:email"],
};
