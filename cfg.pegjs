ContextFreeGrammar =
  FileEdge
  terminals:TerminalsDefinition BlockSeparator
  head:Rule
  tail:(BlockSeparator r:Rule { return r })*
  FileEdge
  { return { terminals, productions: [head, ...tail]} }

TerminalsDefinition = "terminals:" _ "{" _
  	head:Symbol
    tail:(_ "," _ v:Symbol { return v })*
  _ "}"
  { return [head, ...tail] }

Rule =
  from:Symbol _ "->" _ toHead:Sentence toTail:(_ "|" _ s:Sentence { return s })*
  { return { from, to: [toHead, ...toTail] } }

Sentence = head:Symbol tail:(_ s:Symbol { return s })* { return [head, ...tail] }
Symbol "symbol" =  $ [a-zA-Z0-9]+

BlockSeparator "new line" = [ \t]* "\n" [ \t\n]*
FileEdge "edge of file" = [ \t\n\r]*
_ "whitespace" = [ \t]*
