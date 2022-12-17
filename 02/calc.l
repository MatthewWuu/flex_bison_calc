%{
#include <vector>
#include "parser.hpp"
%}
%%

"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"("     { return LP; }
")"     { return RP; }
"="     { return ASSIGN; }
","     { return COMMA; }

[0-9]+(\.[0-9]+)? { yylval.NUMBER = atof(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9]* { yylval.ID = strdup(yytext); return ID; }

\n      { return CR; }
[ \t]   { /*ignore white space*/ }
.       { fprintf(stderr, "lexical error: %s\n", yytext); exit(-1); }

%%

int yywrap(void){ return 0; }
