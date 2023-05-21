functor RatPLLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : RatPL_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct



end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\048\000\002\000\047\000\004\000\046\000\008\000\045\000\
\\025\000\044\000\032\000\043\000\033\000\042\000\043\000\041\000\
\\047\000\040\000\050\000\039\000\052\000\038\000\054\000\037\000\000\000\
\\001\000\002\000\112\000\000\000\
\\001\000\003\000\156\000\005\000\156\000\009\000\156\000\010\000\156\000\
\\011\000\156\000\012\000\156\000\013\000\156\000\014\000\156\000\
\\015\000\156\000\016\000\156\000\017\000\156\000\018\000\156\000\
\\019\000\156\000\020\000\156\000\021\000\156\000\022\000\156\000\
\\023\000\156\000\024\000\156\000\026\000\156\000\027\000\156\000\
\\036\000\156\000\040\000\156\000\000\000\
\\001\000\003\000\157\000\005\000\157\000\009\000\157\000\010\000\157\000\
\\011\000\157\000\012\000\157\000\013\000\157\000\014\000\157\000\
\\015\000\157\000\016\000\157\000\017\000\157\000\018\000\157\000\
\\019\000\157\000\020\000\157\000\021\000\157\000\022\000\157\000\
\\023\000\157\000\024\000\157\000\026\000\157\000\027\000\157\000\
\\036\000\157\000\040\000\157\000\000\000\
\\001\000\003\000\158\000\005\000\158\000\009\000\158\000\010\000\158\000\
\\011\000\158\000\012\000\158\000\013\000\158\000\014\000\158\000\
\\015\000\158\000\016\000\158\000\017\000\070\000\018\000\069\000\
\\019\000\158\000\020\000\158\000\021\000\158\000\022\000\158\000\
\\023\000\158\000\024\000\158\000\026\000\158\000\027\000\158\000\
\\036\000\158\000\040\000\158\000\000\000\
\\001\000\003\000\159\000\005\000\159\000\009\000\159\000\010\000\159\000\
\\011\000\159\000\012\000\159\000\013\000\159\000\014\000\159\000\
\\015\000\159\000\016\000\159\000\017\000\070\000\018\000\069\000\
\\019\000\159\000\020\000\159\000\021\000\159\000\022\000\159\000\
\\023\000\159\000\024\000\159\000\026\000\159\000\027\000\159\000\
\\036\000\159\000\040\000\159\000\000\000\
\\001\000\003\000\160\000\005\000\160\000\009\000\160\000\010\000\160\000\
\\011\000\160\000\012\000\160\000\013\000\160\000\014\000\160\000\
\\015\000\160\000\016\000\160\000\017\000\160\000\018\000\160\000\
\\019\000\160\000\020\000\160\000\021\000\160\000\022\000\160\000\
\\023\000\160\000\024\000\160\000\026\000\160\000\027\000\160\000\
\\036\000\160\000\040\000\160\000\000\000\
\\001\000\003\000\161\000\005\000\161\000\009\000\161\000\010\000\161\000\
\\011\000\161\000\012\000\161\000\013\000\161\000\014\000\161\000\
\\015\000\161\000\016\000\161\000\017\000\161\000\018\000\161\000\
\\019\000\161\000\020\000\161\000\021\000\161\000\022\000\161\000\
\\023\000\161\000\024\000\161\000\026\000\161\000\027\000\161\000\
\\036\000\161\000\040\000\161\000\000\000\
\\001\000\003\000\162\000\005\000\162\000\009\000\162\000\010\000\162\000\
\\011\000\162\000\012\000\162\000\013\000\162\000\014\000\162\000\
\\015\000\162\000\016\000\162\000\017\000\162\000\018\000\162\000\
\\019\000\162\000\020\000\162\000\021\000\162\000\022\000\162\000\
\\023\000\162\000\024\000\162\000\026\000\162\000\027\000\162\000\
\\036\000\162\000\040\000\162\000\000\000\
\\001\000\003\000\163\000\005\000\163\000\009\000\163\000\010\000\163\000\
\\011\000\163\000\012\000\163\000\013\000\163\000\014\000\163\000\
\\015\000\163\000\016\000\163\000\017\000\163\000\018\000\163\000\
\\019\000\163\000\020\000\163\000\021\000\163\000\022\000\163\000\
\\023\000\163\000\024\000\163\000\026\000\163\000\027\000\163\000\
\\036\000\163\000\040\000\163\000\000\000\
\\001\000\003\000\164\000\005\000\164\000\009\000\164\000\010\000\164\000\
\\011\000\164\000\012\000\164\000\013\000\164\000\014\000\164\000\
\\015\000\164\000\016\000\164\000\017\000\164\000\018\000\164\000\
\\019\000\164\000\020\000\164\000\021\000\164\000\022\000\164\000\
\\023\000\164\000\024\000\164\000\026\000\164\000\027\000\164\000\
\\036\000\164\000\040\000\164\000\000\000\
\\001\000\003\000\165\000\005\000\165\000\009\000\165\000\010\000\165\000\
\\011\000\165\000\012\000\165\000\013\000\165\000\014\000\165\000\
\\015\000\165\000\016\000\165\000\017\000\165\000\018\000\165\000\
\\019\000\165\000\020\000\165\000\021\000\165\000\022\000\165\000\
\\023\000\165\000\024\000\165\000\026\000\165\000\027\000\165\000\
\\036\000\165\000\040\000\165\000\000\000\
\\001\000\003\000\166\000\005\000\166\000\009\000\166\000\010\000\166\000\
\\011\000\166\000\012\000\166\000\013\000\166\000\014\000\166\000\
\\015\000\166\000\016\000\166\000\017\000\166\000\018\000\166\000\
\\019\000\166\000\020\000\166\000\021\000\166\000\022\000\166\000\
\\023\000\166\000\024\000\166\000\026\000\166\000\027\000\166\000\
\\036\000\166\000\040\000\166\000\000\000\
\\001\000\003\000\167\000\005\000\167\000\009\000\167\000\010\000\167\000\
\\011\000\167\000\012\000\167\000\013\000\167\000\014\000\167\000\
\\015\000\167\000\016\000\167\000\017\000\167\000\018\000\167\000\
\\019\000\167\000\020\000\167\000\021\000\167\000\022\000\167\000\
\\023\000\167\000\024\000\167\000\026\000\167\000\027\000\167\000\
\\036\000\167\000\040\000\167\000\000\000\
\\001\000\003\000\168\000\005\000\168\000\009\000\168\000\010\000\168\000\
\\011\000\168\000\012\000\168\000\013\000\168\000\014\000\168\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\168\000\020\000\168\000\021\000\066\000\022\000\065\000\
\\023\000\168\000\024\000\168\000\026\000\064\000\027\000\168\000\
\\036\000\168\000\040\000\168\000\000\000\
\\001\000\003\000\169\000\005\000\169\000\009\000\169\000\010\000\169\000\
\\011\000\169\000\012\000\169\000\013\000\169\000\014\000\169\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\169\000\020\000\169\000\021\000\066\000\022\000\065\000\
\\023\000\169\000\024\000\169\000\026\000\064\000\027\000\169\000\
\\036\000\169\000\040\000\169\000\000\000\
\\001\000\003\000\170\000\005\000\170\000\009\000\170\000\010\000\170\000\
\\011\000\170\000\012\000\170\000\013\000\170\000\014\000\170\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\170\000\020\000\170\000\021\000\170\000\022\000\170\000\
\\023\000\170\000\024\000\170\000\026\000\170\000\027\000\170\000\
\\036\000\170\000\040\000\170\000\000\000\
\\001\000\003\000\171\000\005\000\171\000\009\000\171\000\010\000\171\000\
\\011\000\171\000\012\000\171\000\013\000\171\000\014\000\171\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\171\000\020\000\171\000\021\000\171\000\022\000\171\000\
\\023\000\171\000\024\000\171\000\026\000\171\000\027\000\171\000\
\\036\000\171\000\040\000\171\000\000\000\
\\001\000\003\000\172\000\005\000\172\000\009\000\172\000\010\000\172\000\
\\011\000\172\000\012\000\172\000\013\000\172\000\014\000\172\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\172\000\020\000\172\000\021\000\172\000\022\000\172\000\
\\023\000\172\000\024\000\172\000\026\000\172\000\027\000\172\000\
\\036\000\172\000\040\000\172\000\000\000\
\\001\000\003\000\173\000\005\000\173\000\009\000\173\000\010\000\173\000\
\\011\000\173\000\012\000\173\000\013\000\173\000\014\000\173\000\
\\015\000\173\000\016\000\173\000\017\000\173\000\018\000\173\000\
\\019\000\173\000\020\000\173\000\021\000\173\000\022\000\173\000\
\\023\000\173\000\024\000\173\000\026\000\173\000\027\000\173\000\
\\036\000\173\000\040\000\173\000\000\000\
\\001\000\003\000\174\000\005\000\174\000\009\000\174\000\010\000\174\000\
\\011\000\174\000\012\000\174\000\013\000\174\000\014\000\174\000\
\\015\000\174\000\016\000\174\000\017\000\174\000\018\000\174\000\
\\019\000\174\000\020\000\174\000\021\000\174\000\022\000\174\000\
\\023\000\174\000\024\000\174\000\026\000\174\000\027\000\174\000\
\\036\000\174\000\040\000\174\000\000\000\
\\001\000\003\000\175\000\005\000\175\000\009\000\175\000\010\000\175\000\
\\011\000\175\000\012\000\175\000\013\000\175\000\014\000\175\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\175\000\024\000\175\000\026\000\064\000\027\000\175\000\
\\036\000\175\000\040\000\175\000\000\000\
\\001\000\003\000\176\000\005\000\176\000\009\000\176\000\010\000\176\000\
\\011\000\176\000\012\000\176\000\013\000\176\000\014\000\176\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\176\000\024\000\176\000\026\000\064\000\027\000\176\000\
\\036\000\176\000\040\000\176\000\000\000\
\\001\000\003\000\177\000\005\000\177\000\009\000\177\000\010\000\177\000\
\\011\000\177\000\012\000\177\000\013\000\177\000\014\000\177\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\177\000\024\000\177\000\026\000\064\000\027\000\177\000\
\\036\000\177\000\040\000\177\000\000\000\
\\001\000\003\000\178\000\005\000\178\000\009\000\178\000\010\000\178\000\
\\011\000\178\000\012\000\178\000\013\000\178\000\014\000\178\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\178\000\024\000\178\000\026\000\064\000\027\000\178\000\
\\036\000\178\000\040\000\178\000\000\000\
\\001\000\003\000\183\000\005\000\183\000\009\000\183\000\010\000\183\000\
\\011\000\183\000\012\000\183\000\013\000\183\000\014\000\183\000\
\\015\000\183\000\016\000\183\000\017\000\183\000\018\000\183\000\
\\019\000\183\000\020\000\183\000\021\000\183\000\022\000\183\000\
\\023\000\183\000\024\000\183\000\026\000\183\000\027\000\183\000\
\\036\000\183\000\040\000\183\000\000\000\
\\001\000\003\000\184\000\005\000\184\000\009\000\184\000\010\000\184\000\
\\011\000\184\000\012\000\184\000\013\000\184\000\014\000\184\000\
\\015\000\184\000\016\000\184\000\017\000\184\000\018\000\184\000\
\\019\000\184\000\020\000\184\000\021\000\184\000\022\000\184\000\
\\023\000\184\000\024\000\184\000\026\000\184\000\027\000\184\000\
\\036\000\184\000\040\000\184\000\000\000\
\\001\000\003\000\079\000\005\000\179\000\009\000\179\000\010\000\179\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\179\000\024\000\179\000\026\000\064\000\027\000\063\000\
\\036\000\179\000\040\000\179\000\000\000\
\\001\000\003\000\079\000\005\000\180\000\009\000\180\000\010\000\180\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\180\000\024\000\180\000\026\000\064\000\027\000\063\000\
\\036\000\180\000\040\000\180\000\000\000\
\\001\000\003\000\079\000\005\000\181\000\009\000\181\000\010\000\181\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\181\000\024\000\181\000\026\000\064\000\027\000\063\000\
\\036\000\181\000\040\000\181\000\000\000\
\\001\000\003\000\079\000\005\000\182\000\009\000\182\000\010\000\077\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\023\000\182\000\024\000\182\000\026\000\064\000\027\000\063\000\
\\036\000\182\000\040\000\182\000\000\000\
\\001\000\003\000\079\000\005\000\093\000\009\000\078\000\010\000\077\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\026\000\064\000\027\000\063\000\000\000\
\\001\000\003\000\079\000\005\000\115\000\009\000\078\000\010\000\077\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\026\000\064\000\027\000\063\000\000\000\
\\001\000\003\000\079\000\005\000\123\000\009\000\078\000\010\000\077\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\026\000\064\000\027\000\063\000\000\000\
\\001\000\003\000\079\000\005\000\128\000\009\000\078\000\010\000\077\000\
\\011\000\076\000\012\000\075\000\013\000\074\000\014\000\073\000\
\\015\000\072\000\016\000\071\000\017\000\070\000\018\000\069\000\
\\019\000\068\000\020\000\067\000\021\000\066\000\022\000\065\000\
\\026\000\064\000\027\000\063\000\000\000\
\\001\000\003\000\079\000\009\000\078\000\010\000\077\000\011\000\076\000\
\\012\000\075\000\013\000\074\000\014\000\073\000\015\000\072\000\
\\016\000\071\000\017\000\070\000\018\000\069\000\019\000\068\000\
\\020\000\067\000\021\000\066\000\022\000\065\000\023\000\091\000\
\\026\000\064\000\027\000\063\000\000\000\
\\001\000\003\000\079\000\009\000\078\000\010\000\077\000\011\000\076\000\
\\012\000\075\000\013\000\074\000\014\000\073\000\015\000\072\000\
\\016\000\071\000\017\000\070\000\018\000\069\000\019\000\068\000\
\\020\000\067\000\021\000\066\000\022\000\065\000\024\000\122\000\
\\026\000\064\000\027\000\063\000\000\000\
\\001\000\003\000\079\000\009\000\078\000\010\000\077\000\011\000\076\000\
\\012\000\075\000\013\000\074\000\014\000\073\000\015\000\072\000\
\\016\000\071\000\017\000\070\000\018\000\069\000\019\000\068\000\
\\020\000\067\000\021\000\066\000\022\000\065\000\026\000\064\000\
\\027\000\063\000\036\000\087\000\000\000\
\\001\000\003\000\079\000\009\000\078\000\010\000\077\000\011\000\076\000\
\\012\000\075\000\013\000\074\000\014\000\073\000\015\000\072\000\
\\016\000\071\000\017\000\070\000\018\000\069\000\019\000\068\000\
\\020\000\067\000\021\000\066\000\022\000\065\000\026\000\064\000\
\\027\000\063\000\040\000\062\000\000\000\
\\001\000\004\000\034\000\000\000\
\\001\000\004\000\035\000\000\000\
\\001\000\004\000\081\000\000\000\
\\001\000\004\000\082\000\000\000\
\\001\000\004\000\083\000\000\000\
\\001\000\005\000\092\000\000\000\
\\001\000\005\000\121\000\000\000\
\\001\000\006\000\134\000\000\000\
\\001\000\006\000\135\000\030\000\135\000\031\000\135\000\042\000\135\000\000\000\
\\001\000\006\000\136\000\029\000\006\000\030\000\136\000\031\000\136\000\
\\042\000\136\000\000\000\
\\001\000\006\000\137\000\031\000\137\000\042\000\137\000\000\000\
\\001\000\006\000\138\000\030\000\008\000\031\000\138\000\042\000\138\000\000\000\
\\001\000\006\000\139\000\042\000\139\000\000\000\
\\001\000\006\000\140\000\031\000\013\000\042\000\140\000\000\000\
\\001\000\006\000\143\000\000\000\
\\001\000\006\000\144\000\042\000\027\000\000\000\
\\001\000\006\000\145\000\042\000\145\000\000\000\
\\001\000\006\000\010\000\000\000\
\\001\000\007\000\148\000\000\000\
\\001\000\007\000\149\000\035\000\021\000\039\000\020\000\044\000\019\000\
\\045\000\018\000\046\000\017\000\054\000\016\000\000\000\
\\001\000\007\000\150\000\035\000\150\000\039\000\150\000\044\000\150\000\
\\045\000\150\000\046\000\150\000\054\000\150\000\000\000\
\\001\000\007\000\151\000\035\000\151\000\039\000\151\000\044\000\151\000\
\\045\000\151\000\046\000\151\000\054\000\151\000\000\000\
\\001\000\007\000\152\000\035\000\152\000\039\000\152\000\044\000\152\000\
\\045\000\152\000\046\000\152\000\054\000\152\000\000\000\
\\001\000\007\000\153\000\035\000\153\000\039\000\153\000\044\000\153\000\
\\045\000\153\000\046\000\153\000\054\000\153\000\000\000\
\\001\000\007\000\154\000\035\000\154\000\039\000\154\000\044\000\154\000\
\\045\000\154\000\046\000\154\000\054\000\154\000\000\000\
\\001\000\007\000\155\000\035\000\155\000\039\000\155\000\044\000\155\000\
\\045\000\155\000\046\000\155\000\054\000\155\000\000\000\
\\001\000\007\000\022\000\035\000\021\000\039\000\020\000\044\000\019\000\
\\045\000\018\000\046\000\017\000\054\000\016\000\000\000\
\\001\000\007\000\057\000\000\000\
\\001\000\023\000\133\000\053\000\133\000\000\000\
\\001\000\023\000\141\000\000\000\
\\001\000\023\000\142\000\024\000\024\000\000\000\
\\001\000\023\000\146\000\037\000\146\000\038\000\146\000\041\000\146\000\
\\053\000\146\000\000\000\
\\001\000\023\000\147\000\037\000\147\000\038\000\147\000\041\000\147\000\
\\053\000\147\000\000\000\
\\001\000\023\000\050\000\000\000\
\\001\000\023\000\055\000\000\000\
\\001\000\023\000\059\000\000\000\
\\001\000\023\000\090\000\000\000\
\\001\000\023\000\117\000\000\000\
\\001\000\023\000\118\000\000\000\
\\001\000\023\000\119\000\000\000\
\\001\000\023\000\125\000\000\000\
\\001\000\023\000\130\000\000\000\
\\001\000\028\000\032\000\000\000\
\\001\000\037\000\124\000\000\000\
\\001\000\038\000\129\000\000\000\
\\001\000\041\000\120\000\000\000\
\\001\000\053\000\000\000\000\000\
\\001\000\053\000\132\000\000\000\
\\001\000\054\000\011\000\000\000\
\\001\000\054\000\014\000\000\000\
\\001\000\054\000\028\000\000\000\
\\001\000\054\000\033\000\000\000\
\\001\000\054\000\051\000\000\000\
\\001\000\054\000\053\000\000\000\
\\001\000\054\000\060\000\000\000\
\"
val actionRowNumbers =
"\048\000\050\000\056\000\086\000\
\\087\000\052\000\088\000\067\000\
\\065\000\069\000\054\000\089\000\
\\069\000\058\000\081\000\090\000\
\\039\000\040\000\000\000\000\000\
\\071\000\072\000\091\000\046\000\
\\054\000\092\000\069\000\073\000\
\\058\000\066\000\000\000\074\000\
\\093\000\000\000\038\000\003\000\
\\000\000\041\000\042\000\043\000\
\\020\000\019\000\000\000\000\000\
\\000\000\002\000\013\000\037\000\
\\047\000\069\000\053\000\048\000\
\\075\000\049\000\057\000\070\000\
\\035\000\060\000\044\000\031\000\
\\056\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\
\\000\000\000\000\008\000\001\000\
\\000\000\000\000\012\000\025\000\
\\032\000\056\000\068\000\076\000\
\\051\000\059\000\077\000\078\000\
\\084\000\028\000\018\000\017\000\
\\016\000\015\000\014\000\007\000\
\\006\000\005\000\004\000\022\000\
\\024\000\021\000\023\000\029\000\
\\030\000\027\000\045\000\036\000\
\\033\000\026\000\082\000\055\000\
\\061\000\062\000\079\000\010\000\
\\000\000\011\000\056\000\064\000\
\\034\000\083\000\009\000\080\000\
\\063\000\085\000"
val gotoT =
"\
\\001\000\129\000\002\000\003\000\003\000\002\000\004\000\001\000\000\000\
\\005\000\005\000\000\000\
\\009\000\007\000\000\000\
\\000\000\
\\000\000\
\\006\000\010\000\000\000\
\\000\000\
\\000\000\
\\011\000\013\000\000\000\
\\019\000\021\000\000\000\
\\007\000\024\000\008\000\023\000\000\000\
\\000\000\
\\019\000\027\000\000\000\
\\010\000\029\000\011\000\028\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\016\000\034\000\000\000\
\\016\000\047\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\007\000\024\000\008\000\050\000\000\000\
\\000\000\
\\019\000\052\000\000\000\
\\000\000\
\\010\000\054\000\011\000\028\000\000\000\
\\000\000\
\\016\000\056\000\000\000\
\\000\000\
\\000\000\
\\016\000\059\000\000\000\
\\000\000\
\\000\000\
\\016\000\078\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\016\000\082\000\000\000\
\\016\000\083\000\000\000\
\\016\000\084\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\019\000\086\000\000\000\
\\000\000\
\\002\000\087\000\003\000\002\000\004\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\092\000\000\000\
\\016\000\093\000\000\000\
\\016\000\094\000\000\000\
\\016\000\095\000\000\000\
\\016\000\096\000\000\000\
\\016\000\097\000\000\000\
\\016\000\098\000\000\000\
\\016\000\099\000\000\000\
\\016\000\100\000\000\000\
\\016\000\101\000\000\000\
\\016\000\102\000\000\000\
\\016\000\103\000\000\000\
\\016\000\104\000\000\000\
\\016\000\105\000\000\000\
\\016\000\106\000\000\000\
\\016\000\107\000\000\000\
\\016\000\108\000\000\000\
\\016\000\109\000\000\000\
\\000\000\
\\000\000\
\\016\000\111\000\000\000\
\\016\000\112\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\114\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\016\000\124\000\000\000\
\\000\000\
\\009\000\125\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 130
val numrules = 53
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = string
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | IDENT of unit ->  (Datatypes.Ident)
 | RATNUM of unit ->  (Rational.rational)
 | CONST of unit ->  (BigInt.bigint)
 | Identlist of unit ->  (Datatypes.Ident list)
 | WhileCmd of unit ->  (Datatypes.Expression*Datatypes.CommandSeq)
 | ConditionalCmd of unit ->  (Datatypes.Expression*Datatypes.CommandSeq*Datatypes.CommandSeq)
 | Expression of unit ->  (Datatypes.Expression)
 | PrintCmd of unit ->  (Datatypes.Expression)
 | ReadCmd of unit ->  (Datatypes.Ident)
 | CallCmd of unit ->  (Datatypes.Ident)
 | AssignmentCmd of unit ->  (Datatypes.Ident*Datatypes.Expression)
 | Command of unit ->  (Datatypes.Command)
 | Commandlist of unit ->  (Datatypes.Command list)
 | CommandSeq of unit ->  (Datatypes.Command list)
 | ProcDecls of unit ->  (Datatypes.ProcDef list)
 | ProcDef of unit ->  (Datatypes.ProcDef)
 | BoolVarDecls of unit ->  (Datatypes.BoolVarDecls)
 | IntVarDecls of unit ->  (Datatypes.IntVarDecls)
 | RatVarDecls of unit ->  (Datatypes.RatVarDecls)
 | DeclarationSeq of unit ->  (Datatypes.DeclarationSeq)
 | Block of unit ->  (Datatypes.Block)
 | Program of unit ->  (Datatypes.Block)
end
type svalue = MlyValue.svalue
type result = Datatypes.Block
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 52) => true | _ => false
val showTerminal =
fn (T 0) => "CONST"
  | (T 1) => "RATNUM"
  | (T 2) => "EQUALS"
  | (T 3) => "LPAR"
  | (T 4) => "RPAR"
  | (T 5) => "LBRACE"
  | (T 6) => "RBRACE"
  | (T 7) => "NOT"
  | (T 8) => "OR"
  | (T 9) => "AND"
  | (T 10) => "LE"
  | (T 11) => "LT"
  | (T 12) => "GE"
  | (T 13) => "GT"
  | (T 14) => "RATPLUS"
  | (T 15) => "RATMINUS"
  | (T 16) => "RATTIMES"
  | (T 17) => "RATDIV"
  | (T 18) => "INTPLUS"
  | (T 19) => "INTMINUS"
  | (T 20) => "INTTIMES"
  | (T 21) => "INTDIV"
  | (T 22) => "SEMI"
  | (T 23) => "COMMA"
  | (T 24) => "NEG"
  | (T 25) => "MOD"
  | (T 26) => "NE"
  | (T 27) => "ASSIGN"
  | (T 28) => "RATIONAL"
  | (T 29) => "INTEGER"
  | (T 30) => "BOOLEAN"
  | (T 31) => "TRUE"
  | (T 32) => "FALSE"
  | (T 33) => "VAR"
  | (T 34) => "IF"
  | (T 35) => "THEN"
  | (T 36) => "ELSE"
  | (T 37) => "FI"
  | (T 38) => "WHILE"
  | (T 39) => "DO"
  | (T 40) => "OD"
  | (T 41) => "PROCEDURE"
  | (T 42) => "RAT_UN"
  | (T 43) => "PRINT"
  | (T 44) => "READ"
  | (T 45) => "CALL"
  | (T 46) => "MAKERAT"
  | (T 47) => "SHOWRAT"
  | (T 48) => "SHOWDECIMAL"
  | (T 49) => "FROMDECIMAL"
  | (T 50) => "TODECIMAL"
  | (T 51) => "INVERSE"
  | (T 52) => "EOF"
  | (T 53) => "IDENT"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 52) $$ (T 51) $$ (T 50) $$ (T 49) $$ (T 48) $$ (T 47) $$ (T 46)
 $$ (T 45) $$ (T 44) $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39)
 $$ (T 38) $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32)
 $$ (T 31) $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25)
 $$ (T 24) $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18)
 $$ (T 17) $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11)
 $$ (T 10) $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ 
(T 3) $$ (T 2)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (filename):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.Block Block1, Block1left, Block1right)) :: 
rest671)) => let val  result = MlyValue.Program (fn _ => let val  (
Block as Block1) = Block1 ()
 in (Block)
end)
 in ( LrTable.NT 0, ( result, Block1left, Block1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.CommandSeq CommandSeq1, _, CommandSeq1right)
) :: ( _, ( MlyValue.DeclarationSeq DeclarationSeq1, 
DeclarationSeq1left, _)) :: rest671)) => let val  result = 
MlyValue.Block (fn _ => let val  (DeclarationSeq as DeclarationSeq1) =
 DeclarationSeq1 ()
 val  (CommandSeq as CommandSeq1) = CommandSeq1 ()
 in (Datatypes.Block(DeclarationSeq, Datatypes.CommandSeq(CommandSeq))
)
end)
 in ( LrTable.NT 1, ( result, DeclarationSeq1left, CommandSeq1right), 
rest671)
end
|  ( 2, ( ( _, ( MlyValue.ProcDecls ProcDecls1, _, ProcDecls1right))
 :: ( _, ( MlyValue.BoolVarDecls BoolVarDecls1, _, _)) :: ( _, ( 
MlyValue.IntVarDecls IntVarDecls1, _, _)) :: ( _, ( 
MlyValue.RatVarDecls RatVarDecls1, RatVarDecls1left, _)) :: rest671))
 => let val  result = MlyValue.DeclarationSeq (fn _ => let val  (
RatVarDecls as RatVarDecls1) = RatVarDecls1 ()
 val  (IntVarDecls as IntVarDecls1) = IntVarDecls1 ()
 val  (BoolVarDecls as BoolVarDecls1) = BoolVarDecls1 ()
 val  (ProcDecls as ProcDecls1) = ProcDecls1 ()
 in (
Datatypes.DeclarationSeq(RatVarDecls, IntVarDecls, BoolVarDecls, Datatypes.ProcDecls(ProcDecls) )
)
end)
 in ( LrTable.NT 2, ( result, RatVarDecls1left, ProcDecls1right), 
rest671)
end
|  ( 3, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.Identlist 
Identlist1, _, _)) :: ( _, ( MlyValue.IDENT IDENT1, _, _)) :: ( _, ( _
, RATIONAL1left, _)) :: rest671)) => let val  result = 
MlyValue.RatVarDecls (fn _ => let val  (IDENT as IDENT1) = IDENT1 ()
 val  (Identlist as Identlist1) = Identlist1 ()
 in (Datatypes.RatVarDecls( IDENT :: Identlist))
end)
 in ( LrTable.NT 3, ( result, RATIONAL1left, SEMI1right), rest671)
end
|  ( 4, ( rest671)) => let val  result = MlyValue.RatVarDecls (fn _ =>
 (Datatypes.RatVarDecls([])))
 in ( LrTable.NT 3, ( result, defaultPos, defaultPos), rest671)
end
|  ( 5, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.Identlist 
Identlist1, _, _)) :: ( _, ( MlyValue.IDENT IDENT1, _, _)) :: ( _, ( _
, INTEGER1left, _)) :: rest671)) => let val  result = 
MlyValue.IntVarDecls (fn _ => let val  (IDENT as IDENT1) = IDENT1 ()
 val  (Identlist as Identlist1) = Identlist1 ()
 in (Datatypes.IntVarDecls( IDENT :: Identlist))
end)
 in ( LrTable.NT 4, ( result, INTEGER1left, SEMI1right), rest671)
end
|  ( 6, ( rest671)) => let val  result = MlyValue.IntVarDecls (fn _ =>
 (Datatypes.IntVarDecls([])))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 7, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.Identlist 
Identlist1, _, _)) :: ( _, ( MlyValue.IDENT IDENT1, _, _)) :: ( _, ( _
, BOOLEAN1left, _)) :: rest671)) => let val  result = 
MlyValue.BoolVarDecls (fn _ => let val  (IDENT as IDENT1) = IDENT1 ()
 val  (Identlist as Identlist1) = Identlist1 ()
 in (Datatypes.BoolVarDecls( IDENT :: Identlist))
end)
 in ( LrTable.NT 5, ( result, BOOLEAN1left, SEMI1right), rest671)
end
|  ( 8, ( rest671)) => let val  result = MlyValue.BoolVarDecls (fn _
 => (Datatypes.BoolVarDecls([])))
 in ( LrTable.NT 5, ( result, defaultPos, defaultPos), rest671)
end
|  ( 9, ( ( _, ( MlyValue.Identlist Identlist1, _, Identlist1right))
 :: ( _, ( MlyValue.IDENT IDENT1, _, _)) :: ( _, ( _, COMMA1left, _))
 :: rest671)) => let val  result = MlyValue.Identlist (fn _ => let
 val  (IDENT as IDENT1) = IDENT1 ()
 val  (Identlist as Identlist1) = Identlist1 ()
 in (IDENT :: Identlist)
end)
 in ( LrTable.NT 18, ( result, COMMA1left, Identlist1right), rest671)

end
|  ( 10, ( rest671)) => let val  result = MlyValue.Identlist (fn _ =>
 ([]))
 in ( LrTable.NT 18, ( result, defaultPos, defaultPos), rest671)
end
|  ( 11, ( ( _, ( MlyValue.ProcDecls ProcDecls1, _, ProcDecls1right))
 :: ( _, ( MlyValue.ProcDef ProcDef1, ProcDef1left, _)) :: rest671))
 => let val  result = MlyValue.ProcDecls (fn _ => let val  (ProcDef
 as ProcDef1) = ProcDef1 ()
 val  (ProcDecls as ProcDecls1) = ProcDecls1 ()
 in (ProcDef :: ProcDecls)
end)
 in ( LrTable.NT 7, ( result, ProcDef1left, ProcDecls1right), rest671)

end
|  ( 12, ( rest671)) => let val  result = MlyValue.ProcDecls (fn _ =>
 ([]))
 in ( LrTable.NT 7, ( result, defaultPos, defaultPos), rest671)
end
|  ( 13, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.Block Block1,
 _, _)) :: ( _, ( MlyValue.IDENT IDENT1, _, _)) :: ( _, ( _, 
PROCEDURE1left, _)) :: rest671)) => let val  result = MlyValue.ProcDef
 (fn _ => let val  (IDENT as IDENT1) = IDENT1 ()
 val  (Block as Block1) = Block1 ()
 in (Datatypes.ProcDef(IDENT, Block))
end)
 in ( LrTable.NT 6, ( result, PROCEDURE1left, SEMI1right), rest671)

end
|  ( 14, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.Commandlist 
Commandlist1, _, _)) :: ( _, ( MlyValue.Command Command1, _, _)) :: (
 _, ( _, LBRACE1left, _)) :: rest671)) => let val  result = 
MlyValue.CommandSeq (fn _ => let val  (Command as Command1) = Command1
 ()
 val  (Commandlist as Commandlist1) = Commandlist1 ()
 in (Command :: Commandlist)
end)
 in ( LrTable.NT 8, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 15, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( _, LBRACE1left, _))
 :: rest671)) => let val  result = MlyValue.CommandSeq (fn _ => ([]))
 in ( LrTable.NT 8, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.Commandlist Commandlist1, _, 
Commandlist1right)) :: ( _, ( MlyValue.Command Command1, Command1left,
 _)) :: rest671)) => let val  result = MlyValue.Commandlist (fn _ =>
 let val  (Command as Command1) = Command1 ()
 val  (Commandlist as Commandlist1) = Commandlist1 ()
 in (Command :: Commandlist)
end)
 in ( LrTable.NT 9, ( result, Command1left, Commandlist1right), 
rest671)
end
|  ( 17, ( rest671)) => let val  result = MlyValue.Commandlist (fn _
 => ([]))
 in ( LrTable.NT 9, ( result, defaultPos, defaultPos), rest671)
end
|  ( 18, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.Expression 
Expression1, _, _)) :: _ :: ( _, ( MlyValue.IDENT IDENT1, IDENT1left,
 _)) :: rest671)) => let val  result = MlyValue.Command (fn _ => let
 val  (IDENT as IDENT1) = IDENT1 ()
 val  (Expression as Expression1) = Expression1 ()
 in (Datatypes.AssignmentCmd(IDENT, Expression))
end)
 in ( LrTable.NT 10, ( result, IDENT1left, SEMI1right), rest671)
end
|  ( 19, ( ( _, ( _, _, SEMI1right)) :: ( _, ( MlyValue.IDENT IDENT1,
 _, _)) :: ( _, ( _, CALL1left, _)) :: rest671)) => let val  result = 
MlyValue.Command (fn _ => let val  (IDENT as IDENT1) = IDENT1 ()
 in (Datatypes.CallCmd(IDENT))
end)
 in ( LrTable.NT 10, ( result, CALL1left, SEMI1right), rest671)
end
|  ( 20, ( ( _, ( _, _, SEMI1right)) :: _ :: ( _, ( MlyValue.IDENT 
IDENT1, _, _)) :: _ :: ( _, ( _, READ1left, _)) :: rest671)) => let
 val  result = MlyValue.Command (fn _ => let val  (IDENT as IDENT1) = 
IDENT1 ()
 in (Datatypes.ReadCmd(IDENT))
end)
 in ( LrTable.NT 10, ( result, READ1left, SEMI1right), rest671)
end
|  ( 21, ( ( _, ( _, _, SEMI1right)) :: _ :: ( _, ( 
MlyValue.Expression Expression1, _, _)) :: _ :: ( _, ( _, PRINT1left,
 _)) :: rest671)) => let val  result = MlyValue.Command (fn _ => let
 val  (Expression as Expression1) = Expression1 ()
 in (Datatypes.PrintCmd(Expression))
end)
 in ( LrTable.NT 10, ( result, PRINT1left, SEMI1right), rest671)
end
|  ( 22, ( ( _, ( _, _, SEMI1right)) :: _ :: ( _, ( 
MlyValue.CommandSeq CommandSeq2, _, _)) :: _ :: ( _, ( 
MlyValue.CommandSeq CommandSeq1, _, _)) :: _ :: ( _, ( 
MlyValue.Expression Expression1, _, _)) :: ( _, ( _, IF1left, _)) :: 
rest671)) => let val  result = MlyValue.Command (fn _ => let val  (
Expression as Expression1) = Expression1 ()
 val  (CommandSeq as CommandSeq1) = CommandSeq1 ()
 val  CommandSeq2 = CommandSeq2 ()
 in (
Datatypes.ConditionalCmd (Expression, Datatypes.CommandSeq(CommandSeq1), Datatypes.CommandSeq(CommandSeq2))
)
end)
 in ( LrTable.NT 10, ( result, IF1left, SEMI1right), rest671)
end
|  ( 23, ( ( _, ( _, _, SEMI1right)) :: _ :: ( _, ( 
MlyValue.CommandSeq CommandSeq1, _, _)) :: _ :: ( _, ( 
MlyValue.Expression Expression1, _, _)) :: ( _, ( _, WHILE1left, _))
 :: rest671)) => let val  result = MlyValue.Command (fn _ => let val 
 (Expression as Expression1) = Expression1 ()
 val  (CommandSeq as CommandSeq1) = CommandSeq1 ()
 in (Datatypes.WhileCmd(Expression, Datatypes.CommandSeq(CommandSeq)))

end)
 in ( LrTable.NT 10, ( result, WHILE1left, SEMI1right), rest671)
end
|  ( 24, ( ( _, ( MlyValue.RATNUM RATNUM1, RATNUM1left, RATNUM1right))
 :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  (RATNUM as RATNUM1) = RATNUM1 ()
 in (Datatypes.RationalLiteral(RATNUM))
end)
 in ( LrTable.NT 15, ( result, RATNUM1left, RATNUM1right), rest671)

end
|  ( 25, ( ( _, ( MlyValue.IDENT IDENT1, IDENT1left, IDENT1right)) :: 
rest671)) => let val  result = MlyValue.Expression (fn _ => let val  (
IDENT as IDENT1) = IDENT1 ()
 in (Datatypes.Ident(IDENT))
end)
 in ( LrTable.NT 15, ( result, IDENT1left, IDENT1right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.RatAdd(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 27, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.RatSub(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 28, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.RatMul(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 29, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.RatDiv(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 30, ( ( _, ( MlyValue.Expression Expression1, _, Expression1right
)) :: ( _, ( _, INVERSE1left, _)) :: rest671)) => let val  result = 
MlyValue.Expression (fn _ => let val  (Expression as Expression1) = 
Expression1 ()
 in (Datatypes.InverseExpression(Expression))
end)
 in ( LrTable.NT 15, ( result, INVERSE1left, Expression1right), 
rest671)
end
|  ( 31, ( ( _, ( _, _, RPAR1right)) :: ( _, ( MlyValue.Expression 
Expression2, _, _)) :: _ :: ( _, ( MlyValue.Expression Expression1, _,
 _)) :: _ :: ( _, ( _, MAKERAT1left, _)) :: rest671)) => let val  
result = MlyValue.Expression (fn _ => let val  Expression1 = 
Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.MakeRat(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, MAKERAT1left, RPAR1right), rest671)
end
|  ( 32, ( ( _, ( _, _, RPAR1right)) :: ( _, ( MlyValue.RATNUM RATNUM1
, _, _)) :: _ :: ( _, ( _, FROMDECIMAL1left, _)) :: rest671)) => let
 val  result = MlyValue.Expression (fn _ => let val  (RATNUM as 
RATNUM1) = RATNUM1 ()
 in (Datatypes.RationalLiteral(RATNUM))
end)
 in ( LrTable.NT 15, ( result, FROMDECIMAL1left, RPAR1right), rest671)

end
|  ( 33, ( ( _, ( _, _, RPAR1right)) :: ( _, ( MlyValue.Expression 
Expression1, _, _)) :: _ :: ( _, ( _, RAT_UN1left, _)) :: rest671)) =>
 let val  result = MlyValue.Expression (fn _ => let val  (Expression
 as Expression1) = Expression1 ()
 in (Datatypes.RatUn(Expression))
end)
 in ( LrTable.NT 15, ( result, RAT_UN1left, RPAR1right), rest671)
end
|  ( 34, ( ( _, ( MlyValue.Expression Expression1, _, Expression1right
)) :: ( _, ( _, NEG1left, _)) :: rest671)) => let val  result = 
MlyValue.Expression (fn _ => let val  (Expression as Expression1) = 
Expression1 ()
 in (Datatypes.Neg(Expression))
end)
 in ( LrTable.NT 15, ( result, NEG1left, Expression1right), rest671)

end
|  ( 35, ( ( _, ( MlyValue.CONST CONST1, CONST1left, CONST1right)) :: 
rest671)) => let val  result = MlyValue.Expression (fn _ => let val  (
CONST as CONST1) = CONST1 ()
 in (Datatypes.IntegerLiteral(CONST))
end)
 in ( LrTable.NT 15, ( result, CONST1left, CONST1right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.IntAdd(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 37, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.IntSub(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 38, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.IntMul(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 39, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.IntDiv(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 40, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.IntMod(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 41, ( ( _, ( _, TRUE1left, TRUE1right)) :: rest671)) => let val  
result = MlyValue.Expression (fn _ => (Datatypes.BooleanLiteral(true))
)
 in ( LrTable.NT 15, ( result, TRUE1left, TRUE1right), rest671)
end
|  ( 42, ( ( _, ( _, FALSE1left, FALSE1right)) :: rest671)) => let
 val  result = MlyValue.Expression (fn _ => (
Datatypes.BooleanLiteral(false)))
 in ( LrTable.NT 15, ( result, FALSE1left, FALSE1right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.LessThan(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 44, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.GreaterThan(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 45, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.LessThanOrEqual(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 46, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.GreaterThanOrEqual (Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 47, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.Equal(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 48, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.NotEqual(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 49, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.And(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 50, ( ( _, ( MlyValue.Expression Expression2, _, Expression2right
)) :: _ :: ( _, ( MlyValue.Expression Expression1, Expression1left, _)
) :: rest671)) => let val  result = MlyValue.Expression (fn _ => let
 val  Expression1 = Expression1 ()
 val  Expression2 = Expression2 ()
 in (Datatypes.Or(Expression1, Expression2))
end)
 in ( LrTable.NT 15, ( result, Expression1left, Expression2right), 
rest671)
end
|  ( 51, ( ( _, ( MlyValue.Expression Expression1, _, Expression1right
)) :: ( _, ( _, NOT1left, _)) :: rest671)) => let val  result = 
MlyValue.Expression (fn _ => let val  (Expression as Expression1) = 
Expression1 ()
 in (Datatypes.Not(Expression))
end)
 in ( LrTable.NT 15, ( result, NOT1left, Expression1right), rest671)

end
|  ( 52, ( ( _, ( _, _, RPAR1right)) :: ( _, ( MlyValue.Expression 
Expression1, _, _)) :: ( _, ( _, LPAR1left, _)) :: rest671)) => let
 val  result = MlyValue.Expression (fn _ => let val  (Expression as 
Expression1) = Expression1 ()
 in (Expression)
end)
 in ( LrTable.NT 15, ( result, LPAR1left, RPAR1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.Program x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : RatPL_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun CONST (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.CONST (fn () => i),p1,p2))
fun RATNUM (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.RATNUM (fn () => i),p1,p2))
fun EQUALS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun NOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun RATPLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun RATMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun RATTIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun RATDIV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun INTPLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun INTMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun INTTIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun INTDIV (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMI (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun NEG (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun MOD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun NE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun RATIONAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun INTEGER (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun BOOLEAN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun TRUE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun FALSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun FI (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun OD (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun PROCEDURE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun RAT_UN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun PRINT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun READ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
fun CALL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 45,(
ParserData.MlyValue.VOID,p1,p2))
fun MAKERAT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 46,(
ParserData.MlyValue.VOID,p1,p2))
fun SHOWRAT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 47,(
ParserData.MlyValue.VOID,p1,p2))
fun SHOWDECIMAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 48,(
ParserData.MlyValue.VOID,p1,p2))
fun FROMDECIMAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 49,(
ParserData.MlyValue.VOID,p1,p2))
fun TODECIMAL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 50,(
ParserData.MlyValue.VOID,p1,p2))
fun INVERSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 51,(
ParserData.MlyValue.VOID,p1,p2))
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 52,(
ParserData.MlyValue.VOID,p1,p2))
fun IDENT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 53,(
ParserData.MlyValue.IDENT (fn () => i),p1,p2))
end
end
