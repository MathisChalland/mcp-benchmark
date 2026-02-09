import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Loader2, CheckCircle2, ChevronRight, Wrench, X } from "lucide-react";
import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { CodeBlock } from "../code";
import { cn } from "@/lib/utils";
import { formatJs } from "@/lib/format-code";
import type { ToolCallResult } from "@/benchmark/agent/execute-tool-calls";
import type { ChatCompletionMessageFunctionToolCall } from "openai/resources";

export type ToolCallWithResult = ChatCompletionMessageFunctionToolCall & {
  result?: ToolCallResult;
};

export function ToolCall({ call }: { call: ToolCallWithResult }) {
  const [isOpen, setIsOpen] = useState(false);
  const isLoading = !call.result;
  const isError = call.result?.isError ?? false;
  const content = call.result?.content;
  const name = call.function.name;
  const isCodeExecution = name === "execute_code";

  const getArguments = (): string => {
    if (!isCodeExecution) return call.function.arguments;
    try {
      const parsed = JSON.parse(call.function.arguments) as { code?: string };
      return parsed.code ?? call.function.arguments;
    } catch {
      return call.function.arguments;
    }
  };

  const StatusIcon = () => {
    if (isLoading) return <Loader2 className="h-3.5 w-3.5 animate-spin" />;
    if (isError) return <X className="text-destructive h-3.5 w-3.5" />;
    return <CheckCircle2 className="h-3.5 w-3.5 text-emerald-500" />;
  };

  return (
    <Popover open={isOpen} onOpenChange={setIsOpen}>
      <PopoverTrigger asChild>
        <button
          className={cn(
            "group bg-secondary border-border flex items-center gap-2 rounded-lg border px-3 py-2 transition-all",
            isLoading && "animate-pulse",
            isError && !isLoading && "border-destructive/50 bg-destructive/10",
            !isLoading && "hover:bg-secondary/80 cursor-pointer",
          )}
          disabled={isLoading}
        >
          <StatusIcon />
          <span className="font-mono text-xs">{name}</span>
          {!isLoading && (
            <ChevronRight className="text-muted-foreground group-hover:text-foreground h-3 w-3 transition-colors" />
          )}
        </button>
      </PopoverTrigger>

      {!isLoading && (
        <PopoverContent
          className="bg-background mb-5 min-h-fit w-fit max-w-2xl min-w-125 overflow-hidden p-0"
          align="start"
          side="right"
        >
          <div className="flex items-center justify-between border-b p-3">
            <div className="flex items-center gap-2">
              <Wrench
                className={cn(
                  "size-4",
                  isError ? "text-destructive" : "text-emerald-500",
                )}
              />
              <span className="font-mono text-sm font-medium">{name}</span>
            </div>
            <Badge
              variant="secondary"
              className={cn(
                "text-[10px]",
                isError
                  ? "bg-destructive/10 text-destructive"
                  : "bg-emerald-100 text-emerald-700",
              )}
            >
              {isError ? "Failed" : "Completed"}
            </Badge>
          </div>

          <ContentBlock
            code={getArguments()}
            language={isCodeExecution ? "javascript" : "json"}
            label="Arguments"
            border={!!content}
          />

          {content && (
            <ContentBlock
              code={content}
              language="json"
              label={isError ? "Error" : "Response"}
              isError={isError}
            />
          )}
        </PopoverContent>
      )}
    </Popover>
  );
}

function formatCode(code: string, language: "json" | "javascript"): string {
  if (language === "javascript") return formatJs(code);
  try {
    return JSON.stringify(JSON.parse(code), null, 2);
  } catch {
    return code;
  }
}

function ContentBlock({
  code,
  label,
  border,
  language,
  isError,
}: {
  code: string;
  label: string;
  border?: boolean;
  language: "json" | "javascript";
  isError?: boolean;
}) {
  return (
    <div
      className={cn("p-3", border && "border-b", isError && "bg-destructive/5")}
    >
      <div
        className={cn(
          "mb-2 text-xs font-medium tracking-wider uppercase",
          isError ? "text-destructive" : "text-muted-foreground",
        )}
      >
        {label}
      </div>
      <CodeBlock
        code={formatCode(code, language)}
        language={language}
        maxHeight="25rem"
      />
    </div>
  );
}
