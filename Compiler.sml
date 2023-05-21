CM.make("$/basis.cm");
CM.make("$/ml-yacc-lib.cm");
use "ass3.sml";
use "Datatypes.sml";
use "grammar.grm.sig";
use "grammar.grm.sml";
use "ass4.lex.sml";
use "glue.sml";
use "symboltable.sml";
use "typechecker.sml";
use "evaluator.sml";

structure RatPL :
sig val compile : string -> Datatypes.Block
end =
struct
exception RatPLError;

fun compile (fileName) =
    let 
        val inStream = TextIO.openIn fileName;

        val grab : int -> string = fn n => 
            if TextIO.endOfStream inStream then ""
            else TextIO.inputN (inStream,n);

        val printError : string * int * int -> unit = fn (msg,line,col) => 
            print (fileName^"["^Int.toString line^":" ^Int.toString col^"] "^msg^"\n");

        val (tree,rem) = RatPLParser.parse (15, (RatPLParser.makeLexer grab fileName), printError, fileName)

        handle RatPLParser.ParseError => raise RatPLError;
        (* Close the source program file *)
        val _ = TextIO.closeIn inStream;
    in 
        tree
    end
end;

Control.Print.printLength := 10000; 
Control.Print.printDepth := 10000; 
Control.Print.stringDepth := 10000;


fun interpret (inputFile, outputFile)=
    let
        val tree = RatPL.compile inputFile;
        val (typs, vals) = SymbolTable.constructor ();
        (* val outFile = TextIO.openOut outputFile *)

        val _ = TypeChecker.typeCheck (tree, [typs], [vals]); 
        val _ = Evaluator.evaluate (tree, [typs], [vals], outputFile);
        (* val _ = TextIO.closeOut outFile; *)
    in
        ()
    end;


