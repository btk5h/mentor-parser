import * as parser from "./pda.generated";

export type Transition = {
  inputSymbol: string;
  stackSymbol: string;
  writeSymbols: string[];
  nextState: string;
};

export type StateTransition = {
  state: string;
  transitions: Transition[];
};

export type PDA = {
  initialState: string;
  acceptingStates: string[];
  stateTransitions: StateTransition[];
};

export function parse(input: string): PDA {
  return parser.parse(input) as PDA;
}
