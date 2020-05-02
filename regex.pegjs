RegularExpressionGrammar =
  FileEdge
  alphabet:AlphabetDefinition BlockSeparator
  expression:R
  FileEdge
  { return { alphabet, expression } }

AlphabetDefinition =
  "alphabet:" _ "{" _
  	head:Symbol
    tail:(_ "," _ v:Symbol { return v })*
  _ "}"
  { return [head, ...tail] }

RegularExpressionDefinition = r:R { return { expression: r } }

R = s:S _ "|" _ r:R { return { operation: "or", operand: [s, r] } }
  / s:S _ "&" _ r:R { return { operation: "and", operand: [s, r] } }
  / S
  / "" { return { operation: "empty", operand: "" } }

S = t:T _ s:S { return [t, ...s] }
  / t:T { return [t] }

T = "-" _ u:U { return { operation: "negate", operand: u } }
  / U

U = v:V "*" { return { operation: "star", operand: v } }
  / V

V = Symbol
  / "(" _ r:R _ ")" { return r }
  / "." { return { operation: "dotall", operand: "" } }

Symbol "symbol" =  $ [a-zA-Z0-9]

BlockSeparator "new line" = [ \t]* "\n" [ \t\n]*
FileEdge "edge of file" = [ \t\n\r]*
_ "whitespace" = [ \t]*
