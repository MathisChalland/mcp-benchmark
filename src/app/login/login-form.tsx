"use client";
import { cn } from "@/lib/utils";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";

import { useState } from "react";
import { AsyncButton } from "@/components/basic-components/async-action-button";
import { authClient } from "@/server/better-auth/client";
import { Github } from "lucide-react";

export function LoginForm({ className }: { className?: string }) {
  const [isLoading, setIsLoading] = useState(false);

  const signIn = async () => {
    setIsLoading(true);
    await authClient.signIn.social({
      provider: "github",
    });
  };

  return (
    <div className={cn("flex flex-col gap-6", className)}>
      <AsyncButton
        variant="outline"
        className="hover:bg-primary hover:text-primary-foreground w-full cursor-pointer"
        onClick={signIn}
        isLoading={isLoading}
      >
        <Github />
        Continue with GitHub
      </AsyncButton>
    </div>
  );
}
