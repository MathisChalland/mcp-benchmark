import { z } from "zod";
import { createTRPCRouter, protectedProcedure } from "@/server/api/trpc";
import { OpenRouter } from "@openrouter/sdk";
import { env } from "@/env";
import {
  LLM_MODELS,
  type LLMModelKey,
  effort,
} from "@/components/benchmark/setup/llm-models";

const openRouter = new OpenRouter({
  apiKey: env.OPENROUTER_API_KEY,
});

export const llmRouter = createTRPCRouter({
  chat: protectedProcedure
    .input(
      z.object({
        model: z.enum([...(Object.keys(LLM_MODELS) as LLMModelKey[])]),
        reasoning: effort,
        messages: z.array(z.any()),
        tools: z.array(z.any()).optional(),
      }),
    )
    .mutation(async ({ input }) => {
      const response = await openRouter.chat.send({
        model: input.model,
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        messages: input.messages,
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        tools: input.tools,
        reasoning: {
          effort: input.reasoning,
        },
      });

      return response;
    }),
});
