export interface TestCaseValidator {
  required: RegExp[];
  forbidden?: RegExp[];
}

export function validateResponse(
  response: string,
  validator: TestCaseValidator,
): { passed: boolean; errors: string[] } {
  const errors: string[] = [];

  for (const regex of validator.required) {
    if (!regex.test(response)) {
      errors.push(`Missing required pattern: ${regex.source}`);
    }
  }

  for (const regex of validator.forbidden ?? []) {
    if (regex.test(response)) {
      errors.push(`Found forbidden pattern: ${regex.source}`);
    }
  }

  return { passed: errors.length === 0, errors };
}
