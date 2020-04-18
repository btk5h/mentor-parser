DFAGrammar =
  FileEdge
  alphabet:AlphabetDefinition BlockSeparator
  initialState:InitialStateDefinition BlockSeparator
  acceptingStates:AcceptingStatesDefinition BlockSeparator
  stateTransitions:DFAStateTransitionsDefinition
  FileEdge
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

DFAStateTransitionsDefinition =
  head:DFAStateTransition
  tail:(BlockSeparator v:DFAStateTransition { return v })*
  { return [head, ...tail] }

DFAStateTransition "state transition" =
  state:State transitions:(_ v:DFATransition { return v })+
  { return { state, transitions } }

DFATransition "transition" =
  "(" _ char:Character _ "->" _ state:State ")"
  { return { char, state } }

State = $ [a-zA-Z0-9]+
Character = [a-zA-Z0-9]

BlockSeparator "new line" = [ \t]* "\n" [ \t\n]*
FileEdge "edge of file" = [ \t\n\r]*

_ "whitespace" = [ \t]*
