import { z } from "zod";
import vm from "node:vm";
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

/** Patterns that should never appear in LLM-generated code. */
const BLOCKED_PATTERNS = [
  /process\s*\.\s*env/gi,
  /process\s*\.\s*exit/gi,
  /child_process/gi,
  /require\s*\(/gi,
  /import\s*\(/gi,
  /globalThis/gi,
  /eval\s*\(/gi,
  /Function\s*\(/gi,
  /Deno\b/gi,
  /Bun\b/gi,
  /\bfs\b\s*\.\s*(read|write|unlink|mkdir|rm)/gi,
  /__dirname/gi,
  /__filename/gi,
  /fetch\s*\(/gi,
  /XMLHttpRequest/gi,
  /WebSocket/gi,
  /\.constructor/gi,
  /\.__proto__/gi,
  /Object\s*\.\s*getPrototypeOf/gi,
  /Reflect/gi,
];

function validateCode(code: string): void {
  for (const pattern of BLOCKED_PATTERNS) {
    pattern.lastIndex = 0;
    if (pattern.test(code)) {
      throw new Error(
        `Blocked: code contains forbidden pattern "${pattern.source}"`,
      );
    }
  }
}

const EXECUTION_TIMEOUT_MS = 45_000;

function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  return new Promise<T>((resolve, reject) => {
    const timer = setTimeout(
      () => reject(new Error(`Execution timed out after ${ms} ms`)),
      ms,
    );
    promise.then(resolve, reject).finally(() => clearTimeout(timer));
  });
}

export async function execute_code(code: string): Promise<{
  result: unknown;
  logs?: string[];
  error?: string;
}> {
  const logs: string[] = [];

  try {
    validateCode(code);
  } catch (err) {
    return {
      result: null,
      error: err instanceof Error ? err.message : String(err),
    };
  }

  const sandbox: Record<string, unknown> = {
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
    console: Object.freeze({
      log: (...args: unknown[]) => logs.push(args.map(String).join(" ")),
      warn: (...args: unknown[]) =>
        logs.push(`[warn] ${args.map(String).join(" ")}`),
      error: (...args: unknown[]) =>
        logs.push(`[error] ${args.map(String).join(" ")}`),
    }),
  };

  try {
    const context = vm.createContext(sandbox, {
      codeGeneration: {
        strings: false,
        wasm: false,
      },
    });

    const wrappedCode = `"use strict";\n(async () => {\n${code}\n})();`;

    const script = new vm.Script(wrappedCode, {
      filename: "llm-code.js",
    });

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const rawResult = script.runInContext(context, {
      timeout: 2_000,
    });

    // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
    const result = await withTimeout(
      Promise.resolve(rawResult),
      EXECUTION_TIMEOUT_MS,
    );

    return {
      result,
      logs: logs.length > 0 ? logs : undefined,
    };
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    const sanitizedMessage = message
      .replace(/\/[^\s:]+\//g, "[path]/")
      .replace(/at\s+.+\(.+\)/g, "[stack hidden]");

    return {
      result: null,
      error: sanitizedMessage,
      logs: logs.length > 0 ? logs : undefined,
    };
  }
}
