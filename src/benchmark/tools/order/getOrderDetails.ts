import { z } from "zod";
import type { OrderDetail, Product } from "../types";
import { db } from "@/server/db";

export const getOrderDetailsSchema = {
  inputSchema: {
    orderId: z
      .number()
      .int()
      .describe("The ID of the order to retrieve details for"),
    includeProduct: z
      .boolean()
      .optional()
      .default(false)
      .describe("Whether to include product information for each order detail"),
  },
};

export const getOrderDetailsToolDefinition = {
  title: "Get Order Details",
  description:
    "Retrieves all order details (line items) for a specific order, with optional product information",
  ...getOrderDetailsSchema,
};

/**
 * Retrieves order details (line items) for a specific order
 * Optionally includes product information for each line item
 */
export async function getOrderDetails({
  orderId,
  includeProduct = false,
}: {
  orderId: number;
  includeProduct?: boolean;
}): Promise<Array<OrderDetail & { product?: Product }>> {
  const orderDetails = await db.orderDetail.findMany({
    where: {
      orderId: orderId,
    },
    include: {
      product: includeProduct,
    },
  });

  if (orderDetails.length === 0) {
    const order = await db.order.findUnique({
      where: { id: orderId },
      select: { id: true },
    });

    if (!order) {
      throw new Error(`Order with ID ${orderId} not found`);
    }

    return [];
  }

  return orderDetails;
}
