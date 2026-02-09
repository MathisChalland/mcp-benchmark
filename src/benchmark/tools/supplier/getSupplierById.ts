import { z } from "zod";
import { db } from "@/server/db";
import type { Supplier } from "../../code-approach/types";

export const getSupplierByIdSchema = {
  inputSchema: {
    supplierId: z.string().describe("The ID of the supplier to retrieve"),
  },
};

export const getSupplierByIdToolDefinition = {
  title: "Get Supplier",
  description: "Retrieves a supplier by its ID from the database",
  ...getSupplierByIdSchema,
};

/**
 * Retrieves a supplier by its ID from the database
 */
export async function getSupplierById({
  supplierId,
}: {
  supplierId: string;
}): Promise<Supplier> {
  const supplier = await db.supplier.findUnique({
    where: {
      id: supplierId,
    },
  });

  if (!supplier) {
    throw new Error(`Supplier with ID ${supplierId} not found`);
  }

  return supplier;
}
