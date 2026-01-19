import { js_beautify } from "js-beautify";

export function formatJs(code: string): string {
  return js_beautify(code, {
    indent_size: 2,
    space_in_empty_paren: true,
    end_with_newline: false,
    preserve_newlines: true,
    max_preserve_newlines: 2,
  });
}
