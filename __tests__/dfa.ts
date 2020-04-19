import { stripIndent } from "common-tags";
import { parseDFA } from "../src/index";

describe("invalid DFA", () => {
  it("fails DFAs with an empty alphabet", () => {
    const dfa = stripIndent`
      alphabet: {}
      start: Q0
      accepting: {Q0}
      
      Q0 (a -> Q0)
    `;
    expect(() => parseDFA(dfa)).toThrow();
  });

  it("fails DFAs with empty accepting states", () => {
    const dfa = stripIndent`
      alphabet: {a}
      start: Q0
      accepting: {}
      
      Q0 (a -> Q0)
    `;
    expect(() => parseDFA(dfa)).toThrow();
  });
});

describe("minimal DFA", () => {
  const expected = {
    alphabet: ["a"],
    initialState: "Q0",
    acceptingStates: ["Q0"],
    stateTransitions: [
      {
        state: "Q0",
        transitions: [
          {
            symbol: "a",
            state: "Q0",
          },
        ],
      },
    ],
  };

  it("parses a simple DFA", () => {
    const dfa = stripIndent`
      alphabet: {a}
      start: Q0
      accepting: {Q0}
      
      Q0 (a -> Q0) 
    `;

    expect(parseDFA(dfa)).toStrictEqual(expected);
  });
});
