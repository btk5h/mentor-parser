DFAGrammar =
  FileEdge
  alphabet:AlphabetDefinition BlockSeparator
  initialState:InitialStateDefinition BlockSeparator
  acceptingStates:AcceptingStatesDefinition BlockSeparator
  stateTransitions:DFAStateTransitionsDefinition
  FileEdge
  { return { alphabet, initialState, acceptingStates, stateTransitions } }

NFAGrammar =
  FileEdge
  alphabet:AlphabetDefinition BlockSeparator
  initialState:InitialStateDefinition BlockSeparator
  acceptingStates:AcceptingStatesDefinition BlockSeparator
  stateTransitions:NFAStateTransitionsDefinition
  FileEdge
  { return { alphabet, initialState, acceptingStates, stateTransitions } }

AlphabetDefinition =
  "alphabet:" _ "{" _
  	head:Symbol
    tail:(_ "," _ v:Symbol { return v })*
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

DFAStateTransitionsDefinition =
  head:DFAStateTransition
  tail:(BlockSeparator v:DFAStateTransition { return v })*
  { return [head, ...tail] }

DFAStateTransition "state transition" =
  state:State transitions:(_ v:DFATransition { return v })+
  { return { state, transitions } }

DFATransition "transition" =
  "(" _ symbol:Symbol _ "->" _ state:State ")"
  { return { symbol, state } }

NFAStateTransitionsDefinition =
  head:NFAStateTransition
  tail:(BlockSeparator v:NFAStateTransition { return v })*
  { return [head, ...tail] }

NFAStateTransition "state transition" =
  state:State transitions:(_ v:NFATransition { return v })+
  { return { state, transitions } }

NFATransition "transition" =
  "(" _ symbol:(Symbol / EmptySymbol) _ "->" _ state:State ")"
  { return { symbol, state } }

State "state" = $ [a-zA-Z0-9]+
Symbol "symbol" =  $ [a-zA-Z0-9]+
EmptySymbol "lambda transition" = "_" { return "" }

BlockSeparator "new line" = [ \t]* "\n" [ \t\n]*
FileEdge "edge of file" = [ \t\n\r]*

_ "whitespace" = [ \t]*
