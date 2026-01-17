import { db } from "@/server/db";
import { z } from "zod";

export const searchOrdersSchema = {
  inputSchema: {
    startDate: z.string().optional().describe("Start date filter"),
    endDate: z.string().optional().describe("End date filter"),
    status: z
      .string()
      .optional()
      .describe(
        "Filter by order status (e.g., 'pending', 'completed', 'cancelled')",
      ),
    minTotal: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum order total filter"),
    maxTotal: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum order total filter"),
    customerId: z.number().optional().describe("Filter by customer ID"),
    sortBy: z
      .enum(["orderDate", "total", "status"])
      .optional()
      .default("orderDate")
      .describe("Field to sort by"),
    sortOrder: z
      .enum(["asc", "desc"])
      .optional()
      .default("desc")
      .describe("Sort order"),
    limit: z
      .number()
      .min(1)
      .max(100)
      .optional()
      .default(20)
      .describe("Maximum number of orders to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of orders to skip for pagination"),
  },
  outputSchema: {
    orders: z.array(
      z.object({
        id: z.string(),
        customerId: z.string(),
        customerName: z.string(),
        customerEmail: z.string(),
        orderDate: z.date(),
        status: z.string(),
        total: z.number(),
        itemCount: z.number(),
      }),
    ),
    hasMore: z.boolean(),
  },
};

export const searchOrdersToolDefinition = {
  title: "Search Orders",
  description:
    "Search and filter orders by date range, status, total amount, and customer with sorting and pagination",
  ...searchOrdersSchema,
};

/**
 * Search and filter orders with flexible criteria
 */
export async function search_orders({
  startDate,
  endDate,
  status,
  minTotal,
  maxTotal,
  customerId,
  sortBy = "orderDate",
  sortOrder = "desc",
  limit = 20,
  offset = 0,
}: {
  startDate?: string;
  endDate?: string;
  status?: string;
  minTotal?: number;
  maxTotal?: number;
  customerId?: number;
  sortBy?: "orderDate" | "total" | "status";
  sortOrder?: "asc" | "desc";
  limit?: number /* max 100 */;
  offset?: number;
}): Promise<{
  orders: Array<{
    id: string;
    customerId: string;
    customerName: string;
    customerEmail: string;
    orderDate: Date;
    status: string;
    total: number;
    itemCount: number;
  }>;
  hasMore: boolean;
}> {
  await new Promise((resolve) => setTimeout(resolve, 100));

  const whereClause: any = {};

  if (startDate || endDate) {
    whereClause.orderDate = {};
    if (startDate) whereClause.orderDate.gte = new Date(startDate);
    if (endDate) whereClause.orderDate.lte = new Date(endDate);
  }

  if (status) {
    whereClause.status = status;
  }

  if (minTotal !== undefined || maxTotal !== undefined) {
    whereClause.total = {};
    if (minTotal !== undefined) whereClause.total.gte = minTotal;
    if (maxTotal !== undefined) whereClause.total.lte = maxTotal;
  }

  if (customerId !== undefined) {
    whereClause.customerId = customerId;
  }

  const total = await db.order.count({ where: whereClause });

  const orders = await db.order.findMany({
    where: whereClause,
    include: {
      customer: {
        select: {
          name: true,
          email: true,
        },
      },
      _count: {
        select: {
          orderItems: true,
        },
      },
    },
    orderBy: { [sortBy]: sortOrder },
    take: limit,
    skip: offset,
  });

  const formattedOrders = orders.map((order) => ({
    id: order.id,
    customerId: order.customerId,
    customerName: order.customer.name,
    customerEmail: order.customer.email,
    orderDate: order.orderDate,
    status: order.status,
    total: order.total,
    itemCount: order._count.orderItems,
  }));

  return {
    orders: formattedOrders,
    hasMore: offset + orders.length < total,
  };
}
