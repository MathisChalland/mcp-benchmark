import { z } from "zod";
import type { Order } from "../types";
import { db } from "@/server/db";

export const getCustomerOrdersSchema = {
  inputSchema: {
    customerId: z.string().describe("The ID of the customer"),
    startDate: z.string().optional().describe("Start date filter"),
    endDate: z.string().optional().describe("End date filter"),
    status: z.string().optional().describe("Filter by order status"),
  },
  outputSchema: {
    orders: z.array(
      z.object({
        id: z.string(),
        customerId: z.string(),
        orderDate: z.date(),
        status: z.string(),
        total: z.number(),
      }),
    ),
  },
};

/**
 * Retrieves all orders for a specific customer with optional filters
 */
export async function get_customer_orders({
  customerId,
  startDate,
  endDate,
  status,
}: {
  customerId: string;
  startDate?: string;
  endDate?: string;
  status?: string;
}): Promise<Order[]> {
  await new Promise((resolve) => setTimeout(resolve, 100));
  const orders = await db.order.findMany({
    where: {
      customerId,
      ...(startDate || endDate
        ? {
            orderDate: {
              ...(startDate ? { gte: new Date(startDate) } : {}),
              ...(endDate ? { lte: new Date(endDate) } : {}),
            },
          }
        : {}),
      ...(status ? { status } : {}),
    },
    orderBy: {
      orderDate: "desc",
    },
  });
  return orders;
}

export const getCustomerOrdersToolDefinition = {
  title: "Get Customer Orders",
  description:
    "Retrieves all orders for a specific customer with optional date and status filters",
  ...getCustomerOrdersSchema,
};
