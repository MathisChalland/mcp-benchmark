function createSearchClause<T>(
  fields: (keyof T)[],
  searchTerm: string | undefined,
): Record<string, unknown> {
  if (!searchTerm) {
    return {};
  }

  return {
    OR: fields.map((field) => createTextFilter(field, searchTerm)),
  };
}

function createTextFilter<T>(
  fieldName: keyof T,
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

function createRangeFilter<T>(
  fieldName: keyof T,
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

function createExactFilter<T>(
  fieldName: keyof T,
  value: string | number | boolean | null | undefined,
): Record<string, unknown> {
  if (value === undefined) {
    return {};
  }

  return {
    [fieldName]: value,
  };
}

function combineFilters(
  ...filters: Record<string, unknown>[]
): Record<string, unknown> {
  return filters.reduce((acc, filter) => {
    if (Object.keys(filter).length > 0) {
      Object.assign(acc, filter);
    }
    return acc;
  }, {});
}

export function createWhereClauseBuilder<T>() {
  return {
    search: (fields: (keyof T)[], searchTerm: string | undefined) =>
      createSearchClause<T>(fields, searchTerm),
    text: (fieldName: keyof T, value: string | undefined) =>
      createTextFilter<T>(fieldName, value),
    range: (fieldName: keyof T, min?: number | Date, max?: number | Date) =>
      createRangeFilter<T>(fieldName, min, max),
    exact: (
      fieldName: keyof T,
      value: string | number | boolean | null | undefined,
    ) => createExactFilter<T>(fieldName, value),
    combine: combineFilters,
  };
}
