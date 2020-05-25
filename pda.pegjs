PDAGrammar =
  FileEdge
  initialState:InitialStateDefinition BlockSeparator
  acceptingStates:AcceptingStatesDefinition BlockSeparator
  stateTransitions:PDAStateTransitionsDefinition
  FileEdge
  { return { initialState, acceptingStates, stateTransitions} }

InitialStateDefinition =
  "start:" _ state:State
  { return state }

AcceptingStatesDefinition =
  "accepting:" _ "{" _
  	head:State
    tail:(_ "," _ v:State { return v })*
  _ "}"
  { return [head, ...tail] }

PDAStateTransitionsDefinition =
  head:PDAStateTransition
  tail:(BlockSeparator v:PDAStateTransition { return v })*
  { return [head, ...tail] }

PDAStateTransition =
  state:State transitions:(_ v:PDATransition { return v })+
  { return { state, transitions } }

PDATransition =
  "(" _
  inputSymbol:(Symbol / EmptySymbol) _ "," _
  stackSymbol:(Symbol / EmptySymbol) _ "->" _ writeSymbols:(Symbol* / EmptySymbol) _ "," _
  nextState:State
  ")"
  { return { inputSymbol, stackSymbol, writeSymbols, nextState } }

State "state" = $ [a-zA-Z0-9]+
Symbol "symbol" =  $ [a-zA-Z0-9]
EmptySymbol = "_" { return "" }

BlockSeparator "new line" = [ \t]* "\n" [ \t\n]*
FileEdge "edge of file" = [ \t\n\r]*
_ "whitespace" = [ \t]*
