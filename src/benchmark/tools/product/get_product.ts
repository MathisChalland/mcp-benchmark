import { z } from "zod";
import type { Product } from "../types";
import { db } from "@/server/db";

export const getProductSchema = {
  inputSchema: {
    productId: z
      .string()
      .describe("The ID of the product to retrieve (price is in cents)"),
  },
  // outputSchema: {
  //   id: z.string(),
  //   name: z.string(),
  //   description: z.string(),
  //   price: z.number(),
  //   stock: z.number(),
  //   createdAt: z.string().describe("ISO date string"),
  // },
};

export const getProductToolDefinition = {
  title: "Get Product",
  description: "Retrieves a product by its ID from the database",
  ...getProductSchema,
};

/**
 * Retrieves a product by its ID from the database
 */
export async function get_product({
  productId,
}: {
  productId: string;
}): Promise<Product> {
  await new Promise((resolve) => setTimeout(resolve, 100));

  const product = await db.product.findUnique({
    where: {
      id: productId,
    },
  });

  if (!product) {
    throw new Error(`Product with ID ${productId} not found`);
  }

  return {
    ...product,
    createdAt: product.createdAt.toISOString(),
  };
}
