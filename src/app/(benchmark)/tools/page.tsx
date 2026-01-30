"use client";

import { useMcpClients } from "@/contexts/useMcpClientContext";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import {
  ArrowLeft,
  Box,
  Boxes,
  Database,
  Loader2,
  Package,
  ShoppingCart,
  Users,
  Wrench,
} from "lucide-react";
import Link from "next/link";
import { useMemo } from "react";
import {
  AVAILABLE_TOOLS,
  getSelectedToolsAPI,
} from "@/benchmark/tools/tools-api-def";
import { CodeBlock } from "@/components/benchmark/code";
import { FlowNodeCard } from "@/components/benchmark/agent-flow/flow-node";
import { formatJs } from "@/lib/format-code";

const categoryConfig = {
  customer: { icon: Users, color: "blue" as const, label: "Customer" },
  product: { icon: Package, color: "green" as const, label: "Product" },
  order: { icon: ShoppingCart, color: "violet" as const, label: "Order" },
} as const;

const interfaces = [
  {
    name: "Customer",
    icon: Users,
    color: "blue" as const,
    code: `interface Customer {
  id: string;
  name: string;
  email: string;
  address: string;
  createdAt: string; // ISO date string
}`,
  },
  {
    name: "Product",
    icon: Package,
    color: "green" as const,
    code: `interface Product {
  id: string;
  name: string;
  description: string;
  price: number; // Price in Cent
  stock: number;
  createdAt: string; // ISO date string
}`,
  },
  {
    name: "Order",
    icon: ShoppingCart,
    color: "violet" as const,
    code: `interface Order {
  id: string;
  customerId: string;
  orderDate: string; // ISO date string
  total: number; // Total price in Cent
  status: string;
}`,
  },
];

function getToolCategory(toolName: string): keyof typeof categoryConfig {
  if (toolName.includes("customer")) return "customer";
  if (toolName.includes("product") || toolName.includes("inventory"))
    return "product";
  return "order";
}

function ToolCard({
  name,
  description,
  inputSchema,
}: {
  name: string;
  description?: string;
  inputSchema?: Record<string, unknown>;
}) {
  const category = getToolCategory(name);
  const config = categoryConfig[category];

  const signature = useMemo(() => {
    if (!AVAILABLE_TOOLS.includes(name as (typeof AVAILABLE_TOOLS)[number])) {
      return null;
    }
    return getSelectedToolsAPI([name]);
  }, [name]);

  const schemaJson = useMemo(
    () => (inputSchema ? JSON.stringify(inputSchema, null, 2) : null),
    [inputSchema],
  );

  return (
    <FlowNodeCard
      icon={Wrench}
      label={name}
      color={config.color}
      content={
        <>
          {description && (
            <p className="text-muted-foreground mb-4 text-sm">{description}</p>
          )}

          <Accordion type="multiple" className="w-full">
            {signature && (
              <AccordionItem value="signature" className="border-border">
                <AccordionTrigger className="text-primary cursor-pointer py-4 text-xs font-medium tracking-wider uppercase hover:no-underline">
                  Signature
                </AccordionTrigger>
                <AccordionContent>
                  <CodeBlock code={signature} language="typescript" />
                </AccordionContent>
              </AccordionItem>
            )}

            {schemaJson && (
              <AccordionItem
                value="schema"
                className="border-border border-b-0"
              >
                <AccordionTrigger className="text-primary cursor-pointer py-4 text-xs font-medium tracking-wider uppercase hover:no-underline">
                  Input Schema (JSON)
                </AccordionTrigger>
                <AccordionContent>
                  <CodeBlock code={schemaJson} language="json" />
                </AccordionContent>
              </AccordionItem>
            )}
          </Accordion>
        </>
      }
    />
  );
}

export default function ToolsPage() {
  const { toolCall, isConnected, isConnecting } = useMcpClients();
  const tools = toolCall.tools;

  return (
    <div className="bg-muted max-h-dvh w-full">
      <HeaderBar />
      <div className="max-h-dvh overflow-auto pt-16">
        <div className="mx-auto max-w-4xl px-6 py-8">
          <section className="mb-12">
            <div className="mb-4 flex items-center gap-2">
              <Boxes className="text-muted-foreground size-5" />
              <h2 className="text-foreground text-lg font-medium">
                Interfaces
              </h2>
              <span className="text-muted-foreground text-sm">
                ({interfaces.length})
              </span>
            </div>
            <div className="grid gap-4 md:grid-cols-2">
              {interfaces.map((iface) => {
                return (
                  <FlowNodeCard
                    key={iface.name}
                    icon={iface.icon}
                    label={iface.name}
                    color={iface.color}
                    content={
                      <CodeBlock
                        code={formatJs(iface.code)}
                        language="typescript"
                        className="h-full flex-1"
                      />
                    }
                  />
                );
              })}
            </div>
          </section>

          <section>
            <div className="mb-4 flex items-center gap-2">
              <Box className="text-muted-foreground size-5" />
              <h2 className="text-foreground text-lg font-medium">Tools</h2>
              {isConnected && (
                <span className="text-muted-foreground text-sm">
                  ({tools.length})
                </span>
              )}
            </div>

            {isConnecting && (
              <div className="flex flex-col items-center justify-center py-20">
                <Loader2 className="text-muted-foreground size-8 animate-spin" />
                <p className="text-muted-foreground mt-4 text-sm">
                  Connecting to MCP server...
                </p>
              </div>
            )}

            {toolCall.error && (
              <div className="bg-destructive/10 border-destructive/50 rounded-xl border p-6 text-center">
                <p className="text-destructive font-medium">
                  Failed to load tools
                </p>
                <p className="text-muted-foreground mt-1 text-sm">
                  {toolCall.error}
                </p>
              </div>
            )}

            {isConnected && tools.length > 0 && (
              <div className="grid gap-4">
                {tools.map((tool) => (
                  <ToolCard
                    key={tool.name}
                    name={tool.name}
                    description={tool.description}
                    inputSchema={tool.inputSchema}
                  />
                ))}
              </div>
            )}
          </section>
        </div>
      </div>
    </div>
  );
}

function HeaderBar() {
  return (
    <header className="border-border bg-muted/40 absolute top-0 z-50 w-full border-b backdrop-blur-lg">
      <div className="flex w-full items-center px-20 py-3">
        <div className="flex items-center gap-2 px-3 py-2">
          <Database className="text-primary size-5" />
          <h1 className="text-primary/90 text-center font-serif text-lg font-extralight">
            Tools & Interfaces
          </h1>
        </div>
        <Link
          href="/"
          className="text-muted-foreground hover:text-foreground ml-auto inline-flex items-center gap-1.5 text-sm transition-colors"
        >
          <ArrowLeft className="size-4" />
          Back to Benchmark
        </Link>
      </div>
    </header>
  );
}
