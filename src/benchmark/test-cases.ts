export interface TestCase {
  id: string;
  instruction: string;
  category: TestCategory;
}

export type TestCategory =
  | "single-tool"
  | "dual-parallel"
  | "dual-sequential"
  | "multi-tool-complex";

export const categoryLabels: Record<TestCategory, string> = {
  "single-tool": "Single Tool",
  "dual-parallel": "Dual Parallel",
  "dual-sequential": "Dual Sequential",
  "multi-tool-complex": "Multi Tool Complex",
};

export const tests: TestCase[] = [
  {
    id: "most-expensive-product",
    category: "single-tool",
    instruction:
      "Find the product with the highest price. What is its name and price?",
  },
  {
    id: "basic-order-search",
    category: "single-tool",
    instruction: "How many cancelled orders are there in total?",
  },

  // ===== DUAL PARALLEL =====
  {
    id: "customer-and-orders",
    category: "dual-parallel",
    instruction:
      "Give me details about customer 095feb7a-eb45-4a67-a0dc-00d009ac86b2. How many pending orders does this customer have?",
  },
  {
    id: "product-performance-correlation",
    category: "dual-parallel",
    instruction:
      "Compare the top 5 best-selling products (by revenue) with the top 5 products by order count. How many products appear in both lists?",
  },

  // ===== DUAL SEQUENTIAL =====
  {
    id: "most-expensive-order-customer",
    category: "dual-sequential",
    instruction:
      "Find the customer who placed the most expensive order and give me all customer details.",
  },
  {
    id: "inventory-low-stock-value",
    category: "dual-sequential",
    instruction:
      "Get the inventory status with a low stock threshold of 15. What is the total potential revenue in euro if all low-stock products are sold?",
  },

  // ===== MULTI TOOL COMPLEX =====
  {
    id: "churn-risk-analysis",
    category: "multi-tool-complex",
    instruction: `Identify customers at risk of churning using the following criteria:
      1. Find customers who have made at least 3 orders in total
      2. Their most recent order must be more than 90 days ago
      3. Among these at-risk customers, find the one with the highest lifetime value (total spent)
      
      Return ONLY the name of the highest-value at-risk customer and their total lifetime spending as a simple object: { customerName: string, totalSpent: number }`,
  },
  {
    id: "top-customer-product-preference",
    category: "multi-tool-complex",
    instruction:
      "Find the top 3 customers by total spending. For each of these customers, what is the most frequently purchased product (by quantity)? Return customer name, total spent, and their favorite product name.",
  },
];

export function getGroupedTests(): {
  category: TestCategory;
  label: string;
  tests: TestCase[];
}[] {
  const categories: TestCategory[] = [
    "single-tool",
    "dual-parallel",
    "dual-sequential",
    "multi-tool-complex",
  ];

  return categories.map((category) => ({
    category,
    label: categoryLabels[category],
    tests: tests.filter((test) => test.category === category),
  }));
}
