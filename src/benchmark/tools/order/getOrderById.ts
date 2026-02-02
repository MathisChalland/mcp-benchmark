import { z } from "zod";
import type { Order, OrderDetail, Customer, Employee } from "../types";
import { db } from "@/server/db";

export const getOrderByIdSchema = {
  inputSchema: {
    orderId: z.number().int().describe("The ID of the order to retrieve"),
    includeDetails: z
      .boolean()
      .optional()
      .default(false)
      .describe("Whether to include order details (line items)"),
    includeCustomer: z
      .boolean()
      .optional()
      .default(false)
      .describe("Whether to include customer information"),
    includeEmployee: z
      .boolean()
      .optional()
      .default(false)
      .describe("Whether to include employee information"),
  },
};

export const getOrderByIdToolDefinition = {
  title: "Get Order By ID",
  description:
    "Retrieves an order by its ID from the database, with optional related data",
  ...getOrderByIdSchema,
};

export interface OrderWithRelations extends Order {
  details?: OrderDetail[];
  customer?: Customer | null;
  employee?: Employee | null;
}

/**
 * Retrieves an order by its ID from the database
 * Optionally includes order details, customer, and employee information
 */
export async function getOrderById({
  orderId,
  includeDetails = false,
  includeCustomer = false,
  includeEmployee = false,
}: {
  orderId: number;
  includeDetails?: boolean;
  includeCustomer?: boolean;
  includeEmployee?: boolean;
}): Promise<
  Order & {
    details?: OrderDetail[];
    customer?: Customer | null;
    employee?: Employee | null;
  }
> {
  const order = await db.order.findUnique({
    where: {
      id: orderId,
    },
    include: {
      details: includeDetails,
      customer: includeCustomer,
      employee: includeEmployee,
    },
  });

  if (!order) {
    throw new Error(`Order with ID ${orderId} not found`);
  }

  return {
    ...order,
    orderDate: order.orderDate?.toISOString() ?? null,
    requiredDate: order.requiredDate?.toISOString() ?? null,
    shippedDate: order.shippedDate?.toISOString() ?? null,
    customer: order.customer,
    employee: order.employee
      ? {
          ...order.employee,
          hireDate: order.employee?.hireDate?.toISOString() ?? null,
          birthDate: order.employee?.birthDate?.toISOString() ?? null,
        }
      : null,
    details: order.details,
  };
}
