import { z } from "zod";
import OpenAI from "openai";
import { env } from "@/env";
import {
  LLM_MODELS,
  type LLMModelKey,
} from "@/components/benchmark/setup/llm-models";
import type {
  ChatCompletionMessageParam,
  ChatCompletionTool,
} from "openai/resources";

const OPENAI_MODELS: Record<string, string> = {
  "openai/gpt-5.2": "gpt-5.2-2025-12-11",
  "openai/gpt-5-mini": "gpt-5-mini-2025-08-07",
  "openai/gpt-5-nano": "gpt-5-nano-2025-08-07",
};

export const executeCallLLMSchema = z.object({
  model: z.enum([...(Object.keys(LLM_MODELS) as LLMModelKey[])]),
  messages: z.array(z.any()),
  tools: z.array(z.any()).optional(),
});

export type CallLLMInput = {
  model: LLMModelKey;
  messages: ChatCompletionMessageParam[];
  tools?: ChatCompletionTool[];
};

export async function executeLLMCall(input: CallLLMInput) {
  const isOpenAIModel = input.model.startsWith("openai/");

  const client = new OpenAI(
    isOpenAIModel
      ? { apiKey: env.OPENAI_API_KEY }
      : {
          baseURL: "https://openrouter.ai/api/v1",
          apiKey: env.OPENROUTER_API_KEY,
        },
  );

  const modelId = isOpenAIModel
    ? (OPENAI_MODELS[input.model] ?? input.model)
    : input.model;

  const response = await client.chat.completions.create({
    model: modelId,
    messages: input.messages,
    tools: input.tools,
    tool_choice: "auto",
  });

  return response;
}
