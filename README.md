# mentor-parser

A standalone JavaScript module for parsing Mentor's automata description DSL.

## Installation

```sh
npm install mentor-parser
```

## Usage

Import the parsers you want to use from `mentor-parser`

```js
import { parseDFA } from "mentor-parser";

const dfaString = `
alphabet: {a}
start: Q0
accepting: {Q0}

Q0 (a -> Q1)
Q1 (a -> Q2)
Q2 (a -> Q0)
`;

const dfa = parseDFA(dfaString);
```

## Supported Parsers

- [x] DFAs (Deterministic finite automata)
- [ ] NFAs (Non-deterministic finite automata)
- [ ] Regular expressions
- [ ] Context-free grammars
- [ ] PDAs (Pushdown automata)
