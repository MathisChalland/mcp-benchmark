import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { SelectOption } from "./select-option";
import { ToggleOption } from "./toggle-option";
import { Button } from "@/components/ui/button";
import { Settings2 } from "lucide-react";
import type { TestSetupConfig } from "./useTestSetup";

interface ConfigurationProps {
  model: string;
  thinking: boolean;
  mcpServerUrl: string;
  onChange: (updates: Partial<TestSetupConfig>) => void;
}

export function Configuration({
  model,
  thinking,
  mcpServerUrl,
  onChange,
}: ConfigurationProps) {
  return (
    <Popover modal>
      <PopoverTrigger asChild>
        <Button
          size="sm"
          variant="ghost"
          className="aria-expanded:bg-accent aria-expanded:text-accent-foreground text-primary/85"
        >
          <Settings2 />
          Configuration
        </Button>
      </PopoverTrigger>
      <PopoverContent
        align="start"
        className="flex w-80 flex-col rounded-lg px-2.5 py-2.5"
      >
        <div className="flex w-full flex-col gap-2">
          <SelectOption
            label="Model"
            options={[
              { value: "gpt-5.1-2025-11-13", label: "GPT-5.1" },
              { value: "gpt-4o-mini", label: "GPT-4o Mini" },
              { value: "claude-sonnet-4-20250514", label: "Claude Sonnet 4" },
            ]}
            selectedValue={model}
            onChange={(value) => onChange({ model: value })}
            side="right"
          />

          <ToggleOption
            label="Use thinking"
            isEnabled={thinking}
            onToggle={(value) => onChange({ thinking: value })}
          />

          <SelectOption
            label="MCP Server"
            options={[
              { value: "/api/mcp/tool-call/mcp", label: "Tool Call MCP" },
              { value: "/api/mcp/code-gen/mcp", label: "Code Gen MCP" },
            ]}
            selectedValue={mcpServerUrl}
            onChange={(value) => onChange({ mcpServerUrl: value })}
            side="right"
          />
        </div>
      </PopoverContent>
    </Popover>
  );
}
