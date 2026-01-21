export interface TestCase {
  id: string;
  instruction: string;
  expectedResult?: any;
}

export const tests: TestCase[] = [
  // ===== BASIC TESTS =====
  {
    id: "basic-product-search",
    instruction:
      "Search for all products that are currently out of stock. Return just the count of out-of-stock products.",
  },
  {
    id: "basic-order-search",
    instruction:
      "Find all orders with status 'cancelled'. How many cancelled orders are there in total?",
  },

  // ===== INTERMEDIATE TESTS =====
  {
    id: "most-expensive-order-customer",
    instruction:
      "Find the customer who placed the most expensive order and give me all customer details.",
  },
  {
    id: "product-performance-correlation",
    instruction:
      "Compare the top 5 best-selling products (by revenue) with the top 5 products by order count. How many products appear in both lists?",
  },
  {
    id: "inventory-low-stock-value",
    instruction:
      "Get the inventory status with a low stock threshold of 15. What is the total potential revenue in euro if all low-stock products are sold?",
  },

  // ===== COMPLEX MULTI-STEP TEST =====
  {
    id: "churn-risk-analysis",
    instruction: `Identify customers at risk of churning using the following criteria:
      1. Find customers who have made at least 3 orders in total
      2. Their most recent order must be more than 90 days ago
      3. Among these at-risk customers, find the one with the highest lifetime value (total spent)
      
      Return ONLY the name of the highest-value at-risk customer and their total lifetime spending as a simple object: { customerName: string, totalSpent: number }`,
  },

  {
    id: "top-customer-product-preference",
    instruction:
      "Find the top 3 customers by total spending. For each of these customers, what is the most frequently purchased product (by quantity)? Return customer name, total spent, and their favorite product name.",
  },
];
