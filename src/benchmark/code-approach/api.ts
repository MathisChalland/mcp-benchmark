import { INTERFACE_DEFINITIONS } from "./tools-api-def";

export function getToolsAPI() {
  return `${Object.values(INTERFACE_DEFINITIONS).join("\n\n")}

    ${Object.keys(INTERFACE_DEFINITIONS).join("\n\n")}    
    `;
}
