"use client";
import { cn } from "@/lib/utils";

import { useState } from "react";
import { useSearchParams } from "next/navigation";
import { AsyncButton } from "@/components/basic-components/async-action-button";
import { authClient } from "@/server/better-auth/client";
import { Github } from "lucide-react";

export function LoginForm({ className }: { className?: string }) {
  const [loading, setLoading] = useState<"gh" | "ghe" | false>(false);
  const isLoading = loading !== false;
  const searchParams = useSearchParams();

  const error = searchParams.get("error");

  const signIn = async () => {
    setLoading("gh");
    await authClient.signIn.social({
      provider: "github",
      callbackURL: "/",
      errorCallbackURL: "/login",
    });
  };

  const singInWithGHE = async () => {
    setLoading("ghe");
    await authClient.signIn.social({
      provider: "github-enterprise",
      callbackURL: "/",
      errorCallbackURL: "/login",
    });
  };

  return (
    <div className={cn("flex flex-col gap-6", className)}>
      <AsyncButton
        variant="outline"
        className="hover:bg-primary/5 hover:text-accent-foreground w-full cursor-pointer"
        onClick={signIn}
        disabled={isLoading}
        isLoading={loading === "gh"}
      >
        <Github />
        Continue with GitHub
      </AsyncButton>
      <AsyncButton
        variant="outline"
        className="hover:bg-primary/5 hover:text-accent-foreground w-full cursor-pointer"
        onClick={singInWithGHE}
        disabled={isLoading}
        isLoading={loading === "ghe"}
      >
        <Github />
        Continue with SAP GitHub
      </AsyncButton>
      {error && <div className="text-center text-sm text-red-600">{error}</div>}
    </div>
  );
}
