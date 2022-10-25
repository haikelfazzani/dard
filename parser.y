%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
%}

%union {int num; char id;}

%start line
%token ecrire
%token exit_cmd

%token OPEN_BRACKET CLOSE_BRACKET
%token OPEN_SCOPE CLOSE_SCOPE

%token TYPE_STRING
%token <num> number
%token <id> identifier
%type <num> line exp term 
%type <id> assignment

%%

line    : assignment   			                                {;}
		| exit_cmd   				                            {exit(EXIT_SUCCESS);}
		| ecrire OPEN_BRACKET exp CLOSE_BRACKET		        {printf("%d\n", $3);}
		| line assignment   		                            {;}
		| line ecrire OPEN_BRACKET exp  CLOSE_BRACKET 		{printf("%d\n", $4);}
		| line exit_cmd   	                                    {exit(EXIT_SUCCESS);}
        ;

assignment : identifier '=' exp  { updateSymbolVal($1,$3); }
			;
exp    	: term                  {$$ = $1;}
       	| exp '+' term          {$$ = $1 + $3;}
       	| exp '-' term          {$$ = $1 - $3;}
       	;
term   	: number                {$$ = $1;}
		| identifier			{$$ = symbolVal($1);} 
        ;

%%                     /* C code */

int computeSymbolIndex(char token){
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol){
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val){
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 