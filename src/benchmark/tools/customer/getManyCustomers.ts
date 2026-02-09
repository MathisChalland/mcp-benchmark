import { db } from "@/server/db";
import { createWhereClauseBuilder } from "@/lib/db-helpers";
import { z } from "zod";
import type { Customer } from "../../code-approach/types";

export const searchCustomersSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe(
        "Search term to match against company name, contact name, city, or country",
      ),
    city: z.string().optional().describe("Filter by city"),
    country: z.string().optional().describe("Filter by country"),
    region: z.string().optional().describe("Filter by region"),
    sortBy: z
      .enum([
        "companyName",
        "contactName",
        "city",
        "country",
        "region",
        "postalCode",
      ])
      .optional()
      .default("companyName")
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
};

export const searchCustomersToolDefinition = {
  title: "Search Customers",
  description:
    "Search and filter customers from the database with sorting and pagination",
  ...searchCustomersSchema,
};

const w = createWhereClauseBuilder<Customer>();

/**
 * Search and filter customers from the database with sorting and pagination
 */
export async function getManyCustomers({
  searchTerm,
  city,
  country,
  region,
  sortBy = "companyName",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  city?: string;
  country?: string;
  region?: string;
  sortBy?:
    | "companyName"
    | "contactName"
    | "city"
    | "country"
    | "region"
    | "postalCode";
  sortOrder?: "asc" | "desc";
  limit?: number /*max 100*/;
  offset?: number;
}): Promise<{
  customers: Array<Customer>;
  hasMore: boolean;
}> {
  const where = w.combine(
    w.search(["companyName", "contactName", "city", "country"], searchTerm),
    w.exact("city", city),
    w.exact("country", country),
    w.exact("region", region),
  );

  const customers = await db.customer.findMany({
    where,
    orderBy: {
      [sortBy]: sortOrder,
    },
    take: limit + 1,
    skip: offset,
  });

  const hasMore = customers.length > limit;
  if (hasMore) customers.pop();

  return {
    customers,
    hasMore,
  };
}
