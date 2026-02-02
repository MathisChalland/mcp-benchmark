import { z } from "zod";
import { db } from "@/server/db";
import type { Shipper } from "../types";

export const getShipperByIdSchema = {
  inputSchema: {
    shipperId: z.string().describe("The ID of the shipper to retrieve"),
  },
};

export const getShipperByIdToolDefinition = {
  title: "Get Shipper",
  description: "Retrieves a shipper by its ID from the database",
  ...getShipperByIdSchema,
};

/**
 * Retrieves a shipper by its ID from the database
 */
export async function getShipperById({
  shipperId,
}: {
  shipperId: number;
}): Promise<Shipper> {
  const shipper = await db.shipper.findUnique({
    where: {
      id: shipperId,
    },
  });

  if (!shipper) {
    throw new Error(`Shipper with ID ${shipperId} not found`);
  }

  return shipper;
}
