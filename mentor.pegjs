DFAGrammar =
  _ alphabet:AlphabetDefinition _ LineTerminator+
  _ initialState:InitialStateDefinition _ LineTerminator+
  _ acceptingStates:AcceptingStatesDefinition _ LineTerminator+
  stateTransitions:DFAStateTransitionsDefinition
  { return { alphabet, initialState, acceptingStates, stateTransitions } }

AlphabetDefinition =
  "alphabet:" _ "{" _
  	head:Character
    tail:(_ "," _ v:Character { return v })*
  _ "}"
  { return [head, ...tail] }

InitialStateDefinition =
  "start:" _ state:State
  { return state }

AcceptingStatesDefinition =
  "accepting:" _ "{" _
  	head:State
    tail:(_ "," _ v:State { return v })*
  _ "}"
  { return [head, ...tail] }

DFAStateTransitionsDefinition "list of state transitions" =
  head:(_ v:DFAStateTransition _ LineTerminator+ { return v })+
  _ tail:DFAStateTransition _ EOF
  { return [...head, tail] }

DFAStateTransition "state transition" =
  state:State transitions:(_ v:DFATransition _ { return v })+
  { return { state, transitions } }

DFATransition =
  "(" _ char:Character _ "->" _ state:State ")"
  { return { char, state } }

State = $ [a-zA-Z0-9]+
Character = [a-zA-Z0-9]

LineTerminator = "\n"
EOF = (LineTerminator / [ \t])*
_ "whitespace" = [ \t]*
