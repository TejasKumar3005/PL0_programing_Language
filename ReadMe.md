
# Rarional_PL0 Programming Language Interpreter

This Rarional_PL0 evaluator is designed to perform static scoping, type checking, and evaluation of a given input file inputFile by runnig interpret(inputFile, outputFile) it firsts performs lexical analysis of the file to give tokens these tokens are then taken by yacc generated file to foarm a Abstract Syntax Tree (AST) with a `Block` node representing a sample program the Datatypes of children Node for each Node is given in Datatypes.sml .


### Grammar of Rarional_PL0 Language

Starting Token = Program

Precedence of Operators  in increasing order = 

ASSIGN OR 
AND
EQUALS NE
LE GE LT GT
INTPLUS INTMINUS
INTTIMES INTDIV MOD
RATPLUS RATMINUS
RATTIMES RATDIV
NOT
INVERSE NEG

Program: Block 

Block: DeclarationSeq CommandSeq 

DeclarationSeq: RatVarDecls IntVarDecls BoolVarDecls ProcDecls 

RatVarDecls: 
 RATIONAL IDENT Identlist SEMI
| 

IntVarDecls: 
INTEGER IDENT Identlist SEMI 
| 

BoolVarDecls: 
BOOLEAN IDENT Identlist SEMI 
| 

Identlist: 
COMMA IDENT Identlist 
| 

ProcDecls: ProcDef ProcDecls 
| 

ProcDef: PROCEDURE IDENT Block SEMI 

CommandSeq: LBRACE Command  Commandlist RBRACE 
| 

Commandlist: Command Commandlist 
| 

Command: IDENT ASSIGN Expression SEMI 
| CALL IDENT SEMI 
| READ LPAR IDENT RPAR SEMI 
| PRINT LPAR Expression RPAR SEMI 
| IF Expression THEN CommandSeq ELSE CommandSeq FI SEMI 
| WHILE Expression DO CommandSeq OD SEMI 

Expression: 

RATNUM 
| IDENT 
| Expression RATPLUS Expression 
| Expression RATMINUS Expression
| Expression RATTIMES Expression 
| Expression RATDIV Expression 
| INVERSE Expression 
| MAKERAT LPAR Expression COMMA Expression RPAR 
| FROMDECIMAL LPAR RATNUM RPAR 
| RAT_UN LPAR Expression RPAR 


| CONST 
| Expression INTPLUS Expression 
| Expression INTMINUS Expression
| Expression INTTIMES Expression
| Expression INTDIV Expression 
| Expression MOD Expression 


| TRUE 
| FALSE 
| Expression LT Expression 
| Expression GT Expression 
| Expression LE Expression 
| Expression GE Expression 
| Expression EQUALS Expression 
| Expression NE Expression 
| Expression AND Expression 
| Expression OR Expression 
| NOT Expression
| LPAR Expression RPAR 


### SymbolTable

We have implemented a `signature SYMBOLTABLE` that contains the required types and functions to manage the symbol tables for both types and values. It includes a `constructor` function to create a new symbol table, and functions to add, find, and change variables in the symbol table.

### Typechecker

The `Typechecker` module recursively checks the nodes and their children in the AST to ensure that the type declaration of the latest declaration is used. It implements a static scope for checking the types and validating the program.

### Evaluator

The `Evaluator` structure evaluates the AST tree given a `Block` node. It implements a static scope `SymbolTable` stack for assignment and referencing of variables.

The evaluator supports various commands such as Assignment, Call, Read, Print, Conditional, and While. It also supports various expressions such as Rational, Integer, and Boolean literals, identifiers, arithmetic operations, comparisons, and logical operations.

### File Output

The `PrintCmd` function has been updated to write the output to a file named `outputFile`. This function appends the output to the file so that the previous writes are not overwritten.

## Design Descisions

1. The + opperator is supposed to not be in touch with integer on the right as then it might also become unary operator. But we have implemented it as it is not mentioned in the assignment.
2. in read extra space is not allowed infraont of the expression
3. Extensive Type checking and error reporting on mismatched types are done in the typechecker module.


## Acknowledgements
1. https://rogerprice.org/ML-Lex-Yacc-Guide/ML-Lex-Yacc-Guide.pdf for the guide on lex and yacc