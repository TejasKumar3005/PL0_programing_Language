signature RatPL_TOKENS =
sig
type ('a,'b) token
type svalue
val IDENT: (Datatypes.Ident) *  'a * 'a -> (svalue,'a) token
val EOF:  'a * 'a -> (svalue,'a) token
val INVERSE:  'a * 'a -> (svalue,'a) token
val TODECIMAL:  'a * 'a -> (svalue,'a) token
val FROMDECIMAL:  'a * 'a -> (svalue,'a) token
val SHOWDECIMAL:  'a * 'a -> (svalue,'a) token
val SHOWRAT:  'a * 'a -> (svalue,'a) token
val MAKERAT:  'a * 'a -> (svalue,'a) token
val CALL:  'a * 'a -> (svalue,'a) token
val READ:  'a * 'a -> (svalue,'a) token
val PRINT:  'a * 'a -> (svalue,'a) token
val RAT_UN:  'a * 'a -> (svalue,'a) token
val PROCEDURE:  'a * 'a -> (svalue,'a) token
val OD:  'a * 'a -> (svalue,'a) token
val DO:  'a * 'a -> (svalue,'a) token
val WHILE:  'a * 'a -> (svalue,'a) token
val FI:  'a * 'a -> (svalue,'a) token
val ELSE:  'a * 'a -> (svalue,'a) token
val THEN:  'a * 'a -> (svalue,'a) token
val IF:  'a * 'a -> (svalue,'a) token
val VAR:  'a * 'a -> (svalue,'a) token
val FALSE:  'a * 'a -> (svalue,'a) token
val TRUE:  'a * 'a -> (svalue,'a) token
val BOOLEAN:  'a * 'a -> (svalue,'a) token
val INTEGER:  'a * 'a -> (svalue,'a) token
val RATIONAL:  'a * 'a -> (svalue,'a) token
val ASSIGN:  'a * 'a -> (svalue,'a) token
val NE:  'a * 'a -> (svalue,'a) token
val MOD:  'a * 'a -> (svalue,'a) token
val NEG:  'a * 'a -> (svalue,'a) token
val COMMA:  'a * 'a -> (svalue,'a) token
val SEMI:  'a * 'a -> (svalue,'a) token
val INTDIV:  'a * 'a -> (svalue,'a) token
val INTTIMES:  'a * 'a -> (svalue,'a) token
val INTMINUS:  'a * 'a -> (svalue,'a) token
val INTPLUS:  'a * 'a -> (svalue,'a) token
val RATDIV:  'a * 'a -> (svalue,'a) token
val RATTIMES:  'a * 'a -> (svalue,'a) token
val RATMINUS:  'a * 'a -> (svalue,'a) token
val RATPLUS:  'a * 'a -> (svalue,'a) token
val GT:  'a * 'a -> (svalue,'a) token
val GE:  'a * 'a -> (svalue,'a) token
val LT:  'a * 'a -> (svalue,'a) token
val LE:  'a * 'a -> (svalue,'a) token
val AND:  'a * 'a -> (svalue,'a) token
val OR:  'a * 'a -> (svalue,'a) token
val NOT:  'a * 'a -> (svalue,'a) token
val RBRACE:  'a * 'a -> (svalue,'a) token
val LBRACE:  'a * 'a -> (svalue,'a) token
val RPAR:  'a * 'a -> (svalue,'a) token
val LPAR:  'a * 'a -> (svalue,'a) token
val EQUALS:  'a * 'a -> (svalue,'a) token
val RATNUM: (Rational.rational) *  'a * 'a -> (svalue,'a) token
val CONST: (BigInt.bigint) *  'a * 'a -> (svalue,'a) token
end
signature RatPL_LRVALS=
sig
structure Tokens : RatPL_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
