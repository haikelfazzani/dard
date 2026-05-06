%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

void yyerror(const char *s);
int yylex();

#define MAX_VARS 1000
#define MAX_ARRAYS 100
#define MAX_FUNCTIONS 50
#define MAX_ARRAY_SIZE 1000

typedef enum {TYPE_UNDEF, TYPE_INT, TYPE_FLOAT, TYPE_STRING, TYPE_BOOL, TYPE_ARRAY} DataType;

typedef struct {
    char name[256];
    DataType type;
    union {
        int intVal;
        double floatVal;
        char* strVal;
    } value;
    int arrayVal[MAX_ARRAY_SIZE];
    int arraySize;
} Variable;

typedef struct {
    char name[256];
    int isDefined;
} Function;

Variable variables[MAX_VARS];
Function functions[MAX_FUNCTIONS];
int varCount = 0;
int funcCount = 0;

Variable* getVar(const char* name);
void setVar(const char* name, DataType type, int ival, double fval, const char* sval);
void setArrayElement(const char* name, int index, int value);
int getArrayElement(const char* name, int index);
void printValue(Variable* var);
%}

%union {
    int num;
    double fnum;
    char* str;
    Variable* var;
}

%start program

%token PROGRAM FIN
%token WRITE READ EXIT_CMD
%token TYPE_INT TYPE_STRING TYPE_FLOAT TYPE_BOOL TYPE_ARRAY
%token IF ELSE ENDIF
%token WHILE DO FINTANT
%token FOR ENDFOR
%token FUNCTION RETURN END_FUNCTION
%token AND OR NOT
%token TRUE FALSE
%token OPEN_PAREN CLOSE_PAREN OPEN_BRACE CLOSE_BRACE OPEN_BRACKET CLOSE_BRACKET
%token PLUS MINUS MULT DIV MOD POW
%token ASSIGN EQ NE LT GT LE GE
%token SEMICOLON COMMA COLON

%token <num> NUMBER
%token <fnum> FLOAT_NUM
%token <str> STRING IDENTIFIER

%type <num> expr term factor comparison logical_expr
%type <str> statement

%%

program     : PROGRAM statements FIN 
            | statements
            ;

statements  : statement
            | statements statement
            ;

statement   : declaration SEMICOLON
            | assignment SEMICOLON
            | ifStatement
            | whileStatement
            | forStatement
            | functionDef
            | functionCall SEMICOLON
            | WRITE OPEN_PAREN expr CLOSE_PAREN SEMICOLON { printf("%d\n", $3); }
            | EXIT_CMD SEMICOLON { exit(EXIT_SUCCESS); }
            | RETURN expr SEMICOLON { return 0; }
            ;

declaration : TYPE_INT IDENTIFIER 
            { setVar($2, TYPE_INT, 0, 0, NULL); }
            | TYPE_INT IDENTIFIER ASSIGN expr 
            { setVar($2, TYPE_INT, $4, 0, NULL); }
            | TYPE_FLOAT IDENTIFIER 
            { setVar($2, TYPE_FLOAT, 0, 0.0, NULL); }
            | TYPE_STRING IDENTIFIER 
            { setVar($2, TYPE_STRING, 0, 0, ""); }
            | TYPE_ARRAY IDENTIFIER OPEN_BRACKET NUMBER CLOSE_BRACKET 
            { 
                Variable* v = getVar($2);
                if (!v) {
                    setVar($2, TYPE_ARRAY, 0, 0, NULL);
                    v = getVar($2);
                }
                v->arraySize = $4;
            }
            ;

assignment  : IDENTIFIER ASSIGN expr 
            { setVar($1, getVar($1)->type, $3, 0, NULL); }
            | IDENTIFIER OPEN_BRACKET expr CLOSE_BRACKET ASSIGN expr 
            { setArrayElement($1, $3, $6); }
            ;

ifStatement : IF OPEN_PAREN logical_expr CLOSE_PAREN OPEN_BRACE statements CLOSE_BRACE
            | IF OPEN_PAREN logical_expr CLOSE_PAREN OPEN_BRACE statements CLOSE_BRACE 
              ELSE OPEN_BRACE statements CLOSE_BRACE
            ;

whileStatement : WHILE OPEN_PAREN logical_expr CLOSE_PAREN OPEN_BRACE statements CLOSE_BRACE
               ;

forStatement : FOR OPEN_PAREN assignment SEMICOLON logical_expr SEMICOLON assignment CLOSE_PAREN 
              OPEN_BRACE statements CLOSE_BRACE
            ;

functionDef : FUNCTION IDENTIFIER OPEN_PAREN paramList CLOSE_PAREN OPEN_BRACE statements CLOSE_BRACE END_FUNCTION
            | FUNCTION IDENTIFIER OPEN_PAREN CLOSE_PAREN OPEN_BRACE statements CLOSE_BRACE END_FUNCTION
            ;

paramList   : IDENTIFIER
            | paramList COMMA IDENTIFIER
            ;

functionCall : IDENTIFIER OPEN_PAREN CLOSE_PAREN
             | IDENTIFIER OPEN_PAREN exprList CLOSE_PAREN
             ;

exprList    : expr
            | exprList COMMA expr
            ;

logical_expr : comparison 
             { $$ = $1; }
             | logical_expr AND logical_expr 
             { $$ = $1 && $3; }
             | logical_expr OR logical_expr 
             { $$ = $1 || $3; }
             | NOT logical_expr 
             { $$ = !$2; }
             ;

comparison  : expr EQ expr 
            { $$ = ($1 == $3); }
            | expr NE expr 
            { $$ = ($1 != $3); }
            | expr LT expr 
            { $$ = ($1 < $3); }
            | expr GT expr 
            { $$ = ($1 > $3); }
            | expr LE expr 
            { $$ = ($1 <= $3); }
            | expr GE expr 
            { $$ = ($1 >= $3); }
            | expr 
            { $$ = $1; }
            ;

expr        : term 
            { $$ = $1; }
            | expr PLUS term 
            { $$ = $1 + $3; }
            | expr MINUS term 
            { $$ = $1 - $3; }
            ;

term        : factor 
            { $$ = $1; }
            | term MULT factor 
            { $$ = $1 * $3; }
            | term DIV factor 
            { if ($3 != 0) $$ = $1 / $3; else { yyerror("Division by zero"); $$ = 0; } }
            | term MOD factor 
            { if ($3 != 0) $$ = $1 % $3; else { yyerror("Modulo by zero"); $$ = 0; } }
            | term POW factor 
            { $$ = (int)pow($1, $3); }
            ;

factor      : NUMBER 
            { $$ = $1; }
            | FLOAT_NUM 
            { $$ = (int)$1; }
            | TRUE 
            { $$ = 1; }
            | FALSE 
            { $$ = 0; }
            | IDENTIFIER 
            { 
                Variable* v = getVar($1); 
                if (v) $$ = v->value.intVal; 
                else { yyerror("Undefined variable"); $$ = 0; }
            }
            | IDENTIFIER OPEN_BRACKET expr CLOSE_BRACKET 
            { $$ = getArrayElement($1, $3); }
            | OPEN_PAREN expr CLOSE_PAREN 
            { $$ = $2; }
            | MINUS factor 
            { $$ = -$2; }
            ;

%%

Variable* getVar(const char* name) {
    for (int i = 0; i < varCount; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            return &variables[i];
        }
    }
    return NULL;
}

void setVar(const char* name, DataType type, int ival, double fval, const char* sval) {
    Variable* v = getVar(name);
    if (v) {
        v->type = type;
        v->value.intVal = ival;
        v->value.floatVal = fval;
        if (sval) v->value.strVal = strdup(sval);
    } else if (varCount < MAX_VARS) {
        strcpy(variables[varCount].name, name);
        variables[varCount].type = type;
        variables[varCount].value.intVal = ival;
        variables[varCount].value.floatVal = fval;
        if (sval) variables[varCount].value.strVal = strdup(sval);
        variables[varCount].arraySize = 0;
        varCount++;
    }
}

void setArrayElement(const char* name, int index, int value) {
    Variable* v = getVar(name);
    if (v && v->type == TYPE_ARRAY && index >= 0 && index < v->arraySize) {
        v->arrayVal[index] = value;
    }
}

int getArrayElement(const char* name, int index) {
    Variable* v = getVar(name);
    if (v && v->type == TYPE_ARRAY && index >= 0 && index < v->arraySize) {
        return v->arrayVal[index];
    }
    return 0;
}

void printValue(Variable* var) {
    if (!var) return;
    switch (var->type) {
        case TYPE_INT:
            printf("%d", var->value.intVal);
            break;
        case TYPE_FLOAT:
            printf("%f", var->value.floatVal);
            break;
        case TYPE_STRING:
            printf("%s", var->value.strVal);
            break;
        case TYPE_BOOL:
            printf("%s", var->value.intVal ? "vrai" : "faux");
            break;
        default:
            break;
    }
}

int main(void) {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
