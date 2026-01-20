import { Clock, Cpu, MessageSquare, Wrench, Zap } from "lucide-react";
import type { TaskMetrics } from "@/hooks/useMetricTracker";
import { cn } from "@/lib/utils";

interface MetricOverviewProps {
  metrics: TaskMetrics | null;
  serverName?: string;
}

export function MetricOverview({ metrics, serverName }: MetricOverviewProps) {
  if (!metrics) {
    return null;
  }

  const formatDuration = (ms: number) => {
    if (ms < 1000) return `${ms}ms`;
    return `${(ms / 1000).toFixed(2)}s`;
  };

  const formatNumber = (num: number) => {
    return num.toLocaleString();
  };

  return (
    <div className="border-border bg-background overflow-hidden rounded-xl border">
      <div className="bg-muted flex items-center gap-2 border-b border-inherit px-4 py-2">
        <Zap className="text-muted-foreground size-4" />
        <span className="text-muted-foreground text-xs font-semibold tracking-wider uppercase">
          {serverName ?? "Metrics"}
        </span>
      </div>
      <div className="grid grid-cols-2 gap-3 p-4 sm:grid-cols-3">
        <MetricItem
          icon={Clock}
          label="Duration"
          value={formatDuration(metrics.durationMs)}
        />
        <MetricItem
          icon={MessageSquare}
          label="LLM Calls"
          value={metrics.llmCalls.toString()}
        />
        <MetricItem
          icon={Wrench}
          label="Tool Calls"
          value={metrics.toolCalls.toString()}
        />
        <MetricItem
          icon={Cpu}
          label="Total Tokens"
          value={formatNumber(metrics.totalTokens)}
        />
        <MetricItem
          icon={Cpu}
          label="Prompt Tokens"
          value={formatNumber(metrics.promptTokens)}
        />
        <MetricItem
          icon={Cpu}
          label="Completion Tokens"
          value={formatNumber(metrics.completionTokens)}
        />
      </div>
    </div>
  );
}

interface MetricItemProps {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string;
  subtle?: boolean;
}

function MetricItem({ icon: Icon, label, value, subtle }: MetricItemProps) {
  return (
    <div
      className={cn(
        "bg-muted/60 flex flex-col gap-1 rounded-lg p-3",
        subtle && "opacity-70",
      )}
    >
      <div className="flex items-center gap-1.5">
        <Icon className="text-muted-foreground size-3.5" />
        <span className="text-muted-foreground text-xs font-medium">
          {label}
        </span>
      </div>
      <span className="text-foreground text-lg font-semibold">{value}</span>
    </div>
  );
}
