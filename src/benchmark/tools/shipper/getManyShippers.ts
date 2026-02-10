import { db } from "@/server/db";
import { createWhereClauseBuilder } from "@/lib/db-helpers";
import { z } from "zod";
import type { Shipper } from "../../code-approach/types";

export const getManyShippersSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe("Search term to match against company name or phone"),
    limit: z
      .number()
      .min(1)
      .max(100)
      .optional()
      .default(20)
      .describe("Maximum number of shippers to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of shippers to skip for pagination"),
  },
};

export const getManyShippersToolDefinition = {
  title: "Get Many Shippers",
  description:
    "Search and filter shippers from the database with sorting and pagination",
  ...getManyShippersSchema,
};

const w = createWhereClauseBuilder<Shipper>();

/**
 * Search and filter shippers from the database with sorting and pagination
 */
export async function getManyShippers({
  searchTerm,
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  limit?: number /*max 100*/;
  offset?: number;
}): Promise<{
  shippers: Array<Shipper>;
  hasMore: boolean;
}> {
  const where = w.combine(w.search(["companyName", "phone"], searchTerm));

  const shippers = await db.shipper.findMany({
    where,
    take: limit + 1,
    skip: offset,
  });

  const hasMore = shippers.length > limit;
  if (hasMore) shippers.pop();

  return {
    shippers,
    hasMore,
  };
}
