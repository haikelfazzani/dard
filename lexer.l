%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror (char *s);
int yylex();
%}

%%
"ecrire"			    {return ecrire;}
"exit"				    {return exit_cmd;}

"string"                return TYPE_STRING;

"(" 					{return OPEN_BRACKET;}
")" 					{return CLOSE_BRACKET;}

"{"                     {return OPEN_SCOPE;}
"}"                     {return CLOSE_SCOPE;}

[a-zA-Z]			    {yylval.id = yytext[0]; return identifier;}
[0-9]+                  {yylval.num = atoi(yytext); return number;}
[ \t\n]                 ;
[-+=;]           	    {return yytext[0];}
.                       {ECHO; yyerror ("unexpected character");}
%%

int yywrap (void) {return 1;}