import type { FlowNodeColor } from "@/components/benchmark/agent-flow/flow-node";
import { INTERFACE_DEFINITIONS, TOOL_DEFINITIONS } from "./tools-api-def";

const ENTITY_COLORS: Record<string, FlowNodeColor> = {
  Customer: "blue",
  Order: "blue",
  Employee: "blue",
  Product: "blue",
  Supplier: "green",
  Category: "green",
  OrderDetail: "green",
  Shipper: "green",
  Region: "violet",
  Territory: "violet",
  EmployeeTerritory: "violet",
};

export function snakeToCamel(str: string): string {
  return str.replace(/_([a-z])/g, (_, letter: string) => letter.toUpperCase());
}

export function getInterfaceColor(name: string): FlowNodeColor {
  return ENTITY_COLORS[name] ?? "violet";
}

export function getToolColor(toolName: string): FlowNodeColor {
  const name = toolName.toLowerCase();
  if (name.includes("customer")) return ENTITY_COLORS.Customer!;
  if (name.includes("order"))
    return !name.includes("detail")
      ? ENTITY_COLORS.Order!
      : ENTITY_COLORS.OrderDetail!;
  if (name.includes("employee") && !name.includes("territory"))
    return ENTITY_COLORS.Employee!;
  if (name.includes("product")) return ENTITY_COLORS.Product!;
  if (name.includes("supplier")) return ENTITY_COLORS.Supplier!;
  if (name.includes("category") || name.includes("categories"))
    return ENTITY_COLORS.Category!;
  if (name.includes("shipper")) return ENTITY_COLORS.Shipper!;
  return "violet";
}

export function getToolsAPI() {
  return `${Object.values(INTERFACE_DEFINITIONS).join("\n\n")}

    ${Object.values(TOOL_DEFINITIONS).join("\n\n")}    
    `;
}
