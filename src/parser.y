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

%start input
%union
{
    int number;
    char *string;
    struct expr* expr;
    int *token;
}

%token <number> HEX_NUMBER DEC_NUMBER;
%token <string> WORD;

%token
    ANYTHING
    COMMA
    SQUARE_OPEN
    SQUARE_CLOSE
    
    COMMENT_START
    DIRECTIVE_START
    LABEL_START

    OPCODE_SET
    OPCODE_ADD
    OPCODE_SUB

%token A B C X Y Z I J PC SP EX IA;

%token <token> ADD DIV MUL SUB;

/*%type <expr> expr*/

%%
input: commands { *result = $1; };

commands: /* empty */ | commands command;

command: comment | opcode | directive | label;
comment: COMMENT_START ANYTHING;
directive: DIRECTIVE_START ANYTHING;
label: LABEL_START WORD     { printf("\tLabel: %s\n", $2); };

opcode: basic_opcode;

basic_opcode:
             set_opcode |
             add_opcode |
             sub_opcode;

set_opcode: OPCODE_SET part_b separator part_a { printf("\tSET %d to %d\n", $2, $3); };
add_opcode: OPCODE_ADD part_b separator part_a { printf("\tADD %d to %d\n", $2, $3); };
sub_opcode: OPCODE_SUB part_b separator part_a { printf("\tSUB %d to %d\n", $2, $3); };

separator: COMMA;

part_a: part;
part_b: part;

expressions: part expression | /* empty */;
expression: operator part | expressions;

operator: MUL | DIV | ADD | SUB;

part: number | register;

register:
        A | B | C | X | Y | Z | I | J |
        PC | SP | EX | IA;

number: HEX_NUMBER | DEC_NUMBER;
%%

/*part_a: ref_part | part;
part_b: ref_part | part;
ref_part: /e* empty SQUARE_OPEN expressions SQUARE_CLOSE*e/;*/
