import { z } from "zod";
import { VM } from "vm2";
import { get_product_stats } from "./product/get_product_stats";
import { get_customer } from "./customer/get_customer";
import { get_order_details } from "./order/get_order_details";
import { search_customers } from "./customer/search_customers";
import { get_customer_orders } from "./order/get_customer_orders";
import { search_orders } from "./order/search_orders";
import { get_revenue_analysis } from "./order/get_revenue_analysis";
import { search_products } from "./product/search_products";
import { get_inventory_status } from "./product/get_inventory_status";
import { get_product } from "./product/get_product";

export const executeCodeSchema = {
  inputSchema: {
    code: z.string().describe("JavaScript code to execute"),
  },
  outputSchema: {
    result: z.any(),
    logs: z.array(z.string()).optional(),
    error: z.string().optional(),
  },
};

export async function execute_code(code: string): Promise<{
  result: any;
  logs?: string[];
  error?: string;
}> {
  const logs: string[] = [];

  try {
    const vm = new VM({
      timeout: 60000,
      sandbox: {
        get_customer,
        search_customers,
        get_customer_orders,
        get_order_details,
        search_orders,
        get_revenue_analysis,
        get_product_stats,
        get_product,
        search_products,
        get_inventory_status,
        console: {
          log: (...args: any[]) => {
            logs.push(args.map(String).join(" "));
          },
        },
      },
    });

    const result = await vm.run(`
      (async () => {
        ${code}
      })()
    `);

    return {
      result,
      logs: logs.length > 0 ? logs : undefined,
    };
  } catch (error) {
    return {
      result: null,
      error: error instanceof Error ? error.message : String(error),
      logs: logs.length > 0 ? logs : undefined,
    };
  }
}
