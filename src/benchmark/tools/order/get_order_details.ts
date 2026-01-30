import { z } from "zod";
import type { Order } from "../types";
import { db } from "@/server/db";

export const getOrderDetailsSchema = {
  inputSchema: {
    orderId: z.string().describe("The ID of the order to retrieve"),
  },
  // outputSchema: {
  //   id: z.string(),
  //   orderDate: z.string().describe("ISO date string"),
  //   status: z.string(),
  //   total: z.number(),
  //   customer: z.object({
  //     id: z.string(),
  //     name: z.string(),
  //     email: z.string(),
  //   }),
  //   items: z.array(
  //     z.object({
  //       id: z.string(),
  //       productId: z.string(),
  //       productName: z.string(),
  //       quantity: z.number(),
  //       price: z.number(),
  //     }),
  //   ),
  // },
};

/**
 * Get detailed information about a specific order
 * @param orderId - The ID of the order to retrieve
 */
export async function get_order_details({
  orderId,
}: {
  orderId: string;
}): Promise<
  Omit<Order, "customerId"> & {
    customer: { id: string; name: string; email: string };
    items: Array<{
      id: string;
      productId: string;
      productName: string;
      quantity: number;
      price: number;
    }>;
  }
> {
  const order = await db.order.findUnique({
    where: { id: orderId },
    include: {
      customer: true,
      orderItems: {
        include: {
          product: true,
        },
      },
    },
  });

  if (!order) {
    throw new Error(`Order with ID ${orderId} not found`);
  }

  return {
    id: order.id,
    orderDate: order.orderDate.toISOString(),
    status: order.status,
    total: order.total,
    customer: {
      id: order.customer.id,
      name: order.customer.name,
      email: order.customer.email,
    },
    items: order.orderItems.map((item) => ({
      id: item.id,
      productId: item.productId,
      productName: item.product.name,
      quantity: item.quantity,
      price: item.price,
    })),
  };
}

export const getOrderDetailsToolDefinition = {
  title: "Get Order Details",
  description:
    "Get complete details of a specific order including customer info and all items",
  ...getOrderDetailsSchema,
};
