import { db } from "@/server/db";
import type { Shipper } from "../../code-approach/types";

export const getAllShippersSchema = {
  inputSchema: {},
};

export const getAllShippersToolDefinition = {
  title: "Get All Shippers",
  description: "Retrieves all shippers from the database",
  ...getAllShippersSchema,
};

/**
 * Retrieves all shippers from the database
 */
export async function getAllShippers(): Promise<Shipper[]> {
  const shippers = await db.shipper.findMany();
  return shippers;
}
