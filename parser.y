%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str) { fprintf(stderr, "error: %s\n", str); }
int yylex(void);
int yyparse(void);

main() {
    int yydebug=1;
    yyparse();
}
%}

%token
    HEX_NUMBER
    DEC_NUMBER
    ANYTHING
    COMMENT_START
    DIRECTIVE_START
    COMMA
    SQUARE_OPEN
    SQUARE_CLOSE
    OPCODE_SET
    OPCODE_ADD
    OPCODE_SUB;

%%
commands: /* empty */
        | commands command
        ;

command: comment | opcode | directive;
comment: COMMENT_START ANYTHING;
directive: DIRECTIVE_START ANYTHING;

opcode: basic_opcode;

basic_opcode:
             set_opcode |
             add_opcode |
             sub_opcode;

set_opcode: OPCODE_SET part_b separator part_a { printf("\tSET %d to %d\n", $2, $3); };
add_opcode: OPCODE_ADD part_b separator part_a { printf("\tADD %d to %d\n", $2, $3); };
sub_opcode: OPCODE_SUB part_b separator part_a { printf("\tSUB %d to %d\n", $2, $3); };

separator: COMMA | /* empty */

part_a: part | ref_part;

part_b: part | ref_part;

ref_part: SQUARE_OPEN part SQUARE_CLOSE;
part: number;

number: HEX_NUMBER | DEC_NUMBER;
%%
