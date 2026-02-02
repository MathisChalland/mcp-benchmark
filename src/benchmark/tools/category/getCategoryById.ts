import { z } from "zod";
import { db } from "@/server/db";
import type { Category } from "../../code-approach/types";

export const getCategoryByIdSchema = {
  inputSchema: {
    categoryId: z.string().describe("The ID of the category to retrieve"),
  },
};

export const getCategoryByIdToolDefinition = {
  title: "Get Category",
  description: "Retrieves a category by its ID from the database",
  ...getCategoryByIdSchema,
};

/**
 * Retrieves a category by its ID from the database
 */
export async function getCategoryById({
  categoryId,
}: {
  categoryId: number;
}): Promise<Category> {
  const category = await db.category.findUnique({
    where: {
      id: categoryId,
    },
  });

  if (!category) {
    throw new Error(`Category with ID ${categoryId} not found`);
  }

  return category;
}
