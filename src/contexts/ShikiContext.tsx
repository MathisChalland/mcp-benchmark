"use client";

import { createContext, useContext, useEffect, useState } from "react";
import type { HighlighterCore } from "shiki/core";
import { createHighlighterCore } from "shiki/core";
import { createOnigurumaEngine } from "shiki/engine/oniguruma";

import githubDark from "@shikijs/themes/github-dark";
import githubLight from "@shikijs/themes/github-light";
import javascript from "@shikijs/langs/javascript";
import json from "@shikijs/langs/json";
import typescript from "@shikijs/langs/typescript";

const ShikiContext = createContext<HighlighterCore | null>(null);

export function ShikiProvider({ children }: { children: React.ReactNode }) {
  const [highlighter, setHighlighter] = useState<HighlighterCore | null>(null);

  useEffect(() => {
    createHighlighterCore({
      themes: [githubDark, githubLight],
      langs: [json, typescript, javascript],
      engine: createOnigurumaEngine(import("shiki/wasm")),
    })
      .then((hl) => {
        setHighlighter(hl);
      })
      .catch((err) => {
        console.error("Failed to initialize Shiki highlighter:", err);
      });
  }, []);

  return (
    <ShikiContext.Provider value={highlighter}>
      {children}
    </ShikiContext.Provider>
  );
}

export function useShiki() {
  const context = useContext(ShikiContext);
  if (context === undefined) {
    throw new Error("useShiki must be used within a ShikiProvider");
  }
  return context;
}
