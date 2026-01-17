import { db } from "@/server/db";
import { z } from "zod";

export const getRevenueAnalysisSchema = {
  inputSchema: {
    startDate: z.string().optional().describe("Start date for analysis"),
    endDate: z.string().optional().describe("End date for analysis"),
    groupBy: z
      .enum(["day", "week", "month", "year"])
      .optional()
      .default("month")
      .describe("Time period to group revenue by"),
  },
  outputSchema: {
    summary: z.object({
      totalRevenue: z.number(),
      totalOrders: z.number(),
      averageOrderValue: z.number(),
      periodCount: z.number(),
    }),
    periods: z.array(
      z.object({
        period: z.string(),
        revenue: z.number(),
        orderCount: z.number(),
        averageOrderValue: z.number(),
      }),
    ),
  },
};

export const getRevenueAnalysisToolDefinition = {
  title: "Get Revenue Metrics",
  description:
    "Get Revenue metrics over time with grouping by day, week, month, or year",
  ...getRevenueAnalysisSchema,
};

/**
 * Get comprehensive revenue metrics with time-based grouping
 */
export async function get_revenue_analysis({
  startDate,
  endDate,
  groupBy = "month",
}: {
  startDate?: string;
  endDate?: string;
  groupBy?: "day" | "week" | "month" | "year";
}): Promise<{
  summary: {
    totalRevenue: number;
    totalOrders: number;
    averageOrderValue: number;
    periodCount: number;
  };
  periods: Array<{
    period: string;
    revenue: number;
    orderCount: number;
    averageOrderValue: number;
  }>;
}> {
  await new Promise((resolve) => setTimeout(resolve, 100));

  const start = startDate ? new Date(startDate) : undefined;
  const end = endDate ? new Date(endDate) : undefined;

  const whereClause: any = {};
  if (start || end) {
    whereClause.orderDate = {};
    if (start) whereClause.orderDate.gte = start;
    if (end) whereClause.orderDate.lte = end;
  }

  const orders = await db.order.findMany({
    where: whereClause,
    select: {
      id: true,
      total: true,
      orderDate: true,
    },
    orderBy: { orderDate: "asc" },
  });

  const periodMap = new Map<string, { revenue: number; orderCount: number }>();

  orders.forEach((order) => {
    const periodKey = getPeriodKey(order.orderDate, groupBy);
    const existing = periodMap.get(periodKey) || { revenue: 0, orderCount: 0 };
    existing.revenue += order.total;
    existing.orderCount += 1;
    periodMap.set(periodKey, existing);
  });

  const periods = Array.from(periodMap.entries())
    .map(([period, data]) => ({
      period,
      revenue: Math.round(data.revenue * 100) / 100,
      orderCount: data.orderCount,
      averageOrderValue:
        data.orderCount > 0
          ? Math.round((data.revenue / data.orderCount) * 100) / 100
          : 0,
    }))
    .sort((a, b) => a.period.localeCompare(b.period));

  const totalRevenue = orders.reduce((sum, o) => sum + o.total, 0);
  const totalOrders = orders.length;
  const averageOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0;

  const result = {
    summary: {
      totalRevenue: Math.round(totalRevenue * 100) / 100,
      totalOrders,
      averageOrderValue: Math.round(averageOrderValue * 100) / 100,
      periodCount: periods.length,
    },
    periods,
  };

  return result;
}

function getPeriodKey(
  date: Date,
  groupBy: "day" | "week" | "month" | "year",
): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");

  switch (groupBy) {
    case "day":
      return `${year}-${month}-${day}`;
    case "week":
      // Get ISO week number
      const d = new Date(date);
      d.setHours(0, 0, 0, 0);
      d.setDate(d.getDate() + 3 - ((d.getDay() + 6) % 7));
      const week1 = new Date(d.getFullYear(), 0, 4);
      const weekNum = Math.ceil(
        ((d.getTime() - week1.getTime()) / 86400000 + 1) / 7,
      );
      return `${year}-W${String(weekNum).padStart(2, "0")}`;
    case "month":
      return `${year}-${month}`;
    case "year":
      return `${year}`;
    default:
      return `${year}-${month}`;
  }
}
