
structure TypeChecker =
struct
  open Datatypes SymbolTable Rational BigInt

  fun typeCheck (ast: Block, typs: typtable list, vals: valtable list) : unit=
      let

        fun printExpression expr =
          case expr of
              RationalLiteral r => print ("RationalLiteral(" ^ Rational.showDecimal r ^ ")")
            | Ident id => print ("Ident(" ^ id ^ ")")
            | RatAdd (e1, e2) => (print ("RatAdd(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | RatSub (e1, e2) => (print ("RatSub(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | RatMul (e1, e2) => (print ("RatMul(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | RatDiv (e1, e2) => (print ("RatDiv(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | InverseExpression e => (print ("InverseExpression(") ; printExpression e ; print ")")
            | IntegerLiteral i => print ("IntegerLiteral(" ^ BigInt.st (i) ^ ")")
            | IntAdd (e1, e2) => (print ("IntAdd(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | IntSub (e1, e2) => (print ("IntSub(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | Neg e => (print ("Neg(") ; printExpression e ; print ")")
            | IntMul (e1, e2) => (print ("IntMul(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | IntDiv (e1, e2) => (print ("IntDiv(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | IntMod (e1, e2) => (print ("IntMod(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | BooleanLiteral b => print ("BooleanLiteral(" ^ Bool.toString b ^ ")")
            | LessThan (e1, e2) => (print ("LessThan(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | GreaterThan (e1, e2) => (print ("GreaterThan(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | LessThanOrEqual (e1, e2) => (print ("LessThanOrEqual(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | GreaterThanOrEqual (e1, e2) => (print ("GreaterThanOrEqual(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | Equal (e1, e2) => (print ("Equal(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | NotEqual (e1, e2)=> (print ("NotEqual(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | And (e1, e2) => (print ("And(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | Or (e1, e2) => (print ("Or(") ; printExpression e1 ; print ", "; printExpression e2 ; print ")")
            | Not e => (print ("Not(") ; printExpression e ; print ")")
            | _ => print "Not implemented yet\n"

        fun make_type_string typ =
          case typ of
              Rat => " Rat "
            | Int => " Int "
            | Bool => " Bool "
            | Proc => " Proc "
        
        
        fun find_var_in_scopes (typs:typtable list, vals: valtable list, id) =
          case (typs, vals) of
              (typs_hd::typs_tl, vals_hd::vals_tl) =>
                (case find_var (typs_hd, vals_hd, id) of
                     SOME res => SOME res
                   | NONE => find_var_in_scopes (typs_tl, vals_tl, id))
                    | _ => NONE

        fun checkCommandSeq ( cmds , typs:typtable list, vals: valtable list) : unit = 
            List.app (fn s => checkCommand (s,typs,vals)) cmds

        and checkCommand (cmd, typs:typtable list, vals: valtable list) =
          case cmd of
              AssignmentCmd (id, expr) =>
                let
                  val t = Option.map #1 (find_var_in_scopes (typs, vals, id))
                  val e = checkExpression (expr,typs,vals)
                in
                  case (t, e) of
                      (SOME t', SOME e') => if t' = e' then () else (print ("Type error: " ^ id ^ " := " ); printExpression expr ; print("expected type: "^ make_type_string t' ^ "got"^ make_type_string e');print("\n"); raise Fail "Type error")
                    | _ => (print ("Type error: " ^ id ^ " := " ) ; printExpression expr ; print ("\n"); if t = NONE then (print("variable "^ id ^" not found")) else ();  raise Fail "Type error")
                end
            | CallCmd id => if (Option.isSome (find_var_in_scopes (typs, vals, id))) then ( if #1 (valOf(find_var_in_scopes (typs, vals, id))) = Datatypes.Proc then () else (print ("Type error: " ^ id ^ " is not a function)\n"); raise Fail "Type error") ) else (print ("Type error: " ^ id ^ " is not a function)\n"); raise Fail "Type error")
            | ReadCmd id => if (Option.isSome (find_var_in_scopes (typs, vals, id))) then () else (print ("Type error: " ^ id ^ " is not a declared variable)\n"); raise Fail "Type error")
            | PrintCmd expr => if (Option.isSome (checkExpression (expr,typs,vals))) then () else (print ("Type error: "); printExpression expr; print(" is not a valid expression)\n"); raise Fail "Type error")
            | ConditionalCmd (expr, t as Datatypes.CommandSeq(t_cmd_list) , f as Datatypes.CommandSeq(f_cmd_list)) =>
                (case checkExpression (expr,typs,vals) of
                     SOME Bool => (checkCommandSeq (t_cmd_list,typs,vals); checkCommandSeq (f_cmd_list,typs,vals))
                   | _ => (print ("Type error: " ); printExpression expr ; print(" is not a boolean expression)\n"); raise Fail "Type error"))
            | WhileCmd (expr, cmds as Datatypes.CommandSeq(cmd_list)) =>
                (case checkExpression (expr,typs,vals) of
                     SOME Bool => checkCommandSeq (cmd_list,typs,vals)
                   | _ => (print ("Type error: " ); printExpression expr ; print(" is not a boolean expression)\n"); raise Fail "Type error"))

        and checkExpression (expr, typs:typtable list, vals: valtable list) =
          case expr of
              RationalLiteral _ => SOME Rat
            | Ident id => Option.map #1 (find_var_in_scopes (typs, vals, id))
            | RatAdd (e1, e2) => if checkExpression (e1,typs,vals) = SOME Rat andalso checkExpression (e2,typs,vals) = SOME Rat then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | RatSub (e1, e2) => if checkExpression (e1,typs,vals) = SOME Rat andalso checkExpression (e2,typs,vals) = SOME Rat then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | RatMul (e1, e2) => if checkExpression (e1,typs,vals) = SOME Rat andalso checkExpression (e2,typs,vals) = SOME Rat then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | RatDiv (e1, e2) => if checkExpression (e1,typs,vals)= SOME Rat andalso checkExpression (e2,typs,vals) = SOME Rat then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | RatUn e => if (checkExpression (e,typs,vals)= SOME Rat orelse checkExpression (e,typs,vals)= SOME Int) then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("expected type RatExpression but e: "); printExpression e; print(" is of type: " ^ make_type_string (valOf(checkExpression (e,typs,vals))) ); print("\n"); raise Fail "Type error")
            | MakeRat (e1, e2) => if checkExpression (e1,typs,vals)= SOME Int andalso checkExpression (e2,typs,vals) = SOME Int then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | Neg (e) => if checkExpression (e,typs,vals)= SOME Rat then SOME Rat else if checkExpression (e,typs,vals)= SOME Int  then SOME Int else (print("Type Mismatch in exp: "); printExpression expr; print("expected type RatExpression or Int Expression but e: "); printExpression e; print(" is of type: " ^ make_type_string (valOf(checkExpression (e,typs,vals))) ); print("\n"); raise Fail "Type error")
            | InverseExpression e => if checkExpression (e,typs,vals)= SOME Rat then SOME Rat else (print("Type Mismatch in exp: "); printExpression expr; print("expected type RatExpression but e: "); printExpression e; print(" is of type: " ^ make_type_string (valOf(checkExpression (e,typs,vals))) ); print("\n"); raise Fail "Type error")
            | IntegerLiteral _ => SOME Int
            | IntAdd (e1, e2) => if checkExpression (e1,typs,vals)  = SOME Int andalso checkExpression (e2,typs,vals) = SOME Int then SOME Int else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | IntSub (e1, e2) => if checkExpression (e1,typs,vals) = SOME Int andalso checkExpression (e2,typs,vals) = SOME Int then SOME Int else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | IntMul (e1, e2) => if checkExpression (e1,typs,vals) = SOME Int andalso checkExpression (e2,typs,vals) = SOME Int then SOME Int else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | IntDiv (e1, e2) => if checkExpression (e1,typs,vals) = SOME Int andalso checkExpression (e2,typs,vals)= SOME Int then SOME Int else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | IntMod (e1, e2) => if checkExpression (e1,typs,vals) = SOME Int andalso checkExpression (e2,typs,vals)= SOME Int then SOME Int else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | BooleanLiteral _ => SOME Bool
            | LessThan (e1, e2) => if (checkExpression (e1,typs,vals)  = SOME Int orelse checkExpression (e1,typs,vals)  = SOME Rat ) andalso (checkExpression (e2,typs,vals)  = SOME Int orelse checkExpression (e2,typs,vals)  = SOME Rat ) then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | GreaterThan (e1, e2) => if (checkExpression (e1,typs,vals)  = SOME Int orelse checkExpression (e1,typs,vals)  = SOME Rat ) andalso (checkExpression (e2,typs,vals)  = SOME Int orelse checkExpression (e2,typs,vals)  = SOME Rat ) then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | LessThanOrEqual (e1, e2) => if (checkExpression (e1,typs,vals)  = SOME Int orelse checkExpression (e1,typs,vals)  = SOME Rat ) andalso (checkExpression (e2,typs,vals)  = SOME Int orelse checkExpression (e2,typs,vals)  = SOME Rat ) then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | GreaterThanOrEqual (e1, e2) => if (checkExpression (e1,typs,vals)  = SOME Int orelse checkExpression (e1,typs,vals)  = SOME Rat ) andalso (checkExpression (e2,typs,vals)  = SOME Int orelse checkExpression (e2,typs,vals)  = SOME Rat ) then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | Equal (e1, e2) => if checkExpression (e1,typs,vals)  = checkExpression (e2,typs,vals) then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | NotEqual (e1, e2) => if checkExpression (e1,typs,vals)  = checkExpression (e2,typs,vals) then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | And (e1, e2) => if checkExpression (e1,typs,vals)  = SOME Bool andalso checkExpression (e2,typs,vals) = SOME Bool then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | Or (e1, e2) => if checkExpression (e1,typs,vals)  = SOME Bool andalso checkExpression (e2,typs,vals) = SOME Bool then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("e1: "); printExpression e1; print(" is of type: " ^ make_type_string (valOf(checkExpression (e1,typs,vals))) ); print("e2: "); printExpression e2; print(" is of type: " ^ make_type_string (valOf(checkExpression (e2,typs,vals))) );print("\n"); raise Fail "Type error")
            | Not e => if checkExpression (e,typs,vals)  = SOME Bool then SOME Bool else (print("Type Mismatch in exp: "); printExpression expr; print("expected type BoolExpression but e: "); printExpression e; print(" is of type: " ^ make_type_string (valOf(checkExpression (e,typs,vals))) ); print("\n"); raise Fail "Type error")

        fun checkBlock (Block (DeclarationSeq (RatVarDecls r, IntVarDecls i, BoolVarDecls b, ProcDecls p), cmds as Datatypes.CommandSeq(cmd_list))) =
          let
            val new_typs = #1 (constructor())
            val new_vals = #2 (constructor())
            val new_typs = List.foldl (fn (id, acc) => (id, Rat)::acc) new_typs r
            val new_vals = List.foldl (fn (id, acc) => (id, RatVal (fromDecimal "0"))::acc) new_vals r
            val new_typs = List.foldl (fn (id, acc) => (id, Int)::acc) new_typs i
            val new_vals = List.foldl (fn (id, acc) => (id, IntVal ( bi "0"))::acc) new_vals i
            val new_typs = List.foldl (fn (id, acc) => (id, Bool)::acc) new_typs b
            val new_vals = List.foldl (fn (id, acc) => (id, BoolVal false)::acc) new_vals b
            val new_typs = List.foldl (fn (ProcDef (id, _), acc) => (id, Proc)::acc) new_typs p
            val new_vals = List.foldl (fn (ProcDef (id, block), acc) => (id, ProcVal block)::acc) new_vals p

            val new_typs_list = new_typs::typs
            val new_vals_list = new_vals::vals

            val _ = List.app (fn ProcDef (_, block) => typeCheck (block, new_typs_list, new_vals_list)) p ;
          in
            checkCommandSeq( cmd_list, new_typs_list, new_vals_list)
          end

      in
        checkBlock ast
      end

end;













(* 

val ast = Datatypes.Block (
  Datatypes.DeclarationSeq (
    Datatypes.RatVarDecls ["x", "y"],
    Datatypes.IntVarDecls ["i"],
    Datatypes.BoolVarDecls ["p"],
    Datatypes.ProcDecls []
  ),
  Datatypes.CommandSeq [
    Datatypes.AssignmentCmd ("x", Datatypes.BooleanLiteral false),
    Datatypes.PrintCmd (Datatypes.RatIdent "x")
  ]
);

val (typs, vals) = SymbolTable.constructor ();
TypeChecker.typeCheck (ast, [typs], [vals]); *)
