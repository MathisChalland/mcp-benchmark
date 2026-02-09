import { z } from "zod";
import type { Customer } from "../../code-approach/types";
import { db } from "@/server/db";

export const getCustomerSchema = {
  inputSchema: {
    customerId: z.string().describe("The ID of the customer to retrieve"),
  },
};

export const getCustomerToolDefinition = {
  title: "Get Customer",
  description: "Retrieves a customer by their ID from the database",
  ...getCustomerSchema,
};
/**
 * Retrieves a customer by their ID or Email from the database
 */
export async function getCustomerById({
  customerId,
}: {
  customerId: string;
}): Promise<Customer> {
  const customer = await db.customer.findUnique({
    where: {
      id: customerId,
    },
  });
  if (!customer) {
    throw new Error(`Customer with ID ${customerId} not found`);
  }
  return customer;
}
