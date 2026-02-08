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
  },
  {
    id: "shipping-options-comparison",
    instruction:
      "We're evaluating our shipping partners. What are the company names and contact phone numbers for shippers 1, 2, and 3?",
    toolDependency: "independent",
    dataComplexity: "simple",
  },

  // Independent + Complex
  {
    id: "low-stock-products",
    instruction: "Find all products that need to be reordered",
    toolDependency: "independent",
    dataComplexity: "complex",
  },

  {
    id: "customer-distribution",
    instruction:
      "Provide a breakdown of the number of customers in each country.",
    toolDependency: "independent",
    dataComplexity: "complex",
  },

  // ═══════════════════════════════════════════════════════════
  // SEQUENTIAL - Chain of dependencies
  // ═══════════════════════════════════════════════════════════

  // Sequential + Simple
  {
    id: "employee-supervisor-lookup",
    instruction: "Find all employees who report to Andrew.",
    toolDependency: "sequential",
    dataComplexity: "simple",
  },
  {
    id: "order-customer-contact",
    instruction:
      "Who placed order 10290? Provide the customer's company name and phone number.",
    toolDependency: "sequential",
    dataComplexity: "simple",
  },

  // Sequential + Complex
  {
    id: "order-details-lookup",
    instruction:
      "Look up information about order 10276. How Many Products were in that order, what whas the total price and who is the customer?",
    toolDependency: "sequential",
    dataComplexity: "complex",
  },

  {
    id: "supplier-inventory-value",
    instruction:
      "What is the total inventory value for all active products from the supplier of 'Chang'?",
    toolDependency: "sequential",
    dataComplexity: "complex",
  },

  // ═══════════════════════════════════════════════════════════
  // ITERATIVE - Runtime-dependent iteration
  // ═══════════════════════════════════════════════════════════

  // Iterative + Simple
  {
    id: "category-top-product-revenue",
    instruction:
      "Which product from the 'Beverages' category generated the highest sales revenue?",
    toolDependency: "iterative",
    dataComplexity: "simple",
  },

  // Iterative + Complex
  {
    id: "customer-total-revenue",
    instruction:
      "Calculate the total revenue across all orders placed by customer 'QUICK-Stop'.",
    toolDependency: "iterative",
    dataComplexity: "complex",
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
