import { z } from "zod";
import type { Product } from "../types";
import { db } from "@/server/db";
import {
  createTextFilter,
  createExactFilter,
  createRangeFilter,
  combineFilters,
} from "@/lib/db-helpers";

export const searchProductsSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe("Search term to match against product name"),
    categoryId: z.number().int().optional().describe("Filter by category ID"),
    supplierId: z.number().int().optional().describe("Filter by supplier ID"),
    discontinued: z
      .number()
      .int()
      .optional()
      .describe("Filter by discontinued status (0 or 1)"),
    minPrice: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum unit price filter"),
    maxPrice: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum unit price filter"),
    minStock: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum units in stock filter"),
    maxStock: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum units in stock filter"),
    minUnitsOnOrder: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum units on order filter"),
    maxUnitsOnOrder: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum units on order filter"),
    minReorderLevel: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum reorder level filter"),
    maxReorderLevel: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum reorder level filter"),
    sortBy: z
      .enum([
        "name",
        "unitPrice",
        "unitsInStock",
        "unitsOnOrder",
        "reorderLevel",
        "categoryId",
        "supplierId",
      ])
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
};

export const searchProductsToolDefinition = {
  title: "Search Products",
  description:
    "Search and filter products by name, category, price range, and stock level with sorting and pagination",
  ...searchProductsSchema,
};

/**
 * Search and filter products from the database with sorting and pagination
 */
export async function search_products({
  searchTerm,
  categoryId,
  supplierId,
  discontinued,
  minPrice,
  maxPrice,
  minStock,
  maxStock,
  minUnitsOnOrder,
  maxUnitsOnOrder,
  minReorderLevel,
  maxReorderLevel,
  sortBy = "name",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  categoryId?: number;
  supplierId?: number;
  discontinued?: number;
  minPrice?: number;
  maxPrice?: number;
  minStock?: number;
  maxStock?: number;
  minUnitsOnOrder?: number;
  maxUnitsOnOrder?: number;
  minReorderLevel?: number;
  maxReorderLevel?: number;
  sortBy?:
    | "name"
    | "unitPrice"
    | "unitsInStock"
    | "unitsOnOrder"
    | "reorderLevel"
    | "categoryId"
    | "supplierId";
  sortOrder?: "asc" | "desc";
  limit?: number /* max 100 */;
  offset?: number;
}): Promise<{
  products: Product[];
  hasMore: boolean;
}> {
  const whereClause = combineFilters(
    createTextFilter("name", searchTerm),
    createExactFilter("categoryId", categoryId),
    createExactFilter("supplierId", supplierId),
    createExactFilter("discontinued", discontinued),
    createRangeFilter("unitPrice", minPrice, maxPrice),
    createRangeFilter("unitsInStock", minStock, maxStock),
    createRangeFilter("unitsOnOrder", minUnitsOnOrder, maxUnitsOnOrder),
    createRangeFilter("reorderLevel", minReorderLevel, maxReorderLevel),
  );

  // Fetch one more than limit to determine if there are more results
  const products = await db.product.findMany({
    where: whereClause,
    orderBy: { [sortBy]: sortOrder },
    take: limit + 1,
    skip: offset,
  });

  const hasMore = products.length > limit;
  if (hasMore) {
    products.pop(); // Remove the extra item
  }

  return {
    products,
    hasMore,
  };
}
