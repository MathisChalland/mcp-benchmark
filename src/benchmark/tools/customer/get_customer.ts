import { z } from "zod";
import type { Customer } from "../types";
import { db } from "@/server/db";

export const getCustomerSchema = {
  inputSchema: {
    customerId: z
      .string()
      .describe("The ID of the customer to retrieve")
      .optional(),
    email: z
      .email()
      .describe("The email of the customer to retrieve")
      .optional(),
  },
  outputSchema: {
    id: z.string(),
    name: z.string(),
    email: z.string(),
    address: z.string(),
    createdAt: z.string().describe("ISO date string"),
  },
};

export const getCustomerToolDefinition = {
  title: "Get Customer",
  description: "Retrieves a customer by their ID or Email from the database",
  ...getCustomerSchema,
};
/**
 * Retrieves a customer by their ID or Email from the database
 */
export async function get_customer({
  customerId,
  email,
}: {
  customerId?: string;
  email?: string;
}): Promise<Customer> {
  await new Promise((resolve) => setTimeout(resolve, 100));
  const customer = await db.customer.findFirst({
    where: {
      OR: [customerId ? { id: customerId } : {}, email ? { email } : {}],
    },
  });
  if (!customer) {
    throw new Error(
      `Customer with ID ${customerId} or email ${email} not found`,
    );
  }
  return {
    ...customer,
    createdAt: customer.createdAt.toISOString(),
  };
}
