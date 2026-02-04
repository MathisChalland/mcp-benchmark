import type { ToolContent } from "@/app/api/mcp/types";
import { Client } from "@modelcontextprotocol/sdk/client";
import type {
  ChatCompletionMessageFunctionToolCall,
  ChatCompletionMessageParam,
} from "openai/resources";

interface Params {
  toolCalls: ChatCompletionMessageFunctionToolCall[];
  caller: ToolCaller;
  onToolResult?: (
    toolCall: ChatCompletionMessageFunctionToolCall,
    result: ToolCallResult,
  ) => void;
}

type TCaller = Client["callTool"];

export type ToolCaller = Client["callTool"];

export interface ToolCallResult {
  content: string;
  isError: boolean;
}

export async function executeToolCalls({
  toolCalls,
  caller,
  onToolResult,
}: Params): Promise<ChatCompletionMessageParam[]> {
  return Promise.all(
    toolCalls.map(async (tc) => {
      const result = await executeToolCall(tc, caller);
      onToolResult?.(tc, result);
      return {
        role: "tool" as const,
        tool_call_id: tc.id,
        content: result.content,
      };
    }),
  );
}

async function executeToolCall(
  toolCall: ChatCompletionMessageFunctionToolCall,
  caller: ToolCaller,
): Promise<ToolCallResult> {
  try {
    const args = JSON.parse(toolCall.function.arguments) as Record<
      string,
      unknown
    >;
    const response = await caller({
      name: toolCall.function.name,
      arguments: args,
    });

    const content = extractTextFromToolResult(
      response.content as ToolContent[],
    );

    return {
      content,
      isError: (response.isError as boolean) ?? false,
    };
  } catch (err) {
    return {
      content: err instanceof Error ? err.message : String(err),
      isError: true,
    };
  }
}

export function extractTextFromToolResult(content: ToolContent[]): string {
  return content
    .filter((c) => c.type === "text" && c.text)
    .map((c) => c.text)
    .join("\n");
}
