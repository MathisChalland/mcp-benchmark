import { createMcpHandler, withMcpAuth } from "mcp-handler";
import { verifyMcpToken } from "../../verify-token";

import {
  getAllCategories,
  getAllCategoriesToolDefinition,
} from "@/benchmark/tools/category/getAllCategories";
import {
  getCategoryById,
  getCategoryByIdToolDefinition,
} from "@/benchmark/tools/category/getCategoryById";

import {
  getCustomerById,
  getCustomerToolDefinition,
} from "@/benchmark/tools/customer/getCustomerById";
import {
  getManyCustomers,
  searchCustomersToolDefinition,
} from "@/benchmark/tools/customer/getManyCustomers";

import {
  getEmployeeById,
  getEmployeeByIdToolDefinition,
} from "@/benchmark/tools/employee/getEmployeeById";
import {
  getManyEmployees,
  getManyEmployeesToolDefinition,
} from "@/benchmark/tools/employee/getManyEmployees";

import {
  getManyOrders,
  getManyOrdersToolDefinition,
} from "@/benchmark/tools/order/getManyOrders";
import {
  getOrderById,
  getOrderByIdToolDefinition,
} from "@/benchmark/tools/order/getOrderById";
import {
  getOrderDetails,
  getOrderDetailsToolDefinition,
} from "@/benchmark/tools/order/getOrderDetails";
import {
  getOrderTotal,
  getOrderTotalToolDefinition,
} from "@/benchmark/tools/order/getOrderTotal";

import {
  getManyProducts,
  searchProductsToolDefinition,
} from "@/benchmark/tools/product/getManyProducts";
import {
  getProductById,
  getProductToolDefinition,
} from "@/benchmark/tools/product/getProductById";
import {
  getProductSales,
  getProductSalesToolDefinition,
} from "@/benchmark/tools/product/getProductSales";

import {
  getAllShippers,
  getAllShippersToolDefinition,
} from "@/benchmark/tools/shipper/getAllShippers";
import {
  getShipperById,
  getShipperByIdToolDefinition,
} from "@/benchmark/tools/shipper/getShipperById";

import {
  getManySuppliers,
  getManySuppliersToolDefinition,
} from "@/benchmark/tools/supplier/getManySuppliers";
import {
  getSupplierById,
  getSupplierByIdToolDefinition,
} from "@/benchmark/tools/supplier/getSupplierById";

const handler = createMcpHandler(
  (server) => {
    server.registerTool(
      "get_customer_by_id",
      getCustomerToolDefinition,
      async (props) => {
        const customer = await getCustomerById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(customer) }],
        };
      },
    );

    server.registerTool(
      "get_many_customers",
      searchCustomersToolDefinition,
      async (props) => {
        const customers = await getManyCustomers(props);
        return {
          content: [{ type: "text", text: JSON.stringify(customers) }],
        };
      },
    );

    server.registerTool(
      "get_many_products",
      searchProductsToolDefinition,
      async (props) => {
        const products = await getManyProducts(props);
        return {
          content: [{ type: "text", text: JSON.stringify(products) }],
        };
      },
    );

    server.registerTool(
      "get_product_by_id",
      getProductToolDefinition,
      async (props) => {
        const product = await getProductById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(product) }],
        };
      },
    );

    server.registerTool(
      "get_product_sales",
      getProductSalesToolDefinition,
      async (props) => {
        const sales = await getProductSales(props);
        return {
          content: [{ type: "text", text: JSON.stringify(sales) }],
        };
      },
    );

    server.registerTool(
      "get_many_orders",
      getManyOrdersToolDefinition,
      async (props) => {
        const orders = await getManyOrders(props);
        return {
          content: [{ type: "text", text: JSON.stringify(orders) }],
        };
      },
    );

    server.registerTool(
      "get_order_by_id",
      getOrderByIdToolDefinition,
      async (props) => {
        const order = await getOrderById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(order) }],
        };
      },
    );

    server.registerTool(
      "get_order_details",
      getOrderDetailsToolDefinition,
      async (props) => {
        const details = await getOrderDetails(props);
        return {
          content: [{ type: "text", text: JSON.stringify(details) }],
        };
      },
    );

    server.registerTool(
      "get_order_total",
      getOrderTotalToolDefinition,
      async (props) => {
        const total = await getOrderTotal(props);
        return {
          content: [{ type: "text", text: JSON.stringify(total) }],
        };
      },
    );

    server.registerTool(
      "get_employee_by_id",
      getEmployeeByIdToolDefinition,
      async (props) => {
        const employee = await getEmployeeById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(employee) }],
        };
      },
    );

    server.registerTool(
      "get_many_employees",
      getManyEmployeesToolDefinition,
      async (props) => {
        const employees = await getManyEmployees(props);
        return {
          content: [{ type: "text", text: JSON.stringify(employees) }],
        };
      },
    );

    server.registerTool(
      "get_many_suppliers",
      getManySuppliersToolDefinition,
      async (props) => {
        const suppliers = await getManySuppliers(props);
        return {
          content: [{ type: "text", text: JSON.stringify(suppliers) }],
        };
      },
    );

    server.registerTool(
      "get_supplier_by_id",
      getSupplierByIdToolDefinition,
      async (props) => {
        const supplier = await getSupplierById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(supplier) }],
        };
      },
    );

    server.registerTool(
      "get_all_shippers",
      getAllShippersToolDefinition,
      async () => {
        const shippers = await getAllShippers();
        return {
          content: [{ type: "text", text: JSON.stringify(shippers) }],
        };
      },
    );

    server.registerTool(
      "get_shipper_by_id",
      getShipperByIdToolDefinition,
      async (props) => {
        const shipper = await getShipperById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(shipper) }],
        };
      },
    );

    server.registerTool(
      "get_all_categories",
      getAllCategoriesToolDefinition,
      async () => {
        const categories = await getAllCategories();
        return {
          content: [{ type: "text", text: JSON.stringify(categories) }],
        };
      },
    );

    server.registerTool(
      "get_category_by_id",
      getCategoryByIdToolDefinition,
      async (props) => {
        const category = await getCategoryById(props);
        return {
          content: [{ type: "text", text: JSON.stringify(category) }],
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
