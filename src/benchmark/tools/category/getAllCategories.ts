import { db } from "@/server/db";
import type { Category } from "../types";

export const getAllCategoriesSchema = {
  inputSchema: {},
};

export const getAllCategoriesToolDefinition = {
  title: "Get All Categories",
  description: "Retrieves all categories from the database",
  ...getAllCategoriesSchema,
};

/**
 * Retrieves all categories from the database
 */
export async function getAllCategories(): Promise<Category[]> {
  const categories = await db.category.findMany();
  return categories;
}
