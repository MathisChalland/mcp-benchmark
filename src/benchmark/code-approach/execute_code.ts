import { z } from "zod";
import { getCustomerById } from "../tools/customer/getCustomerById";
import { getManyCustomers } from "../tools/customer/getManyCustomers";
import { getProductById } from "../tools/product/getProductById";
import { getManyProducts } from "../tools/product/getManyProducts";
import { getEmployeeById } from "../tools/employee/getEmployeeById";
import { getManyEmployees } from "../tools/employee/getManyEmployees";
import { getOrderById } from "../tools/order/getOrderById";
import { getManyOrders } from "../tools/order/getManyOrders";
import { getOrderTotal } from "../tools/order/getOrderTotal";
import { getProductSales } from "../tools/product/getProductSales";
import { getSupplierById } from "../tools/supplier/getSupplierById";
import { getManySuppliers } from "../tools/supplier/getManySuppliers";
import { getShipperById } from "../tools/shipper/getShipperById";
import { getManyShippers } from "../tools/shipper/getManyShippers";
import { getOrderDetails } from "../tools/order/getOrderDetails";
import { getManyOrderDetails } from "../tools/order/getManyOrderDetails";
import { getCategoryById } from "../tools/category/getCategoryById";
import { getManyCategories } from "../tools/category/getManyCategories";
import { getToolsAPI } from "./api";

export const executeCodeSchema = {
  inputSchema: {
    code: z.string().describe("JavaScript code to execute"),
  },
};

export const executeCodeToolDefinition = {
  title: "Execute Code",
  description: `Execute JavaScript code to solve the given task.
  
  IMPORTANT: Your code is executed directly as the body of an async function - do NOT wrap it in another function.
  Write your code as if you are already inside an async function body.
  
  WRONG - Do not do this:
  async function main() {
    const product = await getProductById({ productId: 1 });
    const supplier = await getSupplierById({ supplierId: product.supplierId });
    return { productName: product.name, supplierName: supplier.companyName };
  }
  main();
  
  CORRECT - Write code directly like this:
  const product = await getProductById({ productId: 1 });
  const supplier = await getSupplierById({ supplierId: product.supplierId });
  return { productName: product.name, supplierName: supplier.companyName };
  
  Your code can use await directly and must end with a return statement containing the final result.
  
  Available functions (already in scope, use directly):
  ${getToolsAPI()}
  `,
  ...executeCodeSchema,
};

// eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-member-access, @typescript-eslint/no-empty-function
const AsyncFunction = Object.getPrototypeOf(async function () {}).constructor;

export async function execute_code(code: string): Promise<{
  result: unknown;
  logs?: string[];
  error?: string;
}> {
  const logs: string[] = [];

  // Create sandbox with available functions
  const sandbox = {
    getCustomerById,
    getManyCustomers,
    getProductById,
    getManyProducts,
    getProductSales,
    getEmployeeById,
    getManyEmployees,
    getOrderById,
    getManyOrders,
    getOrderDetails,
    getManyOrderDetails,
    getOrderTotal,
    getSupplierById,
    getManySuppliers,
    getShipperById,
    getManyShippers,
    getCategoryById,
    getManyCategories,
    console: {
      log: (...args: unknown[]) => {
        logs.push(args.map(String).join(" "));
      },
    },
  };

  try {
    // Create an async function with sandbox variables as parameters
    const paramNames = Object.keys(sandbox);
    const paramValues = Object.values(sandbox);

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call
    const fn = new AsyncFunction(...paramNames, code);

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment, @typescript-eslint/no-unsafe-call
    const result = await fn(...paramValues);

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
