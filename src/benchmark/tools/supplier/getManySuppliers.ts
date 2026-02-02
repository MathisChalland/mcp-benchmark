import { z } from "zod";
import { db } from "@/server/db";
import type { Supplier } from "../../code-approach/types";
import { createWhereClauseBuilder } from "@/lib/db-helpers";

export const getManySuppliersSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe(
        "Search term to match against supplier company name, contact name, or city",
      ),
    companyName: z.string().optional().describe("Filter by exact company name"),
    contactName: z
      .string()
      .optional()
      .describe("Filter by contact name (partial match)"),
    city: z.string().optional().describe("Filter by supplier city"),
    region: z.string().optional().describe("Filter by supplier region"),
    country: z.string().optional().describe("Filter by supplier country"),
    sortBy: z
      .enum(["id", "companyName", "contactName", "city", "region", "country"])
      .optional()
      .describe("Field to sort by"),
    sortOrder: z
      .enum(["asc", "desc"])
      .optional()
      .describe("Sort order (ascending or descending)"),
    limit: z
      .number()
      .min(1)
      .max(100)
      .optional()
      .describe("Maximum number of suppliers to retrieve"),
    offset: z
      .number()
      .min(0)
      .optional()
      .describe("Number of suppliers to skip for pagination"),
  },
};

export const getManySuppliersToolDefinition = {
  title: "Get Many Suppliers",
  description:
    "Retrieve multiple suppliers from the database with optional filtering, sorting, and pagination",
  ...getManySuppliers,
};

const w = createWhereClauseBuilder<Supplier>();

/**
 * Retrieves multiple suppliers from the database with optional filtering, sorting, and pagination
 */
export async function getManySuppliers({
  searchTerm,
  companyName,
  contactName,
  city,
  region,
  country,
  sortBy = "companyName",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  companyName?: string;
  contactName?: string;
  city?: string;
  region?: string;
  country?: string;
  sortBy?: "id" | "companyName" | "contactName" | "city" | "region" | "country";
  sortOrder?: "asc" | "desc";
  limit?: number;
  offset?: number;
}): Promise<Supplier[]> {
  const where = w.combine(
    w.search(["companyName", "contactName", "city"], searchTerm),
    w.exact("companyName", companyName),
    w.search(["contactName"], contactName),
    w.exact("city", city),
    w.exact("region", region),
    w.exact("country", country),
  );

  const suppliers = await db.supplier.findMany({
    where,
    orderBy: { [sortBy]: sortOrder },
    take: limit,
    skip: offset,
  });

  return suppliers;
}
