
signature SYMBOLTABLE =
sig
    type typtable
    type valtable
    exception environment_error of string
    val constructor : unit -> typtable * valtable
    val add_var : typtable * valtable * Datatypes.Ident * Datatypes.Vartype -> typtable * valtable
    val find_var : typtable * valtable * Datatypes.Ident -> (Datatypes.Vartype * Datatypes.Varvalue) option
    val change_value : valtable * Datatypes.Ident * Datatypes.Varvalue -> valtable
end;

structure SymbolTable : SYMBOLTABLE =
struct
    type typtable = (Datatypes.Ident * Datatypes.Vartype) list
    type valtable = (Datatypes.Ident * Datatypes.Varvalue) list
    exception environment_error of string

    fun constructor () = ([], [])

    fun add_var (typs, vals, id, t) =
    let 
        val v = case t of
            Datatypes.Int => Datatypes.IntVal (BigInt.bi "0")
          | Datatypes.Bool => Datatypes.BoolVal false
          | Datatypes.Rat => Datatypes.RatVal (Rational.fromDecimal "0")
          | Datatypes.Proc => Datatypes.ProcVal (Datatypes.Block (Datatypes.DeclarationSeq ( Datatypes.RatVarDecls [], Datatypes.IntVarDecls [], Datatypes.BoolVarDecls [], Datatypes.ProcDecls []), Datatypes.CommandSeq []))
    in
        if List.exists (fn (x, _) => x = id) typs then
            raise environment_error ("Variable " ^ id ^ " already exists")
        else
            ((id, t)::typs, (id, v)::vals)
    end

    fun find_var (typs: typtable, vals: valtable, id: Datatypes.Ident) =
        case (List.find (fn (x, _) => x = id) typs, List.find (fn (x, _) => x = id) vals) of
            (SOME t, SOME v) => SOME (#2 t, #2 v)
          | _ => NONE 
        
    fun change_value (vals, id, newv) =
        if List.exists (fn (x, _) => x = id) vals then
            List.map (fn (x, v) => if x = id then (x, newv) else (x, v)) vals
        else
            (raise environment_error ("Variable " ^ id ^ " not found"))
end;

