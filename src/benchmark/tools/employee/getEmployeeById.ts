import { z } from "zod";
import { db } from "@/server/db";
import type { Employee } from "../types";

export const getEmployeeByIdSchema = {
  inputSchema: {
    employeeId: z.string().describe("The ID of the employee to retrieve"),
  },
};

export const getEmployeeByIdToolDefinition = {
  title: "Get Employee",
  description: "Retrieves an employee by its ID from the database",
  ...getEmployeeByIdSchema,
};

/**
 * Retrieves an employee by its ID from the database
 */
export async function getEmployeeById({
  employeeId,
}: {
  employeeId: number;
}): Promise<Employee> {
  const employee = await db.employee.findUnique({
    where: {
      id: employeeId,
    },
  });

  if (!employee) {
    throw new Error(`Employee with ID ${employeeId} not found`);
  }

  return {
    ...employee,
    hireDate: employee.hireDate?.toISOString() ?? null,
    birthDate: employee.birthDate?.toISOString() ?? null,
  };
}
