import { createTRPCRouter, protectedProcedure } from "@/server/api/trpc";
import { executeCallLLMSchema, executeLLMCall } from "@/lib/execute-llm-call";

export const llmRouter = createTRPCRouter({
  chat: protectedProcedure
    .input(executeCallLLMSchema)
    .mutation(async ({ input }) => {
      return executeLLMCall(input);
    }),
});
