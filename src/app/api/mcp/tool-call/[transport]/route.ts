import {
  get_customer,
  getCustomerToolDefinition,
} from "@/benchmark/tools/customer/get_customer";
import {
  search_customers,
  searchCustomersToolDefinition,
} from "@/benchmark/tools/customer/search_customers";
import {
  get_customer_orders,
  getCustomerOrdersToolDefinition,
} from "@/benchmark/tools/order/get_customer_orders";
import {
  get_order_details,
  getOrderDetailsToolDefinition,
} from "@/benchmark/tools/order/get_order_details";
import {
  get_revenue_analysis,
  getRevenueAnalysisToolDefinition,
} from "@/benchmark/tools/order/get_revenue_analysis";
import {
  search_orders,
  searchOrdersToolDefinition,
} from "@/benchmark/tools/order/search_orders";
import {
  get_inventory_status,
  getInventoryStatusToolDefinition,
} from "@/benchmark/tools/product/get_inventory_status";
import {
  get_product,
  getProductToolDefinition,
} from "@/benchmark/tools/product/get_product";
import {
  get_product_stats,
  getProductStatsToolDefinition,
} from "@/benchmark/tools/product/get_product_stats";
import {
  search_products,
  searchProductsToolDefinition,
} from "@/benchmark/tools/product/search_products";
import { createMcpHandler, withMcpAuth } from "mcp-handler";
import { verifyMcpToken } from "../../verify-token";

const handler = createMcpHandler(
  (server) => {
    server.registerTool(
      "get_customer",
      getCustomerToolDefinition,
      async ({ customerId, email }) => {
        const customer = await get_customer({ customerId, email });
        return {
          content: [{ type: "text", text: JSON.stringify(customer) }],
        };
      },
    );
    server.registerTool(
      "search_customers",
      searchCustomersToolDefinition,
      async (props) => {
        const output = await search_customers(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );

    server.registerTool(
      "get_customer_orders",
      getCustomerOrdersToolDefinition,
      async (props) => {
        const output = await get_customer_orders(props);
        return {
          content: [{ type: "text", text: JSON.stringify({ orders: output }) }],
        };
      },
    );

    server.registerTool(
      "get_order_details",
      getOrderDetailsToolDefinition,
      async (props) => {
        const output = await get_order_details(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );

    server.registerTool(
      "search_orders",
      searchOrdersToolDefinition,
      async (props) => {
        const output = await search_orders(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );

    server.registerTool(
      "get_revenue_analysis",
      getRevenueAnalysisToolDefinition,
      async (props) => {
        const output = await get_revenue_analysis(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );

    server.registerTool(
      "get_product",
      getProductToolDefinition,
      async (props) => {
        const output = await get_product(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );

    server.registerTool(
      "get_product_stats",
      getProductStatsToolDefinition,
      async (props) => {
        const output = await get_product_stats(props);
        return {
          content: [
            { type: "text", text: JSON.stringify({ products: output }) },
          ],
        };
      },
    );

    server.registerTool(
      "search_products",
      searchProductsToolDefinition,
      async (props) => {
        const output = await search_products(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );

    server.registerTool(
      "get_inventory_status",
      getInventoryStatusToolDefinition,
      async (props) => {
        const output = await get_inventory_status(props);
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
        };
      },
    );
  },
  {},
  { basePath: "/api/mcp/tool-call", maxDuration: 60, verboseLogs: true },
);

const authHandler = withMcpAuth(handler, verifyMcpToken, {
  required: true,
  requiredScopes: ["mcp:execute"],
});

export { authHandler as GET, authHandler as POST };
