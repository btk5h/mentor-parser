import * as parser from "./cfg.generated";

export type ProductionRule = {
  from: string;
  to: string[][];
};

export type ContextFreeGrammar = {
  terminals: string[];
  productions: ProductionRule[];
};

export function parse(input: string): ContextFreeGrammar {
  return parser.parse(input) as ContextFreeGrammar;
}
