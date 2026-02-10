import { z } from "zod";
import type { Order } from "../../code-approach/types";
import { db } from "@/server/db";

export const getOrderByIdSchema = {
  inputSchema: {
    orderId: z.string().describe("The ID of the order to retrieve"),
  },
};

export const getOrderByIdToolDefinition = {
  title: "Get Order By ID",
  description:
    "Retrieves an order by its ID from the database, with optional related data",
  ...getOrderByIdSchema,
};

/**
 * Retrieves an order by its ID from the database
 * Optionally includes order details, customer, and employee information
 */
export async function getOrderById({
  orderId,
}: {
  orderId: string;
}): Promise<Order> {
  const order = await db.order.findUnique({
    where: {
      id: orderId,
    },
  });

  if (!order) {
    throw new Error(`Order with ID ${orderId} not found`);
  }

  return {
    ...order,
    orderDate: order.orderDate?.toISOString() ?? null,
    requiredDate: order.requiredDate?.toISOString() ?? null,
    shippedDate: order.shippedDate?.toISOString() ?? null,
  };
}
