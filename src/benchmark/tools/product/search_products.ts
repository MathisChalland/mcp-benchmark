import { z } from "zod";
import type { Product } from "../types";
import { db } from "@/server/db";

export const searchProductsSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe("Search term to match against product name or description"),
    minPrice: z.number().min(0).optional().describe("Minimum price filter"),
    maxPrice: z.number().min(0).optional().describe("Maximum price filter"),
    minStock: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum stock level filter"),
    maxStock: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum stock level filter"),
    sortBy: z
      .enum(["name", "price", "stock", "createdAt"])
      .optional()
      .default("name")
      .describe("Field to sort by"),
    sortOrder: z
      .enum(["asc", "desc"])
      .optional()
      .default("asc")
      .describe("Sort order"),
    limit: z
      .number()
      .min(1)
      .max(100)
      .optional()
      .default(20)
      .describe("Maximum number of products to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of products to skip for pagination"),
  },
  outputSchema: {
    products: z.array(
      z.object({
        id: z.string(),
        name: z.string(),
        description: z.string(),
        price: z.number(),
        stock: z.number(),
        createdAt: z.date(),
      }),
    ),
    hasMore: z.boolean(),
  },
};

export const searchProductsToolDefinition = {
  title: "Search Products",
  description:
    "Search and filter products by name, description, price range, and stock level with sorting and pagination",
  ...searchProductsSchema,
};

/**
 * Search and filter products with flexible criteria
 */
export async function search_products({
  searchTerm,
  minPrice,
  maxPrice,
  minStock,
  maxStock,
  sortBy = "name",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  minPrice?: number;
  maxPrice?: number;
  minStock?: number;
  maxStock?: number;
  sortBy?: "name" | "price" | "stock" | "createdAt";
  sortOrder?: "asc" | "desc";
  limit?: number /* max 100 */;
  offset?: number;
}): Promise<{
  products: Product[];
  hasMore: boolean;
}> {
  await new Promise((resolve) => setTimeout(resolve, 100));

  const whereClause: any = {};

  if (searchTerm) {
    whereClause.OR = [
      { name: { contains: searchTerm } },
      { description: { contains: searchTerm } },
    ];
  }

  if (minPrice !== undefined || maxPrice !== undefined) {
    whereClause.price = {};
    if (minPrice !== undefined) whereClause.price.gte = minPrice;
    if (maxPrice !== undefined) whereClause.price.lte = maxPrice;
  }

  if (minStock !== undefined || maxStock !== undefined) {
    whereClause.stock = {};
    if (minStock !== undefined) whereClause.stock.gte = minStock;
    if (maxStock !== undefined) whereClause.stock.lte = maxStock;
  }

  const total = await db.product.count({ where: whereClause });

  const products = await db.product.findMany({
    where: whereClause,
    orderBy: { [sortBy]: sortOrder },
    take: limit,
    skip: offset,
  });

  return {
    products,
    hasMore: offset + products.length < total,
  };
}
