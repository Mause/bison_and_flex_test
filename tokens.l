%{
#include <stdio.h>
#include "parser.hpp"
//#include "tokens.hpp"
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
%%

/*.*          return ANYTHING;*/
/*\n                      * ignore end of line *e/;*/
