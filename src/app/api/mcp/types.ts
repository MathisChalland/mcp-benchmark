export interface ToolCall {
  id: string;
  type: "function";
  function: {
    name: string;
    arguments: string;
  };
}

export interface ToolContent {
  type: string;
  text?: string;
  [key: string]: unknown;
}
