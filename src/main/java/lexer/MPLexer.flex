import java_cup.runtime.Symbol;
import Parser.*;import parser.sym;

%%


%class MPLexer
%function next_token
%line
%column
%debug
%type Symbol
%eofval{
return new Symbol(sym.EOF);
%eofval}

%{
   public int getLine()
   {
      return yyline+1;
   }
%}


//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]
oc16 = [0-9A-F]
%%


\/\/ { yybegin( COMMENT ); }
<COMMENT>~\n { yybegin( YYINITIAL ); }


[\t\n\r] { ; }
\( { return new Symbol( sym.OZ ); }
\) { return new Symbol( sym.ZZ ); }
\{ { return new Symbol( sym.OV ); }
\} { return new Symbol( sym.ZV ); }
\< { return new Symbol( sym.MZ ); }
\> { return new Symbol( sym.VZ ); }
//operators
\+ { return new Symbol( sym.PLUS); }
\* { return new Symbol( sym.MULTIPLICATION); }
\- { return new Symbol( sym.MINUS); }
\/  { return new Symbol( sym.DIVISION); }
== { return new Symbol( sym.EQUALS); }

//separators
= { return new Symbol( sym.ASSIGN ); }
, {return new Symbol( sym.COMMA ); }
open {return new Symbol(sym.OPEN);}
close {return new Symbol(sym.CLOSE);}

//key words
main {return new Symbol(sym.PROGRAM);}
int {return new Symbol(sym.INT); }
string {return new Symbol(sym.STRING); }
while {return new Symbol(sym.WHILE); }
if {return new Symbol(sym.IF); }
then {return new Symbol(sym.THEN); }
true {return new Symbol(sym.CONST); }
false {return new Symbol(sym.CONST); }
BEGIN {return new Symbol(sym.begin); }
ELSE {return new Symbol(sym.ELSE);}
END {return new Symbol(sym.end); }


{slovo}+ { return new Symbol(sym.ID); }
//id-s
({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.ID); }
//constants
{cifra}+ { return new Symbol( sym.CONST ); }
\${oc16}+ { return new Symbol( sym.CONST ); }
0\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym.CONST);}
'[^]' { return new Symbol( sym.CONST); }

//error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
/*
1. Program -> main (  ) < DeclarationBlock > Block > end
2. DeclarationBlock -> begin Declarations
3. Declarations -> Declarations, Declaration | Declaration
4. Declaration -> Type Name
5. Name -> ID
6. Type -> number | string
7. Block -> Open Instructions Close
8. Instructions -> Open Instructions Close  Open Instruction Close | Instruction
9. Instruction -> Assignment | Block | If | While
10.Assignment -> ID = Function
11.Function -> Function + Function | Function - Const | Function + Const | Function / Const
13.Const -> ID | CONST
14.If -> ? Function Open Instructions Close : Open Instructions Close
15.While -> while Function Open Instructions Clone
*/