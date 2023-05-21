structure T = Tokens
type pos = int
type svalue = T.svalue
type ('a,'b) token = ('a,'b) T.token
type lexresult = (svalue,pos) token
type lexarg = string
type arg = lexarg
val lin = ref 1;
val col = ref 0;
val eolpos = ref 0;


val error : string * int * int -> unit = fn (e,l1,l2) => TextIO.output(TextIO.stdOut,"lex:line " ^Int.toString l1^" l2="^Int.toString l2 ^": "^e^"\n")

val badCh : string * string * int * int -> unit = fn (fileName,bad,line,col) =>
            TextIO.output(TextIO.stdOut,fileName^"["^Int.toString line^"."^Int.toString col ^"] Invalid character \""^bad^"\"\n");

val eof = fn fileName => T.EOF (!lin,!col);

%%

%full
%header (functor RatPLLexFun(structure Tokens: RatPL_TOKENS));
%arg (fileName:string);
%s PI COMMENT;

alpha = [a-zA-Z];
digit = [0-9];
ws = [\ \t];
sign=[+~];

%%

<INITIAL>"(*" => (YYBEGIN COMMENT; continue ());
<INITIAL>{ws}* => (lin:=1; eolpos:=0; YYBEGIN PI; continue ());


<PI>{ws}+ => (continue ());
<PI>"\013\010" => (lin:=(!lin)+1; eolpos:=yypos+size yytext; continue ());
<PI>"\010" => (lin:=(!lin)+1; eolpos:=yypos+size yytext; continue ());
<PI>"\013" => (lin:=(!lin)+1; eolpos:=yypos+size yytext; continue ());
<PI>"rational" => (col:=yypos-(!eolpos); T.RATIONAL(!lin,!col));
<PI>"integer" => (col:=yypos-(!eolpos); T.INTEGER(!lin,!col));
<PI>"boolean" => (col:=yypos-(!eolpos); T.BOOLEAN(!lin,!col));
<PI>"tt" => (col:=yypos-(!eolpos); T.TRUE(!lin,!col));
<PI>"ff" => (col:=yypos-(!eolpos); T.FALSE(!lin,!col));
<PI>"var" => (col:=yypos-(!eolpos); T.VAR(!lin,!col));
<PI>"if" => (col:=yypos-(!eolpos); T.IF(!lin,!col));
<PI>"then" => (col:=yypos-(!eolpos); T.THEN(!lin,!col));
<PI>"else" => (col:=yypos-(!eolpos); T.ELSE(!lin,!col));
<PI>"fi" => (col:=yypos-(!eolpos); T.FI(!lin,!col));
<PI>"while" => (col:=yypos-(!eolpos); T.WHILE(!lin,!col));
<PI>"do" => (col:=yypos-(!eolpos); T.DO(!lin,!col));
<PI>"od" => (col:=yypos-(!eolpos); T.OD(!lin,!col));
<PI>"procedure" => (col:=yypos-(!eolpos); T.PROCEDURE(!lin,!col));
<PI>"print" => (col:=yypos-(!eolpos); T.PRINT(!lin,!col));
<PI>"read" => (col:=yypos-(!eolpos); T.READ(!lin,!col));
<PI>"call" => (col:=yypos-(!eolpos); T.CALL(!lin,!col));
<PI>"make_rat" => (col:=yypos-(!eolpos); T.MAKERAT(!lin,!col));
<PI>"showRat" => (col:=yypos-(!eolpos); T.SHOWRAT(!lin,!col));
<PI>"showDecimal" => (col:=yypos-(!eolpos); T.SHOWDECIMAL(!lin,!col));
<PI>"fromDecimal" => (col:=yypos-(!eolpos); T.FROMDECIMAL(!lin,!col));
<PI>"rat" => (col:=yypos-(!eolpos); T.RAT_UN(!lin,!col));
<PI>"toDecimal" => (col:=yypos-(!eolpos); T.TODECIMAL(!lin,!col));
<PI>"inverse" => (col:=yypos-(!eolpos); T.INVERSE(!lin,!col));

<PI>"(*" => (YYBEGIN COMMENT; continue ());

<PI>{sign}?({digit}*"."({digit}*)"("({digit}+)")") => (Tokens.RATNUM (Rational.fromDecimal (yytext),!lin,!col));
<PI>{sign}?({digit}*"."({digit}+)) => (Tokens.RATNUM (Rational.fromDecimal (yytext),!lin,!col));
<PI>{sign}?({digit}+) => (Tokens.CONST (BigInt.bi(yytext),!lin,!col));

<PI>({alpha}|"_")({alpha}|{digit}|"_")* => ((col:=yypos-(!eolpos); print ("making identifier: "^yytext ^ "\n");T.IDENT(yytext,!lin,!col)));

<PI>"=" => (col:=yypos-(!eolpos); T.EQUALS(!lin,!col));
<PI>"(" => (col:=yypos-(!eolpos); T.LPAR(!lin,!col));
<PI>")" => (col:=yypos-(!eolpos); T.RPAR(!lin,!col));
<PI>"{" => (col:=yypos-(!eolpos); print("making LBRACE");T.LBRACE(!lin,!col));
<PI>"}" => (col:=yypos-(!eolpos); print ("making RBRACE");T.RBRACE(!lin,!col));
<PI>"!" => (col:=yypos-(!eolpos); T.NOT(!lin,!col));
<PI>"||" => (col:=yypos-(!eolpos); T.OR(!lin,!col));
<PI>"&&" => (col:=yypos-(!eolpos); T.AND(!lin,!col));
<PI>"<=" => (col:=yypos-(!eolpos); T.LE(!lin,!col));
<PI>"<" => (col:=yypos-(!eolpos); T.LT(!lin,!col));
<PI>">=" => (col:=yypos-(!eolpos); T.GE(!lin,!col));
<PI>">" => (col:=yypos-(!eolpos); T.GT(!lin,!col));
<PI>".+." => (col:=yypos-(!eolpos); T.RATPLUS(!lin,!col));
<PI>".-." => (col:=yypos-(!eolpos); T.RATMINUS(!lin,!col));
<PI>".*." => (col:=yypos-(!eolpos); T.RATTIMES(!lin,!col));
<PI>"./." => (col:=yypos-(!eolpos); T.RATDIV(!lin,!col));
<PI>"+" => (col:=yypos-(!eolpos); T.INTPLUS(!lin,!col));
<PI>"-" => (col:=yypos-(!eolpos); T.INTMINUS(!lin,!col));
<PI>"*" => (col:=yypos-(!eolpos); T.INTTIMES(!lin,!col));
<PI>"/" => (col:=yypos-(!eolpos); T.INTDIV(!lin,!col));
<PI>";" => (col:=yypos-(!eolpos); T.SEMI(!lin,!col));
<PI>"," => (col:=yypos-(!eolpos); T.COMMA(!lin,!col));
<PI>"~" => (col:=yypos-(!eolpos); T.NEG(!lin,!col));
<PI>"%" => (col:=yypos-(!eolpos); T.MOD(!lin,!col));
<PI>"<>" => (col:=yypos-(!eolpos); T.NE(!lin,!col));
<PI>":=" => (col:=yypos-(!eolpos); T.ASSIGN(!lin,!col));


<PI>. => (col:=yypos-(!eolpos); badCh (fileName,yytext,!lin,!col); print("Bad character : " ^ yytext ^ "\n"); continue ());

<COMMENT>"*)" => (YYBEGIN PI; continue ());
<COMMENT>. => (continue ());
