structure Datatypes =
struct

type Ident = string

datatype DeclarationSeq =  DeclarationSeq of RatVarDecls * IntVarDecls * BoolVarDecls * ProcDecls

and Vartype = Rat | Int | Bool | Proc 


and Varvalue = RatVal of Rational.rational | IntVal of BigInt.bigint | BoolVal of bool | ProcVal of Block

and RatVarDecls = RatVarDecls of Ident list 
and IntVarDecls = IntVarDecls of Ident list 
and BoolVarDecls = BoolVarDecls of Ident list 

and ProcDecls = ProcDecls of ProcDef list

and ProcDef = ProcDef of Ident * Block

and Block = Block of DeclarationSeq * CommandSeq

and CommandSeq = CommandSeq of Command list

and Command =
    AssignmentCmd of Ident * Expression
  | CallCmd of Ident
  | ReadCmd of Ident
  | PrintCmd of Expression
  | ConditionalCmd of Expression * CommandSeq * CommandSeq
  | WhileCmd of Expression * CommandSeq

and Expression =
    RationalLiteral of Rational.rational
  | Ident of Ident
  | RatAdd of Expression * Expression
  | RatSub of Expression * Expression
  | RatMul of Expression * Expression
  | RatDiv of Expression * Expression
  | RatUn of Expression
  | MakeRat of Expression * Expression
  | InverseExpression of Expression
  | Neg of Expression
  | IntegerLiteral of BigInt.bigint
  | IntAdd of Expression * Expression
  | IntSub of Expression * Expression
  | IntMul of Expression * Expression
  | IntDiv of Expression * Expression
  | IntMod of Expression * Expression
  | BooleanLiteral of bool
  | LessThan of Expression * Expression
  | GreaterThan of Expression * Expression
  | LessThanOrEqual of Expression * Expression
  | GreaterThanOrEqual of Expression * Expression
  | Equal of Expression * Expression
  | NotEqual of Expression * Expression
  | And of Expression * Expression
  | Or of Expression * Expression
  | Not of Expression

end;