import { z } from "zod";
import type { OrderDetail } from "../../code-approach/types";
import { db } from "@/server/db";
import { createWhereClauseBuilder } from "@/lib/db-helpers";

export const getManyOrderDetailsSchema = {
  inputSchema: {
    customerId: z
      .string()
      .optional()
      .describe("Filter by customer ID (via order)"),
    productId: z.string().optional().describe("Filter by product ID"),
    minUnitPrice: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum unit price filter"),
    maxUnitPrice: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum unit price filter"),
    minQuantity: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum quantity filter"),
    maxQuantity: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum quantity filter"),
    sortBy: z
      .enum(["orderId", "productId", "unitPrice", "quantity", "discount"])
      .optional()
      .default("orderId")
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
      .describe("Maximum number of order details to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of order details to skip for pagination"),
  },
};

export const getManyOrderDetailsToolDefinition = {
  title: "Get Many Order Details",
  description:
    "Search and filter order details (line items) from the database with sorting and pagination",
  ...getManyOrderDetailsSchema,
};

const w = createWhereClauseBuilder<OrderDetail>();

/**
 * Search and filter order details (line items) from the database with sorting and pagination
 */
export async function getManyOrderDetails({
  customerId,
  productId,
  minUnitPrice,
  maxUnitPrice,
  minQuantity,
  maxQuantity,
  sortBy = "orderId",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  customerId?: string;
  productId?: string;
  minUnitPrice?: number;
  maxUnitPrice?: number;
  minQuantity?: number;
  maxQuantity?: number;
  sortBy?: "orderId" | "productId" | "unitPrice" | "quantity" | "discount";
  sortOrder?: "asc" | "desc";
  limit?: number /*max 100*/;
  offset?: number;
}): Promise<{
  orderDetails: Array<OrderDetail>;
  hasMore: boolean;
}> {
  const where = {
    ...w.combine(
      w.exact("productId", productId),
      w.range("unitPrice", minUnitPrice, maxUnitPrice),
      w.range("quantity", minQuantity, maxQuantity),
    ),
    ...(customerId ? { order: { customerId } } : {}),
  };

  const orderDetails = await db.orderDetail.findMany({
    where,
    orderBy: {
      [sortBy]: sortOrder,
    },
    take: limit + 1,
    skip: offset,
  });

  const hasMore = orderDetails.length > limit;
  if (hasMore) orderDetails.pop();

  return {
    orderDetails,
    hasMore,
  };
}
