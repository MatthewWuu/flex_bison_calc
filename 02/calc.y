%{
#include <stdio.h>
#include <string>
#include <vector>
#include <map>
#include <math.h>

#include "funcs.hpp"

static std::map<std::string, double> scopes { { "pi", M_PI }, { "e", M_E } };

int yyerror(char *s);
int yylex();
%}

%code requires {
#include <vector>
}

%define api.value.type union

%token ADD SUB MUL DIV LP RP ASSIGN
%token NUMBER ID
%token COMMA CR

%type <double> NUMBER factor term expr call
%type <char*> ID
%type <std::vector<double>*> parameters

%%

start   : { printf(">"); }
        | start expr CR { printf("%f\n>", $2); }
        | start stmt
        | start CR { printf(">"); }
        ;

stmt    : ID ASSIGN expr CR { scopes[std::string($1)] = $3; printf(">"); }
        ;

expr    : term { $$ = $1; }
        | expr ADD term { $$ = $1 + $3; }
        | expr SUB term { $$ = $1 - $3; }
        ;

term    : factor { $$ = $1; }
        | term MUL factor { $$ = $1 * $3; }
        | term DIV factor { $$ = $1 / $3; }
        ;

factor  : NUMBER { $$ = $1; }
        | LP expr RP { $$ = $2; }
        | SUB factor { $$ = -$2; }
        | ADD factor { $$ = $2; }
        | ID { $$ = scopes[std::string($1)]; }
        | call
        ;

call    : ID LP RP { $$ = handle_call($1, nullptr); }
        | ID LP parameters RP { $$ = handle_call($1, $3); }
        ;

parameters : expr { $$ = new std::vector<double>{$1}; }
        | parameters COMMA expr { $1->push_back($3); $$ = $1; }
        ;

%%

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
