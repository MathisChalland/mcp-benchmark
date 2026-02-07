import { z } from "zod";
import type { Product } from "../../code-approach/types";
import { db } from "@/server/db";

export const getProductSchema = {
  inputSchema: {
    productId: z.string().describe("The ID of the product to retrieve"),
  },
};

export const getProductToolDefinition = {
  title: "Get Product",
  description: "Retrieves a product by its ID from the database",
  ...getProductSchema,
};

/**
 * Retrieves a product by its ID from the database
 */
export async function getProductById({
  productId,
}: {
  productId: string;
}): Promise<Product> {
  const product = await db.product.findUnique({
    where: {
      id: productId,
    },
  });

  if (!product) {
    throw new Error(`Product with ID ${productId} not found`);
  }

  return product;
}
