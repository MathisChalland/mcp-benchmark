import { z } from "zod";
import { db } from "@/server/db";

export const getOrderTotalSchema = {
  inputSchema: {
    orderId: z
      .number()
      .describe("The ID of the order to calculate the total for"),
  },
};

export const getOrderTotalToolDefinition = {
  title: "Get Order Total",
  description:
    "Calculates the total amount for an order based on its line items, discounts, and freight",
  ...getOrderTotalSchema,
};
/**
 * Calculates the total for an order based on order details
 * Formula: sum of (unitPrice * quantity * (1 - discount)) + freight
 */
export async function getOrderTotal({ orderId }: { orderId: number }): Promise<{
  orderId: number;
  subtotal: number;
  totalDiscount: number;
  freight: number;
  total: number;
  itemCount: number;
}> {
  const order = await db.order.findUnique({
    where: {
      id: orderId,
    },
    include: {
      details: true,
    },
  });

  if (!order) {
    throw new Error(`Order with ID ${orderId} not found`);
  }

  let subtotal = 0;
  let totalDiscount = 0;

  for (const detail of order.details) {
    const lineTotal = detail.unitPrice * detail.quantity;
    const lineDiscount = lineTotal * detail.discount;
    subtotal += lineTotal;
    totalDiscount += lineDiscount;
  }

  const freight = order.freight ?? 0;
  const total = subtotal - totalDiscount + freight;

  return {
    orderId,
    subtotal: Math.round(subtotal * 100) / 100,
    totalDiscount: Math.round(totalDiscount * 100) / 100,
    freight: Math.round(freight * 100) / 100,
    total: Math.round(total * 100) / 100,
    itemCount: order.details.length,
  };
}
