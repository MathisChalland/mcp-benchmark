import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import {
  Loader2,
  CheckCircle2,
  Clock,
  ChevronRight,
  Wrench,
  X,
} from "lucide-react";
import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { CodeBlock } from "../code";
import { cn } from "@/lib/utils";
import { formatJs } from "@/lib/format-code";

export interface ToolCallInfo {
  id: string;
  name: string;
  arguments: string;
  response?: string;
  error?: string;
}

function parseToolResponse(response?: string): {
  error?: string;
  result?: string;
} {
  if (!response) return {};

  try {
    const parsed = JSON.parse(response) as unknown;
    if (
      parsed &&
      typeof parsed === "object" &&
      "error" in parsed &&
      parsed.error
    ) {
      const typedParsed = parsed as { error: unknown; result?: unknown };
      return {
        error:
          typeof typedParsed.error === "string"
            ? typedParsed.error
            : JSON.stringify(typedParsed.error, null, 2),
        result: typedParsed.result
          ? JSON.stringify(typedParsed.result, null, 2)
          : undefined,
      };
    }
  } catch {}

  return { result: response };
}

function formatCode(code: string, language: "json" | "javascript") {
  if (language === "javascript") return formatJs(code);
  try {
    return JSON.stringify(JSON.parse(code), null, 2);
  } catch {
    return code;
  }
}

export function ToolCall({ call }: { call: ToolCallInfo }) {
  const [isOpen, setIsOpen] = useState(false);
  const isLoading = !call.response && !call.error;
  const { result, error } = parseToolResponse(call.response);
  const errorMessage = call.error ?? error;
  const canOpen = (result ?? errorMessage) && !isLoading;

  const getArguments = (): string => {
    if (call.name !== "execute_code") return call.arguments;
    try {
      const parsed = JSON.parse(call.arguments) as unknown;
      if (parsed && typeof parsed === "object" && "code" in parsed) {
        const typedParsed = parsed as { code?: string };
        return typedParsed.code ?? call.arguments;
      }
      return call.arguments;
    } catch {
      return call.arguments;
    }
  };

  const StatusIcon = () => {
    if (isLoading) return <Loader2 className="h-3.5 w-3.5 animate-spin" />;
    if (errorMessage) return <X className="text-destructive h-3.5 w-3.5" />;
    if (result)
      return <CheckCircle2 className="h-3.5 w-3.5 text-emerald-500" />;
    return <Clock className="text-muted-foreground h-3.5 w-3.5" />;
  };

  return (
    <Popover open={isOpen} onOpenChange={setIsOpen}>
      <PopoverTrigger asChild>
        <button
          className={cn(
            "group bg-secondary border-border flex items-center gap-2 rounded-lg border px-3 py-2 transition-all",
            isLoading && "animate-pulse",
            !!errorMessage &&
              !isLoading &&
              "border-destructive/50 bg-destructive/10",
            canOpen && "hover:bg-secondary/80 cursor-pointer",
          )}
          disabled={isLoading}
        >
          <StatusIcon />
          <span className="font-mono text-xs">{call.name}</span>
          {canOpen && (
            <ChevronRight className="text-muted-foreground group-hover:text-foreground h-3 w-3 transition-colors" />
          )}
        </button>
      </PopoverTrigger>

      {canOpen && (
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
                  !!errorMessage ? "text-destructive" : "text-emerald-500",
                )}
              />
              <span className="font-mono text-sm font-medium">{call.name}</span>
            </div>
            <Badge
              variant="secondary"
              className={cn(
                "text-[10px]",
                !!errorMessage
                  ? "bg-destructive/10 text-destructive"
                  : "bg-emerald-100 text-emerald-700",
              )}
            >
              {!!errorMessage ? "Failed" : "Completed"}
            </Badge>
          </div>

          <ContentBlock
            code={getArguments()}
            language={call.name === "execute_code" ? "javascript" : "json"}
            label="Arguments"
            border
          />

          {result && (
            <ContentBlock code={result} label="Response" language="json" />
          )}
          {errorMessage && (
            <ContentBlock
              code={errorMessage}
              label="Error"
              language="json"
              isError
            />
          )}
        </PopoverContent>
      )}
    </Popover>
  );
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
