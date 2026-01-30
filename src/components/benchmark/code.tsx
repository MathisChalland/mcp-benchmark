import { useShiki } from "@/contexts/ShikiContext";
import { cn } from "@/lib/utils";
import { useMemo } from "react";

interface CodeBlockProps {
  code: string;
  language?: string;
  maxHeight?: string;
  className?: string;
}
export function CodeBlock({
  code,
  language = "json",
  maxHeight = "30rem",
  className,
}: CodeBlockProps) {
  const highlighter = useShiki();

  const html = useMemo(() => {
    if (!highlighter) return null;

    let htmlString = highlighter.codeToHtml(code, {
      lang: language,
      theme: "github-light",
    });

    htmlString = htmlString
      .replace(
        /style="[^"]*"/,
        'style="background:transparent;padding:0;margin:0;font-size:12px;line-height:1.5"',
      )
      .replace(
        /<code/,
        '<code style="display:block;background:transparent;font-size:12px"',
      );

    return htmlString;
  }, [highlighter, code, language]);

  if (!html) {
    return (
      <pre
        className={cn(
          "bg-background/30 border-border w-full overflow-auto rounded-lg border p-3 font-mono text-[10px] text-zinc-400",
          className,
        )}
        style={{ maxHeight }}
      >
        <code>{code}</code>
      </pre>
    );
  }

  return (
    <div
      className={cn(
        "bg-muted/30 border-border flex w-full flex-col overflow-auto rounded-lg border p-3",
        className,
      )}
      style={{ maxHeight }}
      dangerouslySetInnerHTML={{ __html: html }}
    />
  );
}
