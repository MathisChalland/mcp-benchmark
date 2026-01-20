import z from "zod";

export const LLM_MODELS = {
  "anthropic/claude-opus-4.5": {
    name: "Claude Opus 4.5",
    supportsReasoning: true,
    tokenCost: {
      input: 5,
      output: 25,
    },
    contextWindow: 200,
  },
  "anthropic/claude-sonnet-4.5": {
    name: "Claude Sonnet 4.5",
    supportsReasoning: true,
    tokenCost: {
      input: 3,
      output: 15,
    },
    contextWindow: 200,
  },
  "anthropic/claude-haiku-4.5": {
    name: "Claude Haiku 4.5",
    supportsReasoning: true,
    tokenCost: {
      input: 1,
      output: 5,
    },
    contextWindow: 200,
  },
  "openai/gpt-5.2": {
    name: "GPT-5.2",
    supportsReasoning: true,
    tokenCost: {
      input: 1.75,
      output: 14,
    },
    contextWindow: 400,
  },
  "openai/gpt-5-mini": {
    name: "GPT-5 Mini",
    supportsReasoning: true,
    tokenCost: {
      input: 0.25,
      output: 2,
    },
    contextWindow: 400,
  },
  "openai/gpt-5-nano": {
    name: "GPT-5 Nano",
    supportsReasoning: true,
    tokenCost: {
      input: 0.05,
      output: 0.4,
    },
    contextWindow: 400,
  },
  "google/gemini-3-pro-preview": {
    name: "Gemini 3 Pro",
    supportsReasoning: true,
    tokenCost: {
      input: 2,
      output: 12,
    },
    contextWindow: 1050,
  },
  "google/gemini-3-flash-preview": {
    name: "Gemini 3 Flash",
    supportsReasoning: true,
    tokenCost: {
      input: 0.5,
      output: 3,
    },
    contextWindow: 1050,
  },
} as const;

export type LLMModelKey = keyof typeof LLM_MODELS;

export const effort = z.enum([
  "none",
  "minimal",
  "low",
  "medium",
  "high",
  "xhigh",
]);
export type Effort = z.infer<typeof effort>;
