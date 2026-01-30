"use client";
import { RunTestcase } from "@/components/benchmark/run-testcase";
import { SetupBar } from "@/components/benchmark/setup/setup-bar";
import {
  useTestSetup,
  type TestSetupResult,
} from "@/components/benchmark/setup/useTestSetup";
import { Button } from "@/components/ui/button";
import { Bot, Compass, Github } from "lucide-react";
import Link from "next/link";
import { useCallback, useState } from "react";

export default function Benchmark() {
  const setup = useTestSetup();
  const [run, setRun] = useState<TestSetupResult>();
  const [runKey, setRunKey] = useState(0);

  const handleNewSetup = useCallback((rerun?: TestSetupResult) => {
    if (rerun) {
      setRunKey((k) => k + 1);
    } else {
      setRun(undefined);
    }
  }, []);

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
          <div className="mt-4 flex w-full justify-center gap-2">
            <Button
              variant="outline"
              className="hover:bg-primary/5 hover:text-accent-foreground bg-transparent shadow-none"
              asChild
            >
              <Link href="/tools">
                <Compass /> Explore Tools
              </Link>
            </Button>
            <Button
              variant="outline"
              className="hover:bg-primary/5 hover:text-accent-foreground bg-transparent shadow-none"
              asChild
            >
              <Link
                href="https://github.com/MathisChalland/mcp-benchmark"
                target="_blank"
                rel="noopener noreferrer"
              >
                <Github /> View on GitHub
              </Link>
            </Button>
          </div>
        </div>
      ) : (
        <RunTestcase key={runKey} setup={run} onNewSetup={handleNewSetup} />
      )}
    </div>
  );
}
