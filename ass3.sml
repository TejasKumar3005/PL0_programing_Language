signature BIGINT =
    sig
        type bigint
        exception bigint_error
        val neg : bigint -> bigint (* negation *)
        val equal : bigint * bigint -> bool (* equality *)
        val greater : bigint * bigint -> bool (* greater than *)
        val add : bigint * bigint -> bigint (* addition *)
        val bi : string -> bigint (* make a bigint from a string *)
        val st : bigint -> string (* convert a bigint to a string *)
        val subtract : bigint * bigint -> bigint (* subtraction *)
        val multiply : bigint * bigint -> bigint (* multiplication *)
        val abs : bigint -> bigint (* absolute value *)
        val positive : bigint -> bool (* is the bigint positive? *)
        val divide : bigint * bigint -> bigint * bigint (* division *)
        val gcd : bigint * bigint -> bigint (* greatest common divisor *)
        val remove_leading_zeroes : bigint -> bigint (* remove leading zeroes *)
        val lcm : bigint * bigint -> bigint (* least common multiple *)
        val valid : bigint -> bool (* is the bigint valid? *)
        val compare : bigint * bigint -> order (* compare two bigints *)
    end

structure BigInt : BIGINT =
    struct
        type bigint = string
        exception bigint_error

        fun st (b) = b
        fun valid (a: string) = 
            let
                fun valid_helper (a: string, i: int) = 
                    if i = String.size a then true
                    else if String.substring (a, i, 1) = "0" orelse String.substring (a, i, 1) = "1" orelse String.substring (a, i, 1) = "2" orelse String.substring (a, i, 1) = "3" orelse String.substring (a, i, 1) = "4" orelse String.substring (a, i, 1) = "5" orelse String.substring (a, i, 1) = "6" orelse String.substring (a, i, 1) = "7" orelse String.substring (a, i, 1) = "8" orelse String.substring (a, i, 1) = "9" then valid_helper (a, i+1)
                    else false
            in
                if String.substring (a, 0, 1) = "~" orelse String.substring (a, 0, 1) = "+" then valid_helper (String.substring (a, 1, String.size a - 1), 0)
                else valid_helper (a, 0)
            end
        fun abs (b:string):string = 
            if String.substring (b, 0, 1) = "~" then String.substring (b, 1, String.size b - 1)
            else if String.substring (b, 0, 1) = "+" then String.substring (b, 1, String.size b - 1)
            else b

        fun check0 (s:string) : string = 
                    let
                        val s_list = String.explode s
                        fun remove_leading_zeroes_helper (s_list: char list) : char list = 
                            case s_list of
                                [] => []
                                | [#"0"] => [#"0"]
                                | x::xs => if x = #"0" then remove_leading_zeroes_helper xs else s_list
                    in
                        String.implode (remove_leading_zeroes_helper s_list)
                    end


        fun positive (b:string):bool = 
            if String.substring (b, 0, 1) = "~" then if check0 (String.substring (b, 1, String.size b - 1)) = "0" then true else false
            else true

        fun remove_leading_zeroes (s:string) : string = 
            let
                val s_list = String.explode (abs s)
                val s_sign = positive s
                fun remove_leading_zeroes_helper (s_list: char list) : char list = 
                    case s_list of
                        [] => []
                        | [#"0"] => [#"0"]
                        | x::xs => if x = #"0" then remove_leading_zeroes_helper xs else s_list
            in
                if s_sign then String.implode (remove_leading_zeroes_helper s_list) else "~" ^ String.implode (remove_leading_zeroes_helper s_list)
            end
            
        fun bi (s) = remove_leading_zeroes s

        fun neg (b:string):string =
            if String.substring (b, 0, 1) = "~" then String.substring (b, 1, String.size b - 1)
            else if String.substring (b, 0, 1) = "+" then "~" ^ String.substring (b, 1, String.size b - 1)
            else "~" ^ b


        fun greater (a:bigint, b:bigint) = 
            let
                val a_real = remove_leading_zeroes a
                val b_real = remove_leading_zeroes b
                val a_len = String.size( abs(a_real))
                val b_len = String.size( abs( b_real))
                val a_sign = positive a
                val b_sign = positive b

            in
            if a_sign andalso b_sign then
                (if a_len > b_len then true
                else if a_len < b_len then false
                else if a_real >= b_real then true
                else false)
            else if a_sign andalso not b_sign then true
            else if not a_sign andalso b_sign then false
            else 
                (if a_len > b_len then false
                else if a_len < b_len then true
                else if a_real <= b_real then true
                else true)
            end
            
        
        fun equal (a:bigint, b: bigint) = 
            let
                val a_real = remove_leading_zeroes a
                val b_real = remove_leading_zeroes b
            in
                a_real = b_real
            end
        
        fun make_int_char #"0" = 0
            | make_int_char #"1" = 1
            | make_int_char #"2" = 2
            | make_int_char #"3" = 3
            | make_int_char #"4" = 4
            | make_int_char #"5" = 5
            | make_int_char #"6" = 6
            | make_int_char #"7" = 7
            | make_int_char #"8" = 8
            | make_int_char #"9" = 9
            | make_int_char _ = 0

        fun make_int_string "0" = 0
            | make_int_string "1" = 1
            | make_int_string "2" = 2
            | make_int_string "3" = 3
            | make_int_string "4" = 4
            | make_int_string "5" = 5
            | make_int_string "6" = 6
            | make_int_string "7" = 7
            | make_int_string "8" = 8
            | make_int_string "9" = 9
            | make_int_string _ = 0

        fun int_list_to_string (lst: int list) : string = 
            let
                val str_list = List.map Int.toString lst
            in
                String.concat str_list
            end

        fun multiplier_digit (a: string , b_digit : string): string = 
            let
                fun multiplier_helper (a: int list, b: int, c: int, result: int list) =
                    case a of
                        [] => if c = 0 then result else [c] @ result
                        | x::xs =>
                            let
                                val product = x * b + c
                                val digit = product mod 10
                                val carry = product div 10
                            in
                                multiplier_helper (xs, b, carry, digit::result)
                            end
            in
                int_list_to_string (multiplier_helper (List.rev (List.map make_int_char (String.explode (a))),
                                            make_int_string b_digit, 0, []))
            end

        fun adder_helper (a: string, b: string, carry: int, result: string): bigint =
                    if a = "" andalso b = "" andalso carry = 0 then result
                    else let
                        val a_digit = if a = "" then 0 else (make_int_string (String.substring (a, 0, 1)) handle _ => 0)
                        val b_digit = if b = "" then 0 else (make_int_string (String.substring (b, 0, 1)) handle _ => 0)
                        val sum = a_digit + b_digit + carry
                        val digit = sum mod 10
                        val new_carry = sum div 10
                        val new_a = if a = "" then "" else String.substring (a, 1, String.size a - 1)
                        val new_b = if b = "" then "" else String.substring (b, 1, String.size b - 1)
                        in adder_helper (new_a, new_b, new_carry, Int.toString digit ^ result) end

        fun subtractor_helper (a:string, b:string, borrow:int) = 
                    if a = "" andalso b = "" andalso borrow = 0 then ""
                    else let
                        val a_digit = if a = "" then 0 else (make_int_string (String.substring (a, 0, 1)) handle _ => 0)
                        val b_digit = if b = "" then 0 else (make_int_string (String.substring (b, 0, 1)) handle _ => 0)
                        val diff = a_digit - b_digit - borrow
                        val digit = if diff < 0 then Int.toString (diff + 10) else Int.toString diff
                        val new_borrow = if diff < 0 then 1 else 0
                        val new_a = if a = "" then "" else String.substring (a, 1, String.size a - 1)
                        val new_b = if b = "" then "" else String.substring (b, 1, String.size b - 1)
                    in subtractor_helper (new_a, new_b, new_borrow) ^ digit end

        fun add (a_bi: string, b_bi: string) : bigint = (* return a+b as a string*)
            let
                val sign_a = positive a_bi
                val sign_b = positive b_bi
                val a = abs a_bi
                val b = abs b_bi
                
            in 
            if sign_a andalso sign_b then bi (remove_leading_zeroes (adder_helper (String.implode(List.rev(String.explode(a))), 
                             String.implode(List.rev(String.explode(b))), 
                             0, "")))
            else if sign_a andalso not sign_b then if greater(a,b) then bi (remove_leading_zeroes( (subtractor_helper (String.implode(List.rev(String.explode(a))), 
                                  String.implode(List.rev(String.explode(b))), 
                                  0))))
                             else neg (bi (remove_leading_zeroes( (subtractor_helper (String.implode(List.rev(String.explode(b))), 
                                  String.implode(List.rev(String.explode(a))), 
                                  0)))))
            else if not sign_a andalso sign_b then if greater(a,b) then neg (bi (remove_leading_zeroes( (subtractor_helper (String.implode(List.rev(String.explode(a))), 
                                  String.implode(List.rev(String.explode(b))), 
                                  0)))))
                             else bi (remove_leading_zeroes( (subtractor_helper (String.implode(List.rev(String.explode(b))), 
                                  String.implode(List.rev(String.explode(a))), 
                                  0))))
            else neg (bi (remove_leading_zeroes (adder_helper (String.implode(List.rev(String.explode(a))), 
                             String.implode(List.rev(String.explode(b))), 
                             0, "")))) end

        fun make (n: int, c: char) : string = 
            let
                fun make_helper (n: int, c: char, result: string) = 
                    if n = 0 then result
                    else make_helper (n-1, c, result ^ String.str c)
            in
                make_helper (n, c, "")
            end

        fun multiply (a_bi: bigint, b_bi: bigint) : bigint  = (* return a*b as a string*)
            let
                val sign_a = positive a_bi
                val sign_b = positive b_bi
                val a = abs a_bi
                val b = abs b_bi
                fun multiplier_helper (a: string, b: string, result: string) =
                    if b = "" then result
                    else let
                        val b_digit = String.substring (b, 0, 1)
                        val new_b = String.substring (b, 1, String.size b - 1)
                        val new_result = st (add (bi(result), bi( multiplier_digit(a, b_digit) ^ make((String.size b - 1), #"0"))))
                    in
                        remove_leading_zeroes( multiplier_helper (a, new_b, new_result))
                    end
            in
                if sign_a = sign_b then (multiplier_helper (a, b, "0")) else "~" ^ (multiplier_helper (a, b, "0"))
            end

        fun subtract (a_bi: bigint, b_bi: bigint): bigint =  add (a_bi, neg b_bi)
        fun divide (p_bi: bigint, q_bi: bigint) = 
            let
                val sign_p = positive p_bi
                val sign_q = positive q_bi
                val final_sign = if sign_p = sign_q then true else false
                val p = abs p_bi
                val q = abs q_bi
                fun div_helper(rem: string, quotient: string, indent : int) =
                    let
                        val current = String.substring (rem, 0, if indent > String.size(rem)then 0 else indent)
                        fun digit_finder (current: string, digit: int) =
                            if digit = 0 then 0
                            else
                            (if greater (current, multiply (q, bi (Int.toString digit))) then digit
                            else digit_finder (current, digit - 1))
                    in 
                        if indent > String.size(rem) then 
                            (remove_leading_zeroes quotient, remove_leading_zeroes rem)
                        else
                            (if greater(current,q) then
                                let
                                    val digit = digit_finder (current, 9)
                                    val subs = subtract (current, multiply (q, bi (Int.toString digit)))
                                    val new_indent = String.size(subs)
                                    val new_rem = subs ^ String.substring (rem, if String.size(rem) = indent then 0 else indent,if String.size(rem) = indent then 0 else String.size rem - indent)
                                    val new_quotient = quotient ^ Int.toString (digit)
                                in
                                    div_helper (new_rem, new_quotient, new_indent + 1)
                                end
                        
                            else div_helper (rem, quotient^"0", indent + 1))
                    end
            in
                if final_sign then  div_helper(p, "0", 1) else (neg (bi (#1 (div_helper(p, "0", 1)))), (bi (#2 (div_helper(p, "0", 1)))))
            end

        fun gcd(a_bi : bigint, b_bi : bigint) =
            let
                val a = abs a_bi
                val b = abs b_bi
                fun gcd_helper (a: string, b: string) =
                    if b = "0" then a
                    else gcd_helper (b, #2 (divide (a, b)))
            in
                gcd_helper (a, b)
            end
        
        fun lcm(a_bi : bigint, b_bi : bigint) =
            let
                val a = abs a_bi
                val b = abs b_bi
            in
                #1 (divide (multiply (a, b), gcd (a, b)))
            end
        
        
        fun compare (a_bi: bigint, b_bi: bigint) = 
            if equal (a_bi, b_bi) then EQUAL
            else if greater (a_bi, b_bi) then GREATER
            else LESS
        
    
    
    end

structure BigIntMap = ListMapFn(struct
            type ord_key = BigInt.bigint
            val compare = BigInt.compare
            end )

functor MakeRational (BigInt : BIGINT) : 
    sig
        type rational
        exception rat_error
        val make_rat: BigInt.bigint * BigInt.bigint -> rational option
        val rat: BigInt.bigint -> rational option
        val reci: BigInt.bigint -> rational option
        val neg: rational -> rational
        val inverse : rational -> rational option
        val equal : rational * rational -> bool (* equality *)
        val add : rational * rational -> rational (* addition *)
        val less : rational * rational -> bool (* less than *)
        val subtract : rational * rational -> rational (* subtraction *)
        val multiply : rational * rational -> rational (* multiplication *)
        val divide : rational * rational -> rational option (* division *)
        val showRat : rational -> string
        val showDecimal : rational -> string
        val toDecimal : rational -> string 
        val fromDecimal : string -> rational
        
end =

struct 
    open BigInt;
    open BigIntMap;

    type rational = BigInt.bigint * BigInt.bigint;
    exception rat_error;

    fun make_rat (n, d) =
        if BigInt.valid(n) andalso BigInt.valid(d) then
            let
                val d_bi = BigInt.abs d
                val n_bi = BigInt.abs n
                val gcd = BigInt.gcd( n_bi, d_bi)
                val sign_n = BigInt.positive n
                val sign_d = BigInt.positive d
                val new_n = #1 (BigInt.divide (n_bi, gcd))
                val new_d = #1 (BigInt.divide (d_bi, gcd))
            in
                if  BigInt.st (BigInt.remove_leading_zeroes d_bi ) = "0" then NONE
                else if sign_n = sign_d then SOME (new_n, new_d)
                else SOME (neg new_n, new_d)
            end
        else NONE
    
    fun make_rational (n, d) =
        if BigInt.valid(n) andalso BigInt.valid(d) then
            let
                val d_bi = BigInt.abs d
                val n_bi = BigInt.abs n
                val gcd = BigInt.gcd(n_bi, d_bi)
                val sign_n = BigInt.positive n
                val sign_d = BigInt.positive d
                val new_n = #1 (BigInt.divide (n_bi, gcd))
                val new_d = #1 (BigInt.divide (d_bi, gcd))
            in
                if  BigInt.st (BigInt.remove_leading_zeroes d_bi ) = "0" then raise rat_error
                else if sign_n = sign_d then (new_n, new_d)
                else (neg new_n, new_d)
            end
        else raise rat_error

    fun rat (n) = 
        if BigInt.valid n then
            make_rat (n, BigInt.bi "1")
        else NONE

    fun reci (n) = 
        if BigInt.valid n then
            if BigInt.st (BigInt.remove_leading_zeroes n) = "0" then NONE
            else make_rat (BigInt.bi "1", n)
        else NONE

    fun neg ((n, d)) =
            if BigInt.positive n then make_rational (BigInt.neg n, d)
            else make_rational (BigInt.abs n, d)
    
    fun inverse ((n, d)) =
            if BigInt.st (BigInt.remove_leading_zeroes d) = "0" then NONE
            else make_rat (d, n)
    
    fun equal ( (n1, d1), (n2, d2) )=
        let 
            val (n1_r, d1_r) = make_rational (n1, d1)
            val (n2_r, d2_r) = make_rational (n2, d2)
        in
            if BigInt.equal (n1_r, n2_r) andalso BigInt.equal (d1_r, d2_r) then true
            else false
        end

    fun add ( (n1, d1), (n2, d2) ) =
        let
            val (n1_r, d1_r) = make_rational (n1, d1)
            val (n2_r, d2_r) = make_rational (n2, d2)
            val lcm = BigInt.lcm (d1_r, d2_r)
            val (n_r, d_r) = make_rational (BigInt.add (BigInt.multiply (n1_r, #1 (BigInt.divide (lcm, d1_r))), BigInt.multiply (n2_r, #1 (BigInt.divide (lcm, d2_r)))), lcm)
        in
            (n_r, d_r)
        end
    
    fun less ( (n1, d1), (n2, d2) ) =
        if BigInt.valid n1 andalso BigInt.valid n2 andalso BigInt.valid d1 andalso BigInt.valid d2 andalso BigInt.st (BigInt.remove_leading_zeroes d1) <> "0" andalso BigInt.st (BigInt.remove_leading_zeroes d2) <> "0" then
            if (BigInt.greater ( BigInt.multiply(n1,d2), BigInt.multiply(n2,d1))) orelse ( BigInt.equal ( BigInt.multiply(n1,d2), BigInt.multiply(n2,d1))) then false
            else true
        else raise rat_error

    fun subtract ( a , b )= add ( a, neg b )
    fun multiply ( (n1, d1), (n2, d2) ) = 
        if BigInt.valid n1 andalso BigInt.valid n2 andalso BigInt.valid d1 andalso BigInt.valid d2 andalso BigInt.st (BigInt.remove_leading_zeroes d1) <> "0" andalso BigInt.st (BigInt.remove_leading_zeroes d2) <> "0" then
            make_rational (BigInt.multiply (n1, n2), BigInt.multiply (d1, d2))
        else raise rat_error
    
    fun divide ( (n1, d1), (n2, d2) ) = 
        if BigInt.valid n1 andalso BigInt.valid n2 andalso BigInt.valid d1 andalso BigInt.valid d2 andalso (BigInt.st (BigInt.remove_leading_zeroes d1)) <> "0" andalso (BigInt.st (BigInt.remove_leading_zeroes d2)) <> "0"  andalso (BigInt.st (BigInt.remove_leading_zeroes n2)) <> "0" then
            make_rat (BigInt.multiply (n1, d2), BigInt.multiply (d1, n2))
        else NONE

    fun showRat ( (n, d) ) =
        let 
            val (n_r, d_r) = make_rational (n, d)
        in
            if BigInt.positive n_r then (BigInt.st n_r )^ "/" ^ (BigInt.st d)
            else "~" ^ (BigInt.st (BigInt.abs n)) ^ "/" ^ (BigInt.st d)
        end

    

    fun findRecurringSequence(numerator: bigint, denominator: bigint) =
        let
            
            val remainderMap = BigIntMap.empty
            fun value (SOME x) = x
                        | value NONE = ~1

            fun helper(rem: bigint, seq: string , remainderMap: int BigIntMap.map ) =
                
                    if BigInt.st( BigInt.remove_leading_zeroes(rem)) = "0" then (seq,"0")
                    else if not ( value(BigIntMap.find(remainderMap, BigInt.st rem)) = ~1 )then
                        let
                            val lastIdx =  (value(BigIntMap.find(remainderMap, BigInt.st rem))) 
                            val recSeq=  String.substring(seq, lastIdx, String.size(seq) - lastIdx) 
                            val nonRecSeq = String.substring(seq, 0, lastIdx)
                        in
                            (nonRecSeq,recSeq)
                        end
                    else
                        let
                            val remainderMap = BigIntMap.insert(remainderMap, BigInt.st rem, String.size(seq))
                            val newRem = BigInt.multiply( rem , BigInt.bi "10")
                            val (ad_seq, fin_rem) = BigInt.divide(newRem, denominator)
                            val newSeq = seq ^ BigInt.st( ad_seq ) 
                            
                        in
                            helper(fin_rem, newSeq, remainderMap)
                        end
                
        in
            helper( numerator , "",  remainderMap)
        end  

    fun showDecimal ( (n, d) ) =
        if BigInt.st (BigInt.remove_leading_zeroes d) <> "0" andalso BigInt.valid n andalso BigInt.valid d then         
            let 
                val n_abs = BigInt.abs n
                val d_abs = BigInt.abs d
                val n_sign = BigInt.positive n
                val d_sign = BigInt.positive d
                val (n_bi, r_bi) = BigInt.divide (n_abs, d_abs)
                val (nonRecSeq, recSeq) = findRecurringSequence(r_bi, d)
            in
                if n_sign = d_sign then (BigInt.st(n_bi)) ^ "." ^ nonRecSeq ^ "(" ^ recSeq ^ ")"
                else "~" ^  (BigInt.st(n_bi)) ^ "." ^ nonRecSeq ^ "(" ^ recSeq ^ ")"
            end
        else raise rat_error

    val toDecimal = showDecimal

    fun make (n: int, c: char) : string = 
            let
                fun make_helper (n: int, c: char, result: string) = 
                    if n = 0 then result
                    else make_helper (n-1, c, result ^ String.str c)
            in
                make_helper (n, c, "")
            end

    fun fromDecimal (a: string) =
        let
            fun valid_helper (a: string, i: int, int : string, nonRecSeq: string, recSeq: string, dec : bool, br_open: bool , br_close: bool ) = 
                if i = String.size a then (if br_open = br_close then (if dec = (String.size(nonRecSeq^recSeq)>0) then (true, int, nonRecSeq, recSeq) else (false, int, nonRecSeq, recSeq)) else (false, int, nonRecSeq, recSeq))  
                else if String.substring (a, i, 1) = "0" orelse String.substring (a, i, 1) = "1" orelse String.substring (a, i, 1) = "2" orelse String.substring (a, i, 1) = "3" orelse String.substring (a, i, 1) = "4" orelse String.substring (a, i, 1) = "5" orelse String.substring (a, i, 1) = "6" orelse String.substring (a, i, 1) = "7" orelse String.substring (a, i, 1) = "8" orelse String.substring (a, i, 1) = "9" then 
                    (if br_close then (false, int, nonRecSeq, recSeq) else if not dec then valid_helper (a, i+1, int ^ String.substring (a, i, 1), nonRecSeq, recSeq, dec, br_open, br_close) else if (not br_open) then valid_helper (a, i+1, int, nonRecSeq ^ String.substring (a, i, 1), recSeq, dec, br_open, br_close) else valid_helper (a, i+1, int, nonRecSeq, recSeq ^ String.substring (a, i, 1), dec, br_open, br_close))
                else if (String.substring (a, i, 1) = ".") then (if dec orelse br_open orelse br_close then (false, int, nonRecSeq, recSeq) else valid_helper (a, i+1, int, nonRecSeq, recSeq, true, br_open, br_close))
                else if String.substring (a, i, 1) = "(" then (if br_open orelse not dec orelse (String.size recSeq) > 0 orelse br_close then (false, int, nonRecSeq, recSeq) else valid_helper (a, i+1, int, nonRecSeq, recSeq, dec, true, br_close))
                else if String.substring (a, i, 1) = ")" then (if not br_open orelse not dec orelse not ((String.size recSeq) > 0) orelse br_close then (false, int, nonRecSeq, recSeq) else valid_helper (a, i+1, int, nonRecSeq, recSeq, dec, br_open, true))
                else (false, int, nonRecSeq, recSeq)

            val sign = if String.substring (a, 0, 1) = "~" then false else true
            val (valid, int, nonRecSeq, recSeq) = (if String.substring (a, 0, 1) = "~" orelse String.substring (a, 0, 1) = "+" then valid_helper (String.substring (a, 1, String.size a - 1), 0, "", "", "", false, false, false)
            else valid_helper (a, 0, "", "", "", false, false, false))
            val integer = if String.size(int) > 0 then make_rational( BigInt.bi int , BigInt.bi"1") else make_rational(BigInt.bi"0", BigInt.bi"1")
            val nonrec_rat = if String.size(nonRecSeq) > 0 then make_rational(BigInt.bi nonRecSeq, BigInt.bi("1" ^ make( String.size(nonRecSeq), #"0") ))  else make_rational(BigInt.bi"0", BigInt.bi"1")
            val rec_rat = if String.size(recSeq) > 0 then make_rational(BigInt.bi recSeq, BigInt.bi (make( String.size(recSeq), #"9" )^ make( String.size(nonRecSeq), #"0" ) )) else make_rational(BigInt.bi"0", BigInt.bi"1")
        in
            if valid then (if sign then (add(add(integer,nonrec_rat),rec_rat)) else neg (add(add(integer,nonrec_rat),rec_rat)))
            else raise rat_error
        end


end; 

structure Rational = MakeRational(BigInt);




