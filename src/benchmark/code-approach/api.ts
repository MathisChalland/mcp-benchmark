import { INTERFACE_DEFINITIONS, TOOL_DEFINITIONS } from "./tools-api-def";

export function getToolsAPI() {
  return `${Object.values(INTERFACE_DEFINITIONS).join("\n\n")}

    ${Object.values(TOOL_DEFINITIONS).join("\n\n")}    
    `;
}
