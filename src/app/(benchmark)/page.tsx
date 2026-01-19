"use client";
import { RunTestcase } from "@/components/benchmark/run-testcase";
import { SetupBar } from "@/components/benchmark/setup/setup-bar";
import {
  useTestSetup,
  type TestSetupResult,
} from "@/components/benchmark/setup/useTestSetup";
import { Bot } from "lucide-react";
import { useState } from "react";

export default function Benchmark() {
  const setup = useTestSetup();
  const [run, setRun] = useState<TestSetupResult>();
  return (
    <div className="bg-muted flex min-h-dvh w-full flex-col overscroll-none">
      {!run ? (
        <div className="mx-auto my-5 mt-[30vh] w-full max-w-3xl">
          <div className="mb-14 flex w-full items-center justify-center gap-5">
            <Bot className="text-muted-foreground size-11 stroke-[1.5]" />
            <h1 className="text-primary/90 text-center font-serif text-4xl font-extralight">
              Agent playground & benchmark
            </h1>
          </div>

          <SetupBar setup={setup} onSubmit={(conf) => setRun(conf)} />
        </div>
      ) : (
        <RunTestcase setup={run} onNewSetup={() => setRun(undefined)} />
      )}
    </div>
  );
}
