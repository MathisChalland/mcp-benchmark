import { z } from "zod";
import { db } from "@/server/db";
import { createWhereClauseBuilder } from "@/lib/db-helpers";
import type { Order, Product } from "../../code-approach/types";

export const getProductSalesSchema = {
  inputSchema: {
    productId: z
      .number()
      .describe("The ID of the product to get sales data for"),
    startDate: z
      .string()
      .optional()
      .describe("Filter sales from this date onwards (ISO date string)"),
    endDate: z
      .string()
      .optional()
      .describe("Filter sales up to this date (ISO date string)"),
    includeProduct: z
      .boolean()
      .optional()
      .default(false)
      .describe("Whether to include full product information"),
  },
};

export const getProductSalesToolDefinition = {
  title: "Get Product Sales",
  description:
    "Retrieves sales revenue and quantity data for a specific product, with optional date range filtering",
  ...getProductSalesSchema,
};

export interface ProductSales {
  productId: number;
  productName: string;
  totalQuantity: number;
  revenue: number;
  orderCount: number;
  startDate: string | null;
  endDate: string | null;
  product?: Product;
}

const w = createWhereClauseBuilder<Order>();

/**
 * Retrieves sales data for a specific product
 * Calculates total quantity sold and revenue (after discounts)
 * Optionally filters by date range based on order date
 */
export async function getProductSales({
  productId,
  startDate,
  endDate,
  includeProduct = false,
}: {
  productId: number;
  startDate?: string;
  endDate?: string;
  includeProduct?: boolean;
}): Promise<ProductSales> {
  const product = await db.product.findUnique({
    where: { id: productId },
  });

  if (!product) {
    throw new Error(`Product with ID ${productId} not found`);
  }

  const where = w.range(
    "orderDate",
    startDate ? new Date(startDate) : undefined,
    endDate ? new Date(endDate) : undefined,
  );

  const orderDetails = await db.orderDetail.findMany({
    where: {
      productId,
      order: where,
    },
  });

  let totalQuantity = 0;
  let revenue = 0;
  const uniqueOrders = new Set<number>();

  for (const detail of orderDetails) {
    const lineTotal = detail.unitPrice * detail.quantity;
    const lineDiscount = lineTotal * detail.discount;

    totalQuantity += detail.quantity;
    revenue += lineTotal - lineDiscount;
    uniqueOrders.add(detail.orderId);
  }

  const result: ProductSales = {
    productId: product.id,
    productName: product.name,
    totalQuantity,
    revenue: Math.round(revenue * 100) / 100,
    orderCount: uniqueOrders.size,
    startDate: startDate ?? null,
    endDate: endDate ?? null,
  };

  if (includeProduct) {
    result.product = product;
  }

  return result;
}
