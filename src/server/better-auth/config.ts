import { betterAuth } from "better-auth";
import { prismaAdapter } from "better-auth/adapters/prisma";
import { APIError } from "better-auth/api";

import { env } from "@/env";
import { db } from "@/server/db";
import { nextCookies } from "better-auth/next-js";
import { genericOAuth } from "better-auth/plugins";
import { githubEnterpriseProvider } from "./github-enterprise";

export const auth = betterAuth({
  database: prismaAdapter(db, {
    provider: "postgresql", // or "sqlite" or "mysql"
  }),
  databaseHooks: {
    user: {
      create: {
        before: async (user) => {
          const email = user.email.toLowerCase();
          const domain = email.substring(email.indexOf("@"));

          const whitelisted = await db.whitelist.findFirst({
            where: {
              OR: [{ email }, { email: domain }],
            },
          });

          if (!whitelisted) {
            throw new APIError("FORBIDDEN", {
              message: "Email is not whitelisted for signup",
            });
          }

          return { data: user };
        },
      },
    },
  },
  session: {
    cookieCache: {
      enabled: true,
      maxAge: 60 * 60, // Cache duration in seconds
    },
    expiresIn: 60 * 60 * 24 * 14, // 14 days
    updateAge: 60 * 60 * 24, // 1 day (every 1 day the session expiration is updated)
  },
  socialProviders: {
    github: {
      clientId: env.BETTER_AUTH_GITHUB_CLIENT_ID,
      clientSecret: env.BETTER_AUTH_GITHUB_CLIENT_SECRET,
      redirectURI: `${env.BETTER_AUTH_URL}/api/auth/callback/github`,
    },
  },
  plugins: [
    nextCookies(),
    genericOAuth({
      config: [githubEnterpriseProvider],
    }),
  ],
});

export type Session = typeof auth.$Infer.Session;
