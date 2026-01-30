import { db } from "@/server/db";
import { Prisma } from "@prisma/client";
import { z } from "zod";

export const getProductStatsSchema = {
  inputSchema: {
    productId: z.string().optional().describe("Filter by specific product ID"),
    startDate: z.string().optional().describe("Start date filter"),
    endDate: z.string().optional().describe("End date filter"),
    limit: z.number().optional().describe("Limit number of products to return"),
    offset: z
      .number()
      .optional()
      .describe("Number of products to skip for pagination"),
    sortBy: z
      .enum([
        "totalRevenue",
        "totalQuantitySold",
        "orderCount",
        "averageQuantityPerOrder",
        "productName",
      ])
      .optional()
      .describe("Field to sort by"),
    sortOrder: z
      .enum(["asc", "desc"])
      .optional()
      .describe("Sort order (ascending or descending)"),
  },
  // outputSchema: {
  //   products: z.array(
  //     z.object({
  //       productId: z.string(),
  //       productName: z.string(),
  //       totalQuantitySold: z.number(),
  //       totalRevenue: z.number(),
  //       orderCount: z.number(),
  //       averageQuantityPerOrder: z.number(),
  //     }),
  //   ),
  // },
};

/**
 * Get product sales statistics
 */
export async function get_product_stats({
  productId,
  startDate,
  endDate,
  limit = 20,
  offset = 0,
  sortBy = "totalRevenue",
  sortOrder = "desc",
}: {
  productId?: string;
  startDate?: string;
  endDate?: string;
  limit?: number /* max 100 */;
  offset?: number;
  sortBy?:
    | "totalRevenue"
    | "totalQuantitySold"
    | "orderCount"
    | "averageQuantityPerOrder"
    | "productName";
  sortOrder?: "asc" | "desc";
}): Promise<
  Array<{
    averageQuantityPerOrder: number;
    productId: string;
    productName: string;
    totalQuantitySold: number;
    totalRevenue: number;
    orderCount: number;
  }>
> {
  const orderWhere: Prisma.OrderItemWhereInput = {
    ...((startDate ?? endDate)
      ? {
          order: {
            orderDate: {
              ...(startDate ? { gte: new Date(startDate) } : {}),
              ...(endDate ? { lte: new Date(endDate) } : {}),
            },
          },
        }
      : {}),
    ...(productId ? { productId } : {}),
  };

  const orderItems = await db.orderItem.findMany({
    where: orderWhere,
    include: {
      product: true,
      order: true,
    },
  });

  const productMap = new Map<
    string,
    {
      productId: string;
      productName: string;
      totalQuantitySold: number;
      totalRevenue: number;
      orderCount: number;
    }
  >();

  orderItems.forEach((item) => {
    const existing = productMap.get(item.productId) ?? {
      productId: item.productId,
      productName: item.product.name,
      totalQuantitySold: 0,
      totalRevenue: 0,
      orderCount: 0,
    };

    existing.totalQuantitySold += item.quantity;
    existing.totalRevenue += item.price * item.quantity;
    existing.orderCount += 1;

    productMap.set(item.productId, existing);
  });

  const products = Array.from(productMap.values())
    .map((p) => ({
      ...p,
      averageQuantityPerOrder:
        p.orderCount > 0 ? p.totalQuantitySold / p.orderCount : 0,
    }))
    .sort((a, b) => {
      const modifier = sortOrder === "asc" ? 1 : -1;
      if (sortBy === "productName") {
        return modifier * a.productName.localeCompare(b.productName);
      }
      return modifier * (a[sortBy] - b[sortBy]);
    })
    .slice(offset, offset + limit);

  return products;
}

export const getProductStatsToolDefinition = {
  title: "Get Product Statistics",
  description:
    "Get comprehensive product sales statistics including quantities sold, revenue, and order counts",
  ...getProductStatsSchema,
};
