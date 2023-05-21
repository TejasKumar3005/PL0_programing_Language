structure RatPLLrVals = RatPLLrValsFun(
        structure Token = LrParser.Token);

structure RatPLLex = RatPLLexFun(
        structure Tokens = RatPLLrVals.Tokens);
        
structure RatPLParser = JoinWithArg(
        structure ParserData = RatPLLrVals.ParserData
        structure Lex=RatPLLex
        structure LrParser=LrParser);