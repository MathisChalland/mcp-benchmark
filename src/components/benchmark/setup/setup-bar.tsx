import { useEffect, useRef } from "react";
import { Select } from "./select-option";
import { Button } from "@/components/ui/button";
import { ArrowUp, X } from "lucide-react";
import { Configuration } from "./configuration";
import { cn } from "@/lib/utils";
import { tests } from "@/benchmark/test-cases";
import { useTestSetup, type TestSetupResult } from "./useTestSetup";

interface SetupBarProps {
  setup: ReturnType<typeof useTestSetup>;
  onSubmit: (result: TestSetupResult) => void;
}

export function SetupBar({ setup, onSubmit }: SetupBarProps) {
  const {
    prompt,
    isTestCase,
    selectedTestId,
    config,
    canSubmit,
    handlePromptChange,
    selectTestCase,
    clearTestCase,
    updateConfig,
    getResult,
  } = setup;

  const textareaRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    const textarea = textareaRef.current;
    if (textarea) {
      textarea.style.height = "auto";
      textarea.style.height = textarea.scrollHeight + "px";
    }
  }, [prompt]);

  const handleSubmit = () => {
    if (canSubmit) {
      onSubmit(getResult());
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === "Enter" && !e.shiftKey && canSubmit) {
      e.preventDefault();
      handleSubmit();
    }
  };

  return (
    <div className="border-border bg-background flex w-full rounded-xl border p-3.5">
      <div className="flex w-full flex-col gap-5">
        <textarea
          ref={textareaRef}
          className="placeholder:text-muted-foreground h-fit min-h-6 w-full resize-none bg-transparent pl-1 font-light outline-none"
          placeholder="Type a prompt or select a test case ..."
          value={prompt}
          onChange={(e) => handlePromptChange(e.target.value)}
          onKeyDown={handleKeyDown}
          rows={1}
        />

        <div className="flex w-full">
          <div className="group flex">
            <Select
              options={tests.map((test) => ({
                label: test.id,
                value: test.id,
              }))}
              selectedValue={selectedTestId ?? ""}
              onChange={selectTestCase}
              align="start"
              side="bottom"
              placeholder="Select test case"
              className="peer"
            />
            <button
              className={cn(
                "text-muted-foreground hover:text-primary invisible h-8 w-8",
                isTestCase &&
                  "group-hover:visible peer-hover:visible peer-data-[state=open]:visible",
              )}
              onClick={clearTestCase}
            >
              <X className="mx-auto my-auto size-4" />
            </button>
          </div>

          <div className="ml-auto flex gap-3">
            <Configuration
              model={config.model}
              thinking={config.thinking}
              mcpServerUrl={config.mcpServerUrl}
              onChange={updateConfig}
            />
            <Button
              size="sm"
              variant="default"
              disabled={!canSubmit}
              onClick={handleSubmit}
            >
              <ArrowUp />
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}
