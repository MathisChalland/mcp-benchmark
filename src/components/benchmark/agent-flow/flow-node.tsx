import {
  CheckCircle2,
  Loader2,
  MessageSquare,
  Sparkles,
  Terminal,
  Wrench,
} from "lucide-react";
import { ToolCall } from "./tool-call";
import { cn } from "@/lib/utils";

interface ToolCallInfo {
  id: string;
  name: string;
  arguments: string;
  response?: string;
}

export type FlowNode =
  | { type: "request"; content: string }
  | { type: "thinking"; content: string }
  | { type: "response"; content: string }
  | { type: "tool-calls"; calls: ToolCallInfo[] }
  | { type: "llm-call"; callNumber: number; isLoading: boolean };

const flowNodeStyles = {
  blue: {
    card: "bg-[var(--color-primary-soft,var(--color-blue-50))] dark:bg-[var(--color-primary-soft,var(--color-blue-950))]",
    text: "text-[var(--color-primary-accent,var(--color-blue-700))] dark:text-[var(--color-primary-soft,var(--color-blue-600))]",
  },
  yellow: {
    card: "bg-[var(--color-warning-soft,var(--color-yellow-100))] dark:bg-[var(--color-warning-soft,var(--color-yellow-950))]",
    text: "text-[var(--color-warning-accent,var(--color-amber-400))] dark:text-[var(--color-warning-soft,var(--color-yellow-600))]",
  },
  green: {
    card: "bg-[var(--color-success-soft,var(--color-green-100))] dark:bg-[var(--color-success-soft,var(--color-green-950))]",
    text: "text-[var(--color-success-accent,var(--color-green-800))] dark:text-[var(--color-success-soft,var(--color-green-600))]",
  },
  violet: {
    card: "bg-[var(--color-info-soft,var(--color-violet-100))] dark:bg-[var(--color-info-soft,var(--color-violet-950))]",
    text: "text-[var(--color-info-accent,var(--color-violet-700))] dark:text-[var(--color-info-soft,var(--color-violet-400))]",
  },
} as const;

type FlowNodeColor = keyof typeof flowNodeStyles;

interface NodeCardProps {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  content: React.ReactNode;
  color?: FlowNodeColor;
  className?: string;
}

function FlowNodeCard({
  icon: Icon,
  label,
  content,
  color = "blue",
  className,
}: NodeCardProps) {
  const styles = flowNodeStyles[color];

  return (
    <div
      className={cn(
        "border-border bg-background overflow-hidden rounded-xl border",
        className,
      )}
    >
      <div
        className={cn(
          "flex items-center gap-2 border-b border-inherit px-4 py-2",
          styles.text,
          styles.card,
        )}
      >
        <Icon className="size-4" />
        <span className="text-xs font-semibold tracking-wider uppercase">
          {label}
        </span>
      </div>
      <div className="p-4">{content}</div>
    </div>
  );
}

export function FlowNode({ node }: { node: FlowNode }) {
  if (node.type === "request") {
    return (
      <FlowNodeCard
        icon={Terminal}
        label="Task"
        color="blue"
        content={
          <p className="text-sm leading-relaxed whitespace-pre-wrap text-slate-700">
            {node.content}
          </p>
        }
      />
    );
  }

  if (node.type === "thinking") {
    return (
      <FlowNodeCard
        icon={Sparkles}
        label="Thinking"
        content={
          <p className="text-muted-foreground text-sm leading-relaxed whitespace-pre-wrap italic">
            {node.content}
          </p>
        }
      />
    );
  }

  if (node.type === "response") {
    return (
      <FlowNodeCard
        icon={MessageSquare}
        label="Response"
        content={
          <p className="text-sm leading-relaxed whitespace-pre-wrap">
            {node.content}
          </p>
        }
      />
    );
  }

  if (node.type === "tool-calls") {
    return (
      <FlowNodeCard
        icon={Wrench}
        color="green"
        label="Tool Calls"
        content={
          <div className="flex flex-wrap gap-2">
            {node.calls.map((call) => (
              <ToolCall key={call.id} call={call} />
            ))}
          </div>
        }
      />
    );
  }

  if (node.type === "llm-call") {
    return (
      <div className="py-6">
        <div className="flex items-center gap-4">
          <div className="from-border via-border h-px flex-1 bg-linear-to-r to-transparent" />
          <LlmCallBlock
            isLoading={node.isLoading}
            callNumber={node.callNumber}
          />
          <div className="via-border to-border h-px flex-1 bg-linear-to-r from-transparent" />
        </div>
      </div>
    );
  }

  return null;
}

interface LlmCallBlockProps {
  isLoading: boolean;
  callNumber: number;
}

export function LlmCallBlock({ isLoading, callNumber }: LlmCallBlockProps) {
  return (
    <button
      className={cn(
        `group bg-background border-border flex items-center gap-2 rounded-lg border px-3 py-2 transition-all ${
          !isLoading ? "cursor-pointer" : "cursor-wait"
        } `,
        flowNodeStyles.violet.text,
        flowNodeStyles.violet.card,
      )}
      disabled={!isLoading}
    >
      {isLoading ? (
        <Loader2 className="size-3.5 animate-spin" />
      ) : (
        <CheckCircle2 className="size-3.5" />
      )}
      <span className="font-mono text-xs">LLM CALL {callNumber}</span>
    </button>
  );
}
