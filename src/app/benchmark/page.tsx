"use client";
import { SetupBar } from "@/components/benchmark/setup/setup-bar";

export default function Benchmark() {
  return (
    <div className="bg-muted flex min-h-dvh w-full flex-col">
      <div className="mx-auto my-5 mt-[35vh] w-full max-w-3xl">
        <SetupBar onSubmit={(conf) => console.log("Submitted config:", conf)} />
      </div>
    </div>
  );
}
