import * as parser from "./dfa.generated";

type Transition = {
  char: string;
  state: string;
};

type StateTransition = {
  state: string;
  transitions: Transition[];
};

type DFA = {
  alphabet: string[];
  initialState: string;
  acceptingStates: string[];
  stateTransitions: StateTransition[];
};

export function parse(input: string): DFA {
  return parser.parse(input) as DFA;
}
