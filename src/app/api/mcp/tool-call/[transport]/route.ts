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
import { createMcpHandler } from "mcp-handler";

const handler = createMcpHandler(
  (server) => {
    server.registerTool(
      "get_customer",
      getCustomerToolDefinition,
      async ({ customerId, email }) => {
        const customer = await get_customer({ customerId, email });
        return {
          content: [{ type: "text", text: JSON.stringify(customer) }],
          structuredContent: customer as any,
        };
      },
    );
    server.registerTool(
      "search_customers",
      searchCustomersToolDefinition,
      async ({
        searchTerm,
        minOrders,
        maxOrders,
        minTotalSpent,
        maxTotalSpent,
        registeredAfter,
        registeredBefore,
        sortBy,
        sortOrder,
        limit,
        offset,
      }) => {
        const output = await search_customers({
          searchTerm,
          minOrders,
          maxOrders,
          minTotalSpent,
          maxTotalSpent,
          registeredAfter,
          registeredBefore,
          sortBy,
          sortOrder,
          limit,
          offset,
        });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output,
        };
      },
    );

    server.registerTool(
      "get_customer_orders",
      getCustomerOrdersToolDefinition,
      async ({ customerId, startDate, endDate, status }) => {
        const output = await get_customer_orders({
          customerId,
          startDate,
          endDate,
          status,
        });
        return {
          content: [{ type: "text", text: JSON.stringify({ orders: output }) }],
          structuredContent: { orders: output },
        };
      },
    );

    server.registerTool(
      "get_order_details",
      getOrderDetailsToolDefinition,
      async ({ orderId }) => {
        const output = await get_order_details({ orderId });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output,
        };
      },
    );

    server.registerTool(
      "search_orders",
      searchOrdersToolDefinition,
      async ({
        startDate,
        endDate,
        status,
        minTotal,
        maxTotal,
        customerId,
        sortBy,
        sortOrder,
        limit,
        offset,
      }) => {
        const output = await search_orders({
          startDate,
          endDate,
          status,
          minTotal,
          maxTotal,
          customerId,
          sortBy,
          sortOrder,
          limit,
          offset,
        });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output,
        };
      },
    );

    server.registerTool(
      "get_revenue_analysis",
      getRevenueAnalysisToolDefinition,
      async ({ startDate, endDate, groupBy }) => {
        const output = await get_revenue_analysis({
          startDate,
          endDate,
          groupBy,
        });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output,
        };
      },
    );

    server.registerTool(
      "get_product_by_id",
      getProductToolDefinition,
      async ({ productId }) => {
        const output = await get_product({ productId });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output as any,
        };
      },
    );

    server.registerTool(
      "get_product_stats",
      getProductStatsToolDefinition,
      async ({ productId, startDate, endDate, limit }) => {
        const output = await get_product_stats({
          productId,
          startDate,
          endDate,
          limit,
        });
        return {
          content: [
            { type: "text", text: JSON.stringify({ products: output }) },
          ],
          structuredContent: { products: output },
        };
      },
    );

    server.registerTool(
      "search_products",
      searchProductsToolDefinition,
      async ({
        searchTerm,
        minPrice,
        maxPrice,
        minStock,
        maxStock,
        sortBy,
        sortOrder,
        limit,
        offset,
      }) => {
        const output = await search_products({
          searchTerm,
          minPrice,
          maxPrice,
          minStock,
          maxStock,
          sortBy,
          sortOrder,
          limit,
          offset,
        });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output,
        };
      },
    );

    server.registerTool(
      "get_inventory_status",
      getInventoryStatusToolDefinition,
      async ({
        lowStockThreshold,
        includeOutOfStock,
        includeLowStock,
        includeInStock,
        limit,
      }) => {
        const output = await get_inventory_status({
          lowStockThreshold,
          includeOutOfStock,
          includeLowStock,
          includeInStock,
          limit,
        });
        return {
          content: [{ type: "text", text: JSON.stringify(output) }],
          structuredContent: output,
        };
      },
    );
  },
  {},
  { basePath: "/api/mcp/tool-call", maxDuration: 60, verboseLogs: true },
);

export { handler as GET, handler as POST };
