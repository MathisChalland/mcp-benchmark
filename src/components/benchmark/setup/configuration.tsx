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
import { Separator } from "@/components/ui/separator";
import { MCP_SERVERS } from "@/contexts/useMcpClientContext";

interface ConfigurationProps {
  model: string;
  thinking: boolean;
  mcpServer: Record<keyof typeof MCP_SERVERS, boolean>;
  onChange: (updates: Partial<TestSetupConfig>) => void;
}

export function Configuration({
  model,
  thinking,
  mcpServer,
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

          <Separator />

          {Object.entries(MCP_SERVERS).map(([key, server]) => (
            <ToggleOption
              key={key}
              label={server.name}
              isEnabled={mcpServer[key as keyof typeof MCP_SERVERS]}
              onToggle={(enabled) =>
                onChange({
                  mcpServer: {
                    ...mcpServer,
                    [key]: enabled,
                  },
                })
              }
            />
          ))}
        </div>
      </PopoverContent>
    </Popover>
  );
}
