%{
#include <stdio.h>
#include "parser.hpp"
%}

%option noyywrap

%%
0x[0-9]+    yylval=atoi(yytext); return HEX_NUMBER;
[0-9]+      yylval=atoi(yytext); return DEC_NUMBER;

SET|set     return OPCODE_SET;
ADD|add     return OPCODE_ADD;
SUB|sub     return OPCODE_SUB;

;           return COMMENT_START;
\.          return DIRECTIVE_START;

\[          return SQUARE_OPEN;
\]          return SQUARE_CLOSE;
,           return COMMA;
[ \t]+      /* ignore whitespace */;

\*           return MUL;
\+           return ADD;
\-           return SUB;
\/           return DIV;

A|a         return A;
B|b         return B;
C|c         return C;
X|x         return X;
Y|y         return Y;
Z|z         return Z;
I|i         return I;
J|j         return J;

PC|pc       return PC;
SP|sp       return SP;
EX|ex       return EX;
IA|ia       return IA;

%%

/*.*          return ANYTHING;*/
/*\n                      * ignore end of line *e/;*/