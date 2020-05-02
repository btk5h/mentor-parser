import * as parser from "./regex.generated";

export type SpecialOperation<Operation> = {
  operation: Operation;
  operand: RegularExpressionRule;
};

export type RegularExpressionRule =
  | SpecialOperation<"or">
  | SpecialOperation<"and">
  | RegularExpressionRule[]
  | string;

export type RegularExpression = {
  alphabet: string[];
  expression: RegularExpressionRule;
};

export function parse(input: string): RegularExpression {
  return parser.parse(input) as RegularExpression;
}
