import { db } from "@/server/db";
import { createWhereClauseBuilder } from "@/lib/db-helpers";
import { z } from "zod";
import type { Category } from "../../code-approach/types";

export const getManyCategoriesSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe("Search term to match against category name or description"),
    limit: z
      .number()
      .min(1)
      .max(100)
      .optional()
      .default(20)
      .describe("Maximum number of categories to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of categories to skip for pagination"),
  },
};

export const getManyCategoriesToolDefinition = {
  title: "Get Many Categories",
  description:
    "Search and filter categories from the database with sorting and pagination",
  ...getManyCategoriesSchema,
};

const w = createWhereClauseBuilder<Category>();

/**
 * Search and filter categories from the database with sorting and pagination
 */
export async function getManyCategories({
  searchTerm,
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  limit?: number /*max 100*/;
  offset?: number;
}): Promise<{
  categories: Array<Category>;
  hasMore: boolean;
}> {
  const where = w.combine(w.search(["name", "description"], searchTerm));

  const categories = await db.category.findMany({
    where,
    take: limit + 1,
    skip: offset,
  });

  const hasMore = categories.length > limit;
  if (hasMore) categories.pop();

  return {
    categories,
    hasMore,
  };
}
