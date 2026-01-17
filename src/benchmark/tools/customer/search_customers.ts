import { db } from "@/server/db";
import { z } from "zod";
import type { Customer } from "../types";

export const searchCustomersSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe("Search term to match against customer name or email"),
    minOrders: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum number of orders a customer must have"),
    maxOrders: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum number of orders a customer can have"),
    minTotalSpent: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum total amount spent by customer"),
    maxTotalSpent: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum total amount spent by customer"),
    registeredAfter: z
      .string()
      .optional()
      .describe("Filter customers registered after this date"),
    registeredBefore: z
      .string()
      .optional()
      .describe("Filter customers registered before this date"),
    sortBy: z
      .enum(["name", "email", "createdAt", "orderCount", "totalSpent"])
      .optional()
      .default("name")
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
      .describe("Maximum number of customers to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of customers to skip for pagination"),
  },
  outputSchema: {
    customers: z.array(
      z.object({
        id: z.string(),
        name: z.string(),
        email: z.string(),
        address: z.string(),
        createdAt: z.date(),
        orderCount: z.number(),
        totalSpent: z.number(),
      }),
    ),
    hasMore: z.boolean(),
  },
};

export const searchCustomersToolDefinition = {
  title: "Search Customers",
  description:
    "Search and filter customers by name, email, order count, total spent, and registration date with sorting and pagination",
  ...searchCustomersSchema,
};

/**
 * Search and filter customers with flexible criteria
 */
export async function search_customers({
  searchTerm,
  minOrders,
  maxOrders,
  minTotalSpent,
  maxTotalSpent,
  registeredAfter,
  registeredBefore,
  sortBy = "name",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  minOrders?: number;
  maxOrders?: number;
  minTotalSpent?: number;
  maxTotalSpent?: number;
  registeredAfter?: string;
  registeredBefore?: string;
  sortBy?: "name" | "email" | "createdAt" | "orderCount" | "totalSpent";
  sortOrder?: "asc" | "desc";
  limit?: number /*max 100*/;
  offset?: number;
}): Promise<{
  customers: Array<
    Customer & {
      orderCount: number;
      totalSpent: number;
    }
  >;
  hasMore: boolean;
}> {
  await new Promise((resolve) => setTimeout(resolve, 100));

  const customersWithStats = await db.customer.findMany({
    where: {
      ...(searchTerm
        ? {
            OR: [
              { name: { contains: searchTerm } },
              { email: { contains: searchTerm } },
            ],
          }
        : {}),
      ...(registeredAfter || registeredBefore
        ? {
            createdAt: {
              ...(registeredAfter ? { gte: new Date(registeredAfter) } : {}),
              ...(registeredBefore ? { lte: new Date(registeredBefore) } : {}),
            },
          }
        : {}),
    },
    include: {
      orders: {
        select: {
          total: true,
        },
      },
    },
  });

  let customers = customersWithStats.map((customer) => ({
    id: customer.id,
    name: customer.name,
    email: customer.email,
    address: customer.address,
    createdAt: customer.createdAt,
    orderCount: customer.orders.length,
    totalSpent: customer.orders.reduce((sum, order) => sum + order.total, 0),
  }));

  if (minOrders !== undefined) {
    customers = customers.filter((c) => c.orderCount >= minOrders);
  }
  if (maxOrders !== undefined) {
    customers = customers.filter((c) => c.orderCount <= maxOrders);
  }

  if (minTotalSpent !== undefined) {
    customers = customers.filter((c) => c.totalSpent >= minTotalSpent);
  }
  if (maxTotalSpent !== undefined) {
    customers = customers.filter((c) => c.totalSpent <= maxTotalSpent);
  }

  const total = customers.length;

  customers.sort((a, b) => {
    let comparison = 0;
    switch (sortBy) {
      case "name":
        comparison = a.name.localeCompare(b.name);
        break;
      case "email":
        comparison = a.email.localeCompare(b.email);
        break;
      case "createdAt":
        comparison = a.createdAt.getTime() - b.createdAt.getTime();
        break;
      case "orderCount":
        comparison = a.orderCount - b.orderCount;
        break;
      case "totalSpent":
        comparison = a.totalSpent - b.totalSpent;
        break;
    }
    return sortOrder === "desc" ? -comparison : comparison;
  });

  customers = customers.slice(offset, offset + limit);

  customers = customers.map((c) => ({
    ...c,
    totalSpent: Math.round(c.totalSpent * 100) / 100,
  }));

  return {
    customers,
    hasMore: offset + customers.length < total,
  };
}
