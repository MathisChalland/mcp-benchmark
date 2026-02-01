export function createSearchClause<T extends string>(
  fields: T[],
  searchTerm: string | undefined,
): Record<string, unknown> {
  if (!searchTerm) {
    return {};
  }

  return {
    OR: fields.map((field) => createTextFilter(field, searchTerm)),
  };
}

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

export function createRangeFilter<T extends string>(
  fieldName: T,
  min?: number | Date,
  max?: number | Date,
): Record<string, unknown> {
  if (min === undefined && max === undefined) {
    return {};
  }

  const rangeFilter: Record<string, number | Date> = {};
  if (min !== undefined) rangeFilter.gte = min;
  if (max !== undefined) rangeFilter.lte = max;

  return {
    [fieldName]: rangeFilter,
  };
}

export function createExactFilter<T extends string>(
  fieldName: T,
  value: string | number | boolean | null | undefined,
): Record<string, unknown> {
  if (value === undefined) {
    return {};
  }

  return {
    [fieldName]: value,
  };
}

export function combineFilters(
  ...filters: Record<string, unknown>[]
): Record<string, unknown> {
  return filters.reduce((acc, filter) => {
    if (Object.keys(filter).length > 0) {
      Object.assign(acc, filter);
    }
    return acc;
  }, {});
}
