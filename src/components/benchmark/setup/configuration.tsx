import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { SelectOption, type GroupedSelectOptionType } from "./select-option";
import { ToggleOption } from "./toggle-option";
import { Button } from "@/components/ui/button";
import { Settings2 } from "lucide-react";
import { type TestSetupConfig } from "./useTestSetup";
import { Separator } from "@/components/ui/separator";
import { MCP_SERVERS } from "@/contexts/useMcpClientContext";
import {
  effort,
  LLM_MODELS,
  type Effort,
  type LLMModelKey,
} from "@/components/benchmark/setup/llm-models";

interface ConfigurationProps {
  model: string;
  reasoning: Effort;
  mcpServer: Record<keyof typeof MCP_SERVERS, boolean>;
  onChange: (updates: Partial<TestSetupConfig>) => void;
}

export function Configuration({
  model,
  reasoning,
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
            groupedOptions={getGroupedModelOptions()}
            selectedValue={model}
            onChange={(value) => onChange({ model: value })}
            side="right"
          />

          <SelectOption
            label="Reasoning effort"
            options={effort.options.map((e) => ({
              value: e,
              label: e.charAt(0).toUpperCase() + e.slice(1),
            }))}
            selectedValue={reasoning}
            onChange={(value) => onChange({ reasoning: value })}
            side="right"
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

export function getGroupedModelOptions(): GroupedSelectOptionType<LLMModelKey>[] {
  const providers = [
    { key: "anthropic", label: "Anthropic" },
    { key: "openai", label: "OpenAI" },
    { key: "google", label: "Google" },
  ];

  return providers.map(({ key, label }) => ({
    groupLabel: label,
    options: Object.entries(LLM_MODELS)
      .filter(([modelKey]) => modelKey.startsWith(`${key}/`))
      .map(([modelKey, model]) => ({
        value: modelKey as LLMModelKey,
        label: model.name,
      })),
  }));
}
