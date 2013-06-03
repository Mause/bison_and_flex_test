%{
#include <stdio.h>
#include "parser.hpp"
%}

%option noyywrap

%%
[Ss][Ee][Tt]     return OPCODE_SET;
[Aa][Dd]{2}      return OPCODE_ADD;
[Ss][Uu][Bb]     return OPCODE_SUB;

:           return LABEL_START;
;           return COMMENT_START;
\.          return DIRECTIVE_START;

\[          return SQUARE_OPEN;
\]          return SQUARE_CLOSE;
,           return COMMA;
[ \t]+      /* ignore whitespace */;

\*          return MUL;
\+          return ADD;
\-          return SUB;
\/          return DIV;

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

0x[0-9]+                        yylval.number=atoi(yytext); return HEX_NUMBER;
[0-9]+                          yylval.number=atoi(yytext); return DEC_NUMBER;
[a-zA-Z][a-zA-Z0-9]*            yylval.string=strdup(yytext); return WORD;

%%

/*.*          return ANYTHING;*/
/*\n                      * ignore end of line *e/;*/
