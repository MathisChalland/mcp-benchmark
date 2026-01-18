import { z } from "zod";
import { createTRPCRouter, protectedProcedure } from "@/server/api/trpc";
import OpenAI from "openai";

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export const llmRouter = createTRPCRouter({
  chat: protectedProcedure
    .input(
      z.object({
        model: z.string(),
        messages: z.array(z.any()),
        tools: z.array(z.any()).optional(),
      }),
    )
    .mutation(async ({ input }) => {
      const response = await openai.chat.completions.create({
        model: input.model,
        messages: input.messages,
        tools: input.tools,
        tool_choice: "auto",
      });

      return response;
    }),
});
