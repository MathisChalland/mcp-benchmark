/**
 * Creates a Prisma OR clause for searching across multiple fields with case-insensitive matching
 * @param searchTerm - The term to search for
 * @param fields - Array of field names to search across
 * @returns Prisma where clause object or empty object if no search term
 */
export function createSearchClause<T extends string>(
  searchTerm: string | undefined,
  fields: T[],
): Record<string, unknown> {
  if (!searchTerm) {
    return {};
  }

  return {
    OR: fields.map((field) => createTextFilter(field, searchTerm)),
  };
}

/**
 * Creates a Prisma field filter for case-insensitive text matching
 * @param fieldName - The field name to filter on
 * @param value - The value to match
 * @returns Prisma where clause object or empty object if no value
 */
export function createTextFilter<T extends string>(
  fieldName: T,
  value: string | undefined,
): Record<string, unknown> {
  if (!value) {
    return {};
  }

  return {
    [fieldName]: {
      contains: value,
      mode: "insensitive" as const,
    },
  };
}
