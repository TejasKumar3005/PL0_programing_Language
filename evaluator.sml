structure Evaluator =
struct
  open Datatypes SymbolTable Rational BigInt

  fun evaluate (ast: Block, typs: typtable list, vals: valtable list, outputFile) : valtable list =
      let

        fun find_var_in_scopes (typs:typtable list, vals: valtable list, id) =
          case (typs, vals) of
              (typs_hd::typs_tl, vals_hd::vals_tl) =>
                (case find_var (typs_hd, vals_hd, id) of
                     SOME res => SOME res
                   | NONE => find_var_in_scopes (typs_tl, vals_tl, id))
                    | _ => NONE

        fun print_valtables (vals_list: valtable list) : unit =
            let
                fun print_valtable (vals: valtable) : unit =
                    let
                        fun print_var (id, value) : unit =
                            let
                                val value_str = case value of
                                                    RatVal r => Rational.showDecimal r
                                                | IntVal i => BigInt.st i
                                                | BoolVal b => Bool.toString b
                                                | ProcVal _ => "<procedure>"
                            in
                                print (id ^ " = " ^ value_str ^ "\n")
                            end
                    in
                        List.app print_var vals
                    end

                fun print_helper (vals_list, first) : unit =
                    case vals_list of
                        [] => ()
                    | hd::tl =>
                        (if not first then print ("--- Demarker ---\n")
                        else ();
                        print_valtable hd;
                        print_helper (tl, false))
            in
                print_helper (vals_list, true)
            end

        fun print_typtables (typs_list: typtable list) : unit =
            let
                fun print_typetable (typs: typtable) : unit =
                    let
                        fun print_var (id, typ) : unit =
                            let
                                val type_str = case typ of
                                                    Rat => "Rational"
                                                | Int => "Integer"
                                                | Bool => "Boolean"
                                                | Proc => "Procedure"
                            in
                                print (id ^ " : " ^ type_str ^ "\n")
                            end
                    in
                        List.app print_var typs
                    end

                fun print_helper (typs_list, first) : unit =
                    case typs_list of
                        [] => ()
                    | hd::tl =>
                        (if not first then print ("--- Demarker ---\n")
                        else ();
                        print_typetable hd;
                        print_helper (tl, false))
            in
                print_helper (typs_list, true)
            end


        fun update_val_in_first_scope ([], _, _) = raise Fail "Variable not found in any scope"
        | update_val_in_first_scope (v::vs, id, value) =
            if List.exists (fn (x, _) => x = id) v then
                (change_value (v, id, value))::vs
            else
                v::(update_val_in_first_scope (vs, id, value))


        fun evalCommandSeq ( cmds , typs:typtable list, vals: valtable list) : valtable list = 
            List.foldl (fn (s, acc) => evalCommand (s,typs,acc)) vals cmds

        and evalCommand (cmd, typs:typtable list, vals: valtable list) : valtable list =
          case cmd of
              AssignmentCmd (id , expr) =>
                let
                    val value = evalExpression (expr,typs,vals)
                    val found = find_var_in_scopes (typs, vals, id)
                    (* val _ = print (id ^ " = "^ (case value of
                                                    SOME (RatVal r) => Rational.showDecimal r
                                                | SOME (IntVal i) => BigInt.st i
                                                | SOME (BoolVal b) => Bool.toString b
                                                | _ => raise Fail "Invalid expression type for assignment") ^ "\n") *)
                in
                    if Option.isSome value andalso Option.isSome found then
                            update_val_in_first_scope (vals, id, valOf value)
                    else
                        raise Fail "Invalid expression type for assignment"
                end
            | CallCmd id =>
                (case find_var_in_scopes (typs, vals, id) of
                     SOME (_, ProcVal block) => evaluate (block, typs, vals,outputFile)
                   | _ => raise Fail "Invalid variable type for call")
            | ReadCmd id =>
                let
                

                fun dropWhile (f: 'a -> bool) (l: 'a list) =
                    case l of
                        [] => []
                        | x :: xs => if f x then dropWhile (f) xs else l
            
                val input = valOf(TextIO.inputLine TextIO.stdIn)

                val inputval = implode(List.rev(dropWhile (fn x => x = #" " orelse x = #"\013" orelse x = #"\010") (tl(List.rev(explode(input))))))
                
                val value = case find_var_in_scopes (typs, vals, id) of
                                SOME ( Rat, _) => SOME (RatVal (Rational.fromDecimal inputval))
                            | SOME ( Int, _) => SOME (IntVal (BigInt.bi inputval))
                            | SOME ( Bool, _) => SOME( BoolVal (if inputval = "tt" then true else if inputval = "ff" then false else raise Fail "Invalid boolean input"))
                            | _ => NONE
                in
                    if Option.isSome value then
                      change_value (hd vals, id, valOf(value))::(tl vals)

                    else
                        raise Fail "Invalid variable type for read"
                end
            | PrintCmd expr =>
                let
                    val value = evalExpression (expr,typs,vals)
                    fun appendToFile s =
                        let
                            val outFile = TextIO.openAppend outputFile
                            val _ = TextIO.output (outFile, s)
                        in
                            TextIO.closeOut outFile
                        end
                in
                    (case value of
                        SOME (RatVal r) => appendToFile ((Rational.showDecimal r) ^ "\n")
                    | SOME (IntVal i) => appendToFile ((BigInt.st i)^ "\n")
                    | SOME (BoolVal b) => if b then appendToFile "tt \n" else appendToFile "ff \n"
                    | _ =>( raise Fail "Invalid expression type for printing");
                    vals)
                end

            | ConditionalCmd (expr, t as Datatypes.CommandSeq(t_cmd_list) , f as Datatypes.CommandSeq(f_cmd_list)) =>
                (case evalExpression (expr,typs,vals) of
                     SOME (BoolVal true) => evalCommandSeq (t_cmd_list,typs,vals)
                   | SOME (BoolVal false) => evalCommandSeq (f_cmd_list,typs,vals)
                   | _ => raise Fail "Invalid expression type for conditional")

            | WhileCmd (expr, cmds as Datatypes.CommandSeq(cmd_list)) =>
                (case evalExpression (expr,typs,vals) of
                     SOME (BoolVal true) => evalCommand (cmd, typs, evalCommandSeq (cmd_list,typs,vals))
                   | SOME (BoolVal false) => vals
                   | _ => raise Fail "Invalid expression type for while")

        and evalExpression (expr, typs:typtable list, vals: valtable list) : Varvalue option =
          case expr of
              RationalLiteral r => SOME (RatVal r)
            | Ident id => (case find_var_in_scopes (typs, vals, id) of
                               SOME (Rat, RatVal r) => SOME (RatVal r)
                             | SOME (Int, IntVal i) => SOME (IntVal i)
                             | SOME (Bool, BoolVal b) => SOME (BoolVal b)
                             | _ => NONE)
            | RatAdd (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (RatVal r1), SOME (RatVal r2)) => SOME (RatVal (Rational.add (r1 ,r2)))
                   | _ => NONE)
            | RatSub (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (RatVal r1), SOME (RatVal r2)) => SOME (RatVal (Rational.subtract  (r1 ,r2)))
                   | _ => NONE)
            | RatMul (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (RatVal r1), SOME (RatVal r2)) => SOME (RatVal (Rational.multiply  (r1 ,r2)))
                   | _ => NONE)
            | RatDiv (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of (SOME (RatVal r1), SOME (RatVal r2)) => SOME (RatVal (valOf (Rational.divide (r1 ,r2))))
                   | _ => NONE)

            | RatUn e => (case evalExpression (e,typs,vals) of
                     SOME (IntVal i) => SOME (RatVal (valOf (Rational.rat i)))
                   | _ => NONE)
            | MakeRat (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (RatVal (valOf (Rational.make_rat (i1, i2))))
                   | _ => NONE)
            | InverseExpression e =>
                (case evalExpression (e,typs,vals) of
                     SOME (RatVal r) => SOME (RatVal (valOf (Rational.inverse r)))
                   | _ => NONE)
            | Neg e =>
                (case evalExpression (e,typs,vals) of
                     SOME (RatVal r) => SOME (RatVal  (Rational.neg r))
                     | SOME (IntVal i) => SOME (IntVal (BigInt.neg i))
                   | _ => NONE)
            | IntegerLiteral i => SOME (IntVal i)
            | IntAdd (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (IntVal (BigInt.add (i1, i2)))
                   | _ => NONE)
            | IntSub (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (IntVal (BigInt.subtract (i1, i2)))
                   | _ => NONE)
            | IntMul (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (IntVal (BigInt.multiply (i1, i2)))
                   | _ => NONE)
            | IntDiv (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (IntVal (#1 (BigInt.divide (i1, i2))))
                   | _ => NONE)
            | IntMod (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (IntVal (#2 (BigInt.divide (i1, i2))))
                   | _ => NONE)
            | BooleanLiteral b => SOME (BoolVal b)
            | LessThan (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (BoolVal (BigInt.compare (i1, i2) = LESS))
                   | (SOME (RatVal r1), SOME (RatVal r2)) => SOME (BoolVal (Rational.less  (r1 ,r2)))
                   | _ => NONE)
            | GreaterThan (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (BoolVal (BigInt.compare (i1, i2) = GREATER))
                   | (SOME (RatVal r1), SOME (RatVal r2)) => SOME (BoolVal (not (Rational.less (r1 ,r2)) andalso not (Rational.equal (r1 ,r2))))
                   | _ => NONE)
            | LessThanOrEqual (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (BoolVal (BigInt.compare (i1, i2) = LESS orelse BigInt.compare (i1, i2) = EQUAL))
                   | (SOME (RatVal r1), SOME (RatVal r2)) => SOME (BoolVal ((Rational.less  (r1 ,r2)) orelse (Rational.equal (r1 ,r2))))
                   | _ => NONE)
            | GreaterThanOrEqual (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (BoolVal (BigInt.compare (i1, i2) = GREATER orelse BigInt.compare (i1, i2) = EQUAL))
                   | (SOME (RatVal r1), SOME (RatVal r2)) => SOME (BoolVal (not (Rational.less  (r1 ,r2))))
                   | _ => NONE)
            | Equal (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (IntVal i1), SOME (IntVal i2)) => SOME (BoolVal (BigInt.compare (i1, i2) = EQUAL))
                     | (SOME (RatVal r1), SOME (RatVal r2)) => SOME (BoolVal (Rational.equal  (r1 ,r2)))
                     | (SOME (BoolVal b1), SOME (BoolVal b2)) => SOME (BoolVal (b1 = b2))
                   | _ => NONE)
            | NotEqual (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                        (SOME (IntVal i1), SOME (IntVal i2)) => SOME (BoolVal (BigInt.compare (i1, i2) <> EQUAL))
                        | (SOME (RatVal r1), SOME (RatVal r2)) => SOME (BoolVal (not (Rational.equal  (r1 ,r2))))
                   | _ => NONE)
            | And (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (BoolVal b1), SOME (BoolVal b2)) => SOME (BoolVal (b1 andalso b2))
                   | _ => NONE)
            | Or (e1, e2) =>
                (case (evalExpression (e1,typs,vals), evalExpression (e2,typs,vals)) of
                     (SOME (BoolVal b1), SOME (BoolVal b2)) => SOME (BoolVal (b1 orelse b2))
                   | _ => NONE)
            | Not e =>
                (case evalExpression (e,typs,vals) of
                     SOME (BoolVal b) =>  SOME (BoolVal (not b))
                   | _ => NONE)

        fun evalBlock (Block (DeclarationSeq (RatVarDecls r, IntVarDecls i, BoolVarDecls b, ProcDecls p), cmds as Datatypes.CommandSeq(cmd_list))) =
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
          in
            tl (evalCommandSeq( cmd_list, new_typs_list, new_vals_list))
          end

      in
        evalBlock ast
      end

end;