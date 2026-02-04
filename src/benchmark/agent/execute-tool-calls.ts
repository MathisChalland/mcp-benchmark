import type { ToolContent } from "@/app/api/mcp/types";
import type {
  ChatCompletionMessageFunctionToolCall,
  ChatCompletionMessageParam,
} from "openai/resources";

interface Params {
  toolCalls: ChatCompletionMessageFunctionToolCall[];
  caller: Caller;
  onToolResult?: (
    toolCall: ChatCompletionMessageFunctionToolCall,
    result: ToolCallResult,
  ) => void;
}

type Caller = (
  toolName: string,
  args?: Record<string, unknown>,
) => Promise<{ content: ToolContent[] }>;

interface ToolCallResult {
  result: string;
  error?: boolean;
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
        role: "tool",
        tool_call_id: tc.id,
        content: result.result,
      };
    }),
  );
}

async function executeToolCall(
  toolCall: ChatCompletionMessageFunctionToolCall,
  caller: Caller,
): Promise<ToolCallResult> {
  try {
    const args = JSON.parse(toolCall.function.arguments) as Record<
      string,
      unknown
    >;
    const result = await caller(toolCall.function.name, args);
    const resultText = extractTextFromToolResult(result.content);
    return { result: resultText };
  } catch (err) {
    const errorMsg = err instanceof Error ? err.message : String(err);
    return {
      result: `Error calling ${toolCall.function.name}: ${errorMsg}`,
      error: true,
    };
  }
}

export function extractTextFromToolResult(content: ToolContent[]): string {
  return content
    .filter((c) => c.type === "text" && c.text)
    .map((c) => c.text)
    .join("\n");
}
