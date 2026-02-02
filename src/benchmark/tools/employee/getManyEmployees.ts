import { z } from "zod";
import { db } from "@/server/db";
import type { Employee } from "../../code-approach/types";
import { createWhereClauseBuilder } from "@/lib/db-helpers";

export const getManyEmployeesSchema = {
  inputSchema: {
    searchTerm: z
      .string()
      .optional()
      .describe(
        "Search term to match against employee first name or last name",
      ),
    title: z.string().optional().describe("Filter by job title"),
    city: z.string().optional().describe("Filter by city"),
    country: z.string().optional().describe("Filter by country"),
    reportsToId: z
      .number()
      .int()
      .optional()
      .describe("Filter by reports to employee ID"),
    minHireDate: z
      .string()
      .optional()
      .describe("Minimum hire date filter (ISO date string)"),
    maxHireDate: z
      .string()
      .optional()
      .describe("Maximum hire date filter (ISO date string)"),
    minBirthDate: z
      .string()
      .optional()
      .describe("Minimum birth date filter (ISO date string)"),
    maxBirthDate: z
      .string()
      .optional()
      .describe("Maximum birth date filter (ISO date string)"),
    sortBy: z
      .enum([
        "lastName",
        "firstName",
        "title",
        "city",
        "country",
        "hireDate",
        "birthDate",
      ])
      .optional()
      .default("lastName")
      .describe("Field to sort by"),
    sortOrder: z
      .enum(["asc", "desc"])
      .optional()
      .default("asc")
      .describe("Sort order"),
    limit: z
      .number()
      .min(1)
      .max(100)
      .optional()
      .default(20)
      .describe("Maximum number of employees to return"),
    offset: z
      .number()
      .min(0)
      .optional()
      .default(0)
      .describe("Number of employees to skip for pagination"),
  },
};

export const getManyEmployeesToolDefinition = {
  title: "Get Many Employees",
  description:
    "Search and filter employees from the database with sorting and pagination",
  ...getManyEmployeesSchema,
};

const w = createWhereClauseBuilder<Employee>();

/**
 * Search and filter employees from the database with sorting and pagination
 */
export async function getManyEmployees({
  searchTerm,
  title,
  city,
  country,
  reportsToId,
  minHireDate,
  maxHireDate,
  minBirthDate,
  maxBirthDate,
  sortBy = "lastName",
  sortOrder = "asc",
  limit = 20,
  offset = 0,
}: {
  searchTerm?: string;
  title?: string;
  city?: string;
  country?: string;
  reportsToId?: number;
  minHireDate?: string;
  maxHireDate?: string;
  minBirthDate?: string;
  maxBirthDate?: string;
  sortBy?:
    | "lastName"
    | "firstName"
    | "title"
    | "city"
    | "country"
    | "hireDate"
    | "birthDate";
  sortOrder?: "asc" | "desc";
  limit?: number /* max 100 */;
  offset?: number;
}): Promise<{
  employees: Employee[];
  hasMore: boolean;
}> {
  const where = w.combine(
    w.search(["firstName", "lastName"], searchTerm),
    w.exact("title", title),
    w.exact("city", city),
    w.exact("country", country),
    w.exact("reportsToId", reportsToId),
    w.range(
      "hireDate",
      minHireDate ? new Date(minHireDate) : undefined,
      maxHireDate ? new Date(maxHireDate) : undefined,
    ),
    w.range(
      "birthDate",
      minBirthDate ? new Date(minBirthDate) : undefined,
      maxBirthDate ? new Date(maxBirthDate) : undefined,
    ),
  );

  const employees = await db.employee.findMany({
    where,
    orderBy: { [sortBy]: sortOrder },
    take: limit + 1,
    skip: offset,
  });

  const hasMore = employees.length > limit;
  if (hasMore) {
    employees.pop();
  }

  return {
    employees: employees.map((employee) => ({
      ...employee,
      hireDate: employee.hireDate?.toISOString() ?? null,
      birthDate: employee.birthDate?.toISOString() ?? null,
    })),
    hasMore,
  };
}
