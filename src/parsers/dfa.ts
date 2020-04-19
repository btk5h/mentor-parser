import * as parser from "./dfa.generated";

export type Transition = {
  symbol: string;
  state: string;
};

export type StateTransition = {
  state: string;
  transitions: Transition[];
};

export type DFA = {
  alphabet: string[];
  initialState: string;
  acceptingStates: string[];
  stateTransitions: StateTransition[];
};

export function parse(input: string): DFA {
  return parser.parse(input) as DFA;
}
