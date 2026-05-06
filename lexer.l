%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror (char *s);
int yylex();
%}

%%
"programme"             {return PROGRAM;}
"fin"                   {return FIN;}
"ecrire"                {return WRITE;}
"lire"                  {return READ;}
"exit"                  {return EXIT_CMD;}

"entier"                {return TYPE_INT;}
"chaine"                {return TYPE_STRING;}
"flottant"              {return TYPE_FLOAT;}
"booleen"               {return TYPE_BOOL;}
"tableau"               {return TYPE_ARRAY;}

"si"                    {return IF;}
"sinon"                 {return ELSE;}
"finsi"                 {return ENDIF;}

"tant"                  {return WHILE;}
"faire"                 {return DO;}
"fintant"               {return ENDWHILE;}

"pour"                  {return FOR;}
"finpour"               {return ENDFOR;}

"fonction"              {return FUNCTION;}
"retour"                {return RETURN;}
"fin_fonction"          {return END_FUNCTION;}

"vrai"                  {yylval.num = 1; return TRUE;}
"faux"                  {yylval.num = 0; return FALSE;}

"et"                    {return AND;}
"ou"                    {return OR;}
"non"                   {return NOT;}

"(&)"                   {return BITWISE_AND;}
"(|)"                   {return BITWISE_OR;}
"(^)"                   {return BITWISE_XOR;}
"(~)"                   {return BITWISE_NOT;}
"(<<)"                  {return LEFT_SHIFT;}
"(>>)"                  {return RIGHT_SHIFT;}

"("                     {return OPEN_PAREN;}
")"                     {return CLOSE_PAREN;}
"{"                     {return OPEN_BRACE;}
"}"                     {return CLOSE_BRACE;}
"["                     {return OPEN_BRACKET;}
"]"                     {return CLOSE_BRACKET;}

"+"                     {return PLUS;}
"-"                     {return MINUS;}
"*"                     {return MULT;}
"/"                     {return DIV;}
"%"                     {return MOD;}
"^"                     {return POW;}

"="                     {return ASSIGN;}
"=="                    {return EQ;}
"!="                    {return NE;}
"<"                     {return LT;}
">"                     {return GT;}
"<="                    {return LE;}
">="                    {return GE;}

";"                     {return SEMICOLON;}
","                     {return COMMA;}
":"                     {return COLON;}

[a-zA-Z_][a-zA-Z0-9_]* {yylval.str = strdup(yytext); return IDENTIFIER;}
[0-9]+                  {yylval.num = atoi(yytext); return NUMBER;}
[0-9]+\.[0-9]+         {yylval.fnum = atof(yytext); return FLOAT_NUM;}

\"[^\"]*\"              {yylval.str = strdup(yytext + 1); yylval.str[strlen(yylval.str)-1] = '\0'; return STRING;}

[ \t\n]                 ;
#.*                     ;
.                       {ECHO; yyerror ("unexpected character");}
%%

int yywrap (void) {return 1;}
