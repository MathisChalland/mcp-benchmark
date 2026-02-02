import { z } from "zod";
import { db } from "@/server/db";
import { createWhereClauseBuilder } from "@/lib/db-helpers";
import type { Order } from "../../code-approach/types";

export const getManyOrdersSchema = {
  inputSchema: {
    orderDateFrom: z
      .string()
      .optional()
      .describe("Filter orders placed on or after this date (ISO date string)"),
    orderDateTo: z
      .string()
      .optional()
      .describe(
        "Filter orders placed on or before this date (ISO date string)",
      ),
    requiredDateFrom: z
      .string()
      .optional()
      .describe(
        "Filter orders with required date on or after this date (ISO date string)",
      ),
    requiredDateTo: z
      .string()
      .optional()
      .describe(
        "Filter orders with required date on or before this date (ISO date string)",
      ),
    shippedDateFrom: z
      .string()
      .optional()
      .describe(
        "Filter orders shipped on or after this date (ISO date string)",
      ),
    shippedDateTo: z
      .string()
      .optional()
      .describe(
        "Filter orders shipped on or before this date (ISO date string)",
      ),
    customerId: z.string().optional().describe("Filter by customer ID"),
    employeeId: z.number().int().optional().describe("Filter by employee ID"),
    shipVia: z.number().int().optional().describe("Filter by shipper ID"),
    minFreight: z
      .number()
      .min(0)
      .optional()
      .describe("Minimum freight amount filter"),
    maxFreight: z
      .number()
      .min(0)
      .optional()
      .describe("Maximum freight amount filter"),
    shipCity: z.string().optional().describe("Filter by shipping city"),
    shipRegion: z.string().optional().describe("Filter by shipping region"),
    shipCountry: z.string().optional().describe("Filter by shipping country"),
    shipPostalCode: z
      .string()
      .optional()
      .describe("Filter by shipping postal code"),
    searchTerm: z
      .string()
      .optional()
      .describe("Search term to match against ship name or ship address"),
    sortBy: z
      .enum([
        "orderDate",
        "requiredDate",
        "shippedDate",
        "freight",
        "shipCity",
        "shipCountry",
        "customerId",
        "employeeId",
      ])
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
};

export const getManyOrdersToolDefinition = {
  title: "Get Many Orders",
  description:
    "Retrieves multiple orders from the database with filtering, sorting, and pagination",
  ...getManyOrdersSchema,
};

const w = createWhereClauseBuilder<Order>();

/**
 * Retrieves multiple orders from the database with filtering, sorting, and pagination
 */
export async function getManyOrders({
  limit = 20,
  offset = 0,
  orderDateFrom,
  orderDateTo,
  requiredDateFrom,
  requiredDateTo,
  shippedDateFrom,
  shippedDateTo,
  customerId,
  employeeId,
  shipVia,
  minFreight,
  maxFreight,
  shipCity,
  shipRegion,
  shipCountry,
  shipPostalCode,
  searchTerm,
  sortBy = "orderDate",
  sortOrder = "desc",
}: {
  limit?: number;
  offset?: number;
  orderDateFrom?: string;
  orderDateTo?: string;
  requiredDateFrom?: string;
  requiredDateTo?: string;
  shippedDateFrom?: string;
  shippedDateTo?: string;
  customerId?: string;
  employeeId?: number;
  shipVia?: number;
  minFreight?: number;
  maxFreight?: number;
  shipCity?: string;
  shipRegion?: string;
  shipCountry?: string;
  shipPostalCode?: string;
  searchTerm?: string;
  sortBy?:
    | "orderDate"
    | "requiredDate"
    | "shippedDate"
    | "freight"
    | "shipCity"
    | "shipCountry"
    | "customerId"
    | "employeeId";
  sortOrder?: "asc" | "desc";
}): Promise<{
  orders: Order[];
  hasMore: boolean;
}> {
  const where = w.combine(
    w.range(
      "orderDate",
      orderDateFrom ? new Date(orderDateFrom) : undefined,
      orderDateTo ? new Date(orderDateTo) : undefined,
    ),
    w.range(
      "requiredDate",
      requiredDateFrom ? new Date(requiredDateFrom) : undefined,
      requiredDateTo ? new Date(requiredDateTo) : undefined,
    ),
    w.range(
      "shippedDate",
      shippedDateFrom ? new Date(shippedDateFrom) : undefined,
      shippedDateTo ? new Date(shippedDateTo) : undefined,
    ),
    w.exact("customerId", customerId),
    w.exact("employeeId", employeeId),
    w.exact("shipVia", shipVia),
    w.range("freight", minFreight, maxFreight),
    w.exact("shipCity", shipCity),
    w.exact("shipRegion", shipRegion),
    w.exact("shipCountry", shipCountry),
    w.exact("shipPostalCode", shipPostalCode),
    w.search(["shipName", "shipAddress"], searchTerm),
  );

  const orders = await db.order.findMany({
    where,
    orderBy: { [sortBy]: sortOrder },
    take: limit + 1,
    skip: offset,
  });

  const hasMore = orders.length > limit;
  if (hasMore) {
    orders.pop();
  }

  return {
    orders: orders.map((order) => ({
      ...order,
      orderDate: order.orderDate?.toISOString() ?? null,
      requiredDate: order.requiredDate?.toISOString() ?? null,
      shippedDate: order.shippedDate?.toISOString() ?? null,
    })),
    hasMore,
  };
}
