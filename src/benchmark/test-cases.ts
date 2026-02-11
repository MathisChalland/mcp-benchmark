import type { TestCaseValidator } from "./validator";

export type ToolDependency = "independent" | "sequential" | "iterative";

export interface TestCase {
  id: string;
  instruction: string;
  toolDependency: ToolDependency;
  dataComplexity: "simple" | "complex";
  validator?: TestCaseValidator;
}

export const TEST_CASES: TestCase[] = [
  // ═══════════════════════════════════════════════════════════
  // INDEPENDENT - No data dependencies between tool calls
  // ═══════════════════════════════════════════════════════════

  // Independent + Simple
  {
    id: "customer-contact-info",
    instruction:
      "What is the contact name and phone number for the customer 'Unity Distribution Ltd'?",
    toolDependency: "independent",
    dataComplexity: "simple",
    // 1 Call: getManyCustomers oder getCustomerById
    validator: {
      required: [/Penelope\s+Henderson/i, /\(?171\)?[\s\-\.]?555[\s\-\.]?1212/],
    },
  },
  {
    id: "shipping-options-comparison",
    instruction:
      "We're evaluating our shipping partners. What are the company names and contact phone numbers for shippers '05a6810f-943a-4615-ae65-ac3083516c86', '2ad7efe7-86e9-4259-a8ae-2522932fca51', and '2e4d27a0-a62f-4696-9b8d-6759b66bd459'?",
    toolDependency: "independent",
    dataComplexity: "simple",
    // 3 parallel Calls: getShipperById × 3
    validator: {
      required: [
        /DHL/i,
        /1[-.]?800[-.]?225[-.]?5345/,
        /UPS/i,
        /1[-.]?800[-.]?782[-.]?7892/,
        /United\s*Package/i,
        /\(?\s*503\s*\)?\s*[-.]?\s*555[-.]?3199/,
      ],
    },
  },

  // Independent + Complex
  {
    id: "low-stock-products",
    instruction:
      "Find all products that are below their reorder level and not discontinued.",
    toolDependency: "independent",
    dataComplexity: "complex",
    // 1 Call: getManyProducts → Filter: unitsInStock < reorderLevel && discontinued=false
    validator: {
      required: [
        /Bay Breeze Iced Tea/i,
        /Canyon Aged Cheddar/i,
        /Coastal Breeze Sourdough/i,
        /Coastal Catch Tuna/i,
        /Coastal Herb Mix/i,
        /Coastal Sweet Rye Bread/i,
        /Deep Sea Dark Stout/i,
        /Garden Valley Gruy[eè]re/i,
        /Meadow Firm Tofu/i,
        /Meadow Honey Wheat Bread/i,
        /Meadow Organic Chutney/i,
        /Mountain Goat Cheese/i,
        /Mountain Range Pralines/i,
        /Ocean Harvest Salted Caramels/i,
        /Prairie Dawn Dried Wakame/i,
        /Summit Peak Sardines/i,
        /Valley Honey Nougat/i,
      ],
    },
  },

  {
    id: "customer-distribution",
    instruction:
      "Provide a breakdown of the number of customers in each country.",
    toolDependency: "independent",
    dataComplexity: "complex",
    // 1 Call: getManyCustomers → Grup by country + count
    validator: {
      required: [
        /USA.*13/i,
        /Germany.*11/i,
        /France.*11/i,
        /Brazil.*9/i,
        /UK.*7/i,
        /Spain.*5/i,
        /Mexico.*5/i,
        /Venezuela.*4/i,
        /Argentina.*3/i,
        /Italy.*3/i,
        /Canada.*3/i,
        /Portugal.*2/i,
        /Sweden.*2/i,
        /Belgium.*2/i,
        /Switzerland.*2/i,
        /Finland.*2/i,
        /Austria.*2/i,
        /Denmark.*2/i,
        /Norway.*1/i,
        /Poland.*1/i,
        /Ireland.*1/i,
      ],
    },
  },

  // ═══════════════════════════════════════════════════════════
  // SEQUENTIAL - Chain of dependencies
  // ═══════════════════════════════════════════════════════════

  // Sequential + Simple
  {
    id: "shipper-for-customer-order",
    instruction:
      "Which shipping company delivered the most recent order placed by the customer 'Silver Commerce Ltd'?",
    toolDependency: "sequential",
    dataComplexity: "simple",
    // getManyCustomers("Silver Commerce Ltd") → customerId
    // getManyOrders(customerId, limit=1, sortBy=orderDate desc) → shipVia
    // getShipperById(shipVia) → companyName
    validator: {
      required: [/united\s*package/i],
    },
  },
  {
    id: "order-supervisor-lookup",
    instruction:
      "Who is the direct supervisor of the employee who processed the most recent order shipped to the customer 'Quantum Retail Solutions'? Give me both their names.",
    toolDependency: "sequential",
    dataComplexity: "simple",
    // getManyOrders(shipCity="Reims", limit=1, sortBy=orderDate desc) → employeeId
    // getEmployeeById(employeeId) → reportsToId
    // getEmployeeById(reportsToId) → name
    validator: {
      required: [/victoria\s+chen/i, /carlos\s+rodriguez/i],
    },
  },

  // Sequential + Complex
  {
    id: "supplier-inventory-value",
    instruction:
      "What is the total inventory value for all active products from the supplier of 'Specialty Biscuits, Ltd.'?",
    toolDependency: "sequential",
    dataComplexity: "complex",
    // getManyProducts("Specialty Biscuits, Ltd") → supplierId
    // getManyProducts(supplierId, discontinued=false) → Products
    // Calculate: Σ(unitPrice × unitsInStock)
    validator: {
      required: [/3[,.]?575/],
    },
  },

  {
    id: "top-line-item-in-recent-order",
    instruction:
      "What is the most expensive line item (by total value after discount) in the most recent order placed by customer 'Echo Distribution Ltd'? Return the product name and the computed line total.",
    toolDependency: "sequential",
    dataComplexity: "complex",
    // getManyCustomers("Echo Distribution Ltd") → customerId
    // getManyOrders(customerId, limit=1) → orderId
    // getOrderDetails(orderId) → LineItems → max(unitPrice × quantity × (1−discount)) → productId
    // getProductById(productId) → productName
    validator: {
      required: [/coastal\s*ginger\s*beer/i, /364[\.,]80/],
    },
  },

  // ═══════════════════════════════════════════════════════════
  // ITERATIVE - Runtime-dependent iteration
  // ═══════════════════════════════════════════════════════════

  // ITERATIVE + SIMPLE
  {
    id: "category-supplier-list",
    instruction:
      "For each product in the 'Condiments' category, which company supplies it? List every product with its supplier name.",
    toolDependency: "iterative",
    dataComplexity: "simple",
    // getManyCategories() → Condiments-ID
    // getManyProducts(categoryId) → N Products
    // For each Product: getSupplierById(supplierId) → companyName
    validator: {
      required: [
        /Coastal Herb Mix/i,
        /Exotic Liquids/i,
        /Harbor Bay Cranberry Sauce/i,
        /Plutzer Lebensmittelgroßmärkte/i,
        /Meadow Organic Chutney/i,
        /Mountain Mist Teriyaki Sauce/i,
        /Forêts d'érables/i,
        /Prairie Maple Syrup/i,
        /Grandma Kelly'?s Homestead/i,
        /Riverside Red Pepper Sauce/i,
        /New Orleans Cajun Delights/i,
        /Seaside Lemon Chutney/i,
        /Mayumi'?s/i,
        /Summit Sweet Chili Sauce/i,
        /Leka Trading/i,
        /Valley Fresh Butter/i,
        /Valley Fruit Preserves/i,
        /Valley Whole Grain Mustard/i,
        /Pavlova,? Ltd/i,
        /Woodland Garlic Paste/i,
      ],
    },
  },
  {
    id: "order-product-names",
    instruction:
      "List the names of all products included in the most recent order to 'Brazil'.",
    toolDependency: "iterative",
    dataComplexity: "simple",
    // getManyOrders(shipCountry="Brazil", limit=1) → orderId
    // getOrderDetails(orderId) → N LineItems
    // For each: getProductById(productId) → name
    validator: {
      required: [
        /Golden Dried Banana Chips/i,
        /Deep Sea Dark Stout/i,
        /Harbor Bay Cranberry Sauce/i,
      ],
    },
  },

  // ITERATIVE + COMPLEX
  {
    id: "customer-total-revenue",
    instruction:
      "Calculate the total revenue across all orders placed by customer 'Beacon Supply Co'.",
    toolDependency: "iterative",
    dataComplexity: "complex",
    // getManyCustomers("Beacon Supply Co") → customerId
    // getManyOrders(customerId) → N Orders
    // For each Order: getOrderTotal(orderId) → total
    // Aggregation: Σ(total) over all N
    validator: {
      required: [/24[,.]?027/],
    },
  },
  {
    id: "category-top-product-revenue",
    instruction:
      "Which product from the 'Beverages' category generated the highest total sales revenue? List all customers who ordered this product.",
    toolDependency: "iterative",
    dataComplexity: "complex",
    // getManyCategories() → Beverages-ID
    // getManyProducts(categoryId) → N Products
    // For each: getProductSales(productId) → revenue
    // Aggregation: max(revenue) over all N
    // For top product: getManyOrderDetails(productId) → M LineItems
    // For each LineItem: getOrderById(orderId) → customer Name

    validator: {
      required: [
        /glacier\s*bay\s*sparkling\s*water/i,
        /141[,.]?396/i,
        /alpine\s*trading/i,
        /bronson\s*wholesale/i,
        /echo\s*distribution/i,
        /emerald\s*trading/i,
        /fir\s*trading/i,
        /hawthorn\s*distribution/i,
        /ironwood\s*retail/i,
        /juniper\s*trading/i,
        /lagoon\s*commerce/i,
        /liberty\s*trading/i,
        /maple\s*commerce/i,
        /mosaic\s*supply/i,
        /nordic\s*wholesale/i,
        /pacific\s*trading/i,
        /quartz\s*retail/i,
        /silver\s*commerce/i,
        /windsor\s*supply/i,
        /xavier\s*trading/i,
        /zenith\s*commerce/i,
      ],
    },
  },
];
export function getGroupedTests(): {
  category: ToolDependency;
  tests: TestCase[];
}[] {
  const categories: ToolDependency[] = [
    "independent",
    "sequential",
    "iterative",
  ];

  return categories.map((category) => ({
    category,
    tests: TEST_CASES.filter((test) => test.toolDependency === category),
  }));
}
