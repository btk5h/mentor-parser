import * as parser from "./nfa.generated";

export type Transition = {
  symbol: string;
  state: string;
};

export type StateTransition = {
  state: string;
  transitions: Transition[];
};

export type NFA = {
  alphabet: string[];
  initialState: string;
  acceptingStates: string[];
  stateTransitions: StateTransition[];
};

export function parse(input: string): NFA {
  return parser.parse(input) as NFA;
}
