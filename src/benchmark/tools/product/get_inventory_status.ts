import { db } from "@/server/db";
import { z } from "zod";

export const getInventoryStatusSchema = {
  inputSchema: {
    lowStockThreshold: z
      .number()
      .min(0)
      .optional()
      .default(10)
      .describe("Threshold below which a product is considered low stock"),
    includeOutOfStock: z
      .boolean()
      .optional()
      .default(true)
      .describe("Whether to include out of stock products in the response"),
    includeLowStock: z
      .boolean()
      .optional()
      .default(true)
      .describe("Whether to include low stock products in the response"),
    includeInStock: z
      .boolean()
      .optional()
      .default(false)
      .describe("Whether to include in-stock products (above threshold)"),
    limit: z
      .number()
      .min(1)
      .optional()
      .describe("Maximum number of products to return per category"),
    sortBy: z
      .enum(["name", "stock", "price"])
      .optional()
      .default("stock")
      .describe("Field to sort products by"),
    sortOrder: z
      .enum(["asc", "desc"])
      .optional()
      .default("asc")
      .describe("Sort order (ascending or descending)"),
  },
  outputSchema: {
    summary: z.object({
      totalProducts: z.number(),
      outOfStockCount: z.number(),
      lowStockCount: z.number(),
      inStockCount: z.number(),
      totalStockValue: z.number(),
    }),
    outOfStockProductIds: z.array(z.string()).optional(),
    lowStockProductIds: z.array(z.string()).optional(),
    inStockProductIds: z.array(z.string()).optional(),
  },
};

export const getInventoryStatusToolDefinition = {
  title: "Get Inventory Status",
  description:
    "Get inventory status overview including out-of-stock alerts, low stock warnings, and stock value summary",
  ...getInventoryStatusSchema,
};

/**
 * Get comprehensive inventory status and alerts
 */
export async function get_inventory_status({
  lowStockThreshold = 10,
  includeOutOfStock = true,
  includeLowStock = true,
  includeInStock = false,
  limit,
  sortBy = "stock",
  sortOrder = "asc",
}: {
  lowStockThreshold?: number;
  includeOutOfStock?: boolean;
  includeLowStock?: boolean;
  includeInStock?: boolean;
  limit?: number;
  sortBy?: "name" | "stock" | "price";
  sortOrder?: "asc" | "desc";
}): Promise<{
  summary: {
    totalProducts: number;
    outOfStockCount: number;
    lowStockCount: number;
    inStockCount: number;
    totalStockValue: number;
  };
  outOfStockProductIds?: string[];
  lowStockProductIds?: string[];
  inStockProductIds?: string[];
}> {
  await new Promise((resolve) => setTimeout(resolve, 100));

  const allProducts = await db.product.findMany({
    select: {
      id: true,
      name: true,
      price: true,
      stock: true,
    },
  });

  const outOfStockCount = allProducts.filter((p) => p.stock === 0).length;
  const lowStockCount = allProducts.filter(
    (p) => p.stock > 0 && p.stock <= lowStockThreshold,
  ).length;
  const inStockCount = allProducts.filter(
    (p) => p.stock > lowStockThreshold,
  ).length;
  const totalStockValue = allProducts.reduce(
    (sum, p) => sum + p.price * p.stock,
    0,
  );

  const outOfStockProducts = includeOutOfStock
    ? await db.product.findMany({
        where: { stock: 0 },
        select: { id: true },
        orderBy: { [sortBy]: sortOrder },
        ...(limit ? { take: limit } : {}),
      })
    : [];

  const lowStockProducts = includeLowStock
    ? await db.product.findMany({
        where: {
          stock: { gt: 0, lte: lowStockThreshold },
        },
        select: { id: true },
        orderBy: { [sortBy]: sortOrder },
        ...(limit ? { take: limit } : {}),
      })
    : [];

  const inStockProducts = includeInStock
    ? await db.product.findMany({
        where: {
          stock: { gt: lowStockThreshold },
        },
        select: { id: true },
        orderBy: { [sortBy]: sortOrder },
        ...(limit ? { take: limit } : {}),
      })
    : [];

  return {
    summary: {
      totalProducts: allProducts.length,
      outOfStockCount,
      lowStockCount,
      inStockCount,
      totalStockValue: Math.round(totalStockValue * 100) / 100,
    },
    ...(includeOutOfStock && {
      outOfStockProductIds: outOfStockProducts.map((p) => p.id),
    }),
    ...(includeLowStock && {
      lowStockProductIds: lowStockProducts.map((p) => p.id),
    }),
    ...(includeInStock && {
      inStockProductIds: inStockProducts.map((p) => p.id),
    }),
  };
}
