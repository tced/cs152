%{
#include <stdio.h> 
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s); 
extern int linenum, col;
FILE *yyin;  
%}

%union{
char* sval; 
}

%start Program
%token BEGIN_PARAMS END_PARAMS BEGINBODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE TRUE FALSE SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN RETURN 
%token <sval> number
%token <sval> identifier
%left MULT DIV MOD ADD SUB OR LT LTE GT GTE EG NEQ
%right NOT ASSIGN

%% 
Program:	Functions{printf("Program->functions\n");}
		;

Functions:	/*empty*/ {printf("Function->epsilon\n");}
         	| Function Functions {printf("Functions -> Function Functions\n");}
         	;

Function:	FUNCTION identifier SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration2 END_LOCALS BEGIN_BODY Statement1 SEMICOLON END_BODY {printf("Function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1 END_LOCALS BEGIN_BODY Statement1 SEMICOLON END_BODY\n");}
         	;

Declaration1:	/*empty*/ {printf("Declaration1->epsilon\n");}  
            	| Declaration SEMICOLON Declaration1 {printf("Declaration1->SEMICOLON Declaration1\n");}
                ; 

Declaration2:   /*empty*/ {printf("Declaration2->epsilon\n");}
                | Declaration SEMICOLON Declaration2 {printf("Declaration2->Declaration SEMICOLON Declaration2\n");}
         	;

Statement1: Statement SEMICOLON Statement1 {printf("Statement1->Statement SEMICOLON Statement1\n");} 
            | Statement SEMICOLON {printf("Statement1->Statement SEMICOLON\n");}
            ;

Declaration: identifier COMMA Declaration {printf("Declaration-> "identifier COMMA Declaration");} 
            | identifier COLON INTEGER {printf("Declaration-> identifier COLON INTEGER\n");}
            | identifier COLON array L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER {printf("Declaration-> identifier COLON array L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER\n");}
            ;

Statement: Var1 ASSIGN Expression {printf("Statement->Var1 ASSIGN Expression\n";}
           | IF Bool-Expr THEN Statement2 ENDIF {printf("Statement->IF Bool-Expr THEN Statement2 ENDIF\n");} 
           | WHILE Bool-Expr BEGINLOOP Statement3 ENDLOOP {printf("Statement->WHILE Bool-Expr BEGINLOOP Statement3 ENDLOOP\n");}
           | DO BEGINLOOP Statement3 ENDLOOP while Bool-Expr {printf("Statement->DO BEGINLOOP Statement3 ENDLOOP while Bool-Expr\n";)} 
           | READ Var1 {printf("Statement->READ Var1\n");}
           | WRITE Var1{printf("Statement->WRITE Var1\n";)}
           | CONTINUE{printf("Statement->CONTINUE\n";)}
           | RETURN Expression{printf("Statement->RETURN Expression\n";)}
           ;

Statement2: Statement SEMICOLON {printf("Statement2-> Statement SEMICOLON\n";)}
           | ELSE Statement2{printf("Statement2-> ELSE Statement2\n");)}
          ; 
Statement3: Statement SEMICOLON Statement3{printf("Statement3-> Statement SEMICOLON Statement3\n";)}  
           | Statement SEMICOLON {printf("Statement SEMICOLON\n";)}
           ;

Var1: Var COMMA Var1 {printf("Var1-> Var COMMA Var1\n";)} 
     | Var {printf("Var1-> Var\n";)}
     ;

Bool-Expr: Relation-And-Expr {printf("Bool-Expr-> Relation-And-Expr\n";)}
           | Relation-And-Expr OR Relation-And-Expr {printf("Bool-Expr -> Relation-And-Expr OR Relation-And-Expr\n";)}
         ; 

Relation-And-Expr: Relation-Expr {printf("Relation-And-Expr-> Relation-Expr\n";)}
                  | Relation-Expr AND Relation-Expr {printf("Relation-Expr AND Relation-Expr\n";)}
                  ;

Relation-Expr: NOT Relation-Expr {printf("Relation-Expr -> NOT Relation-Expr\n";)}
              | Expression Comp Expression {printf("Relation-Expr->Expression Comp Expression\n";)}
              | TRUE {printf("Relation-Expr->TRUE\n";)}
              | FALSE {printf("Relation-Expr->FALSE\n";)}
              | L_PAREN Bool-Expr R_PAREN {printf("Relation-Expr->L_PAREN Bool-Expr R_PAREN\n";)}
              ; 

Comp:	EQ {printf("Comp->EQ\n";)}
    	| NEQ{printf("Comp->NEQ\n";)} 
	| LT{printf("Comp->LT\n";)} 
	| GT{printf("Comp->GT\n";)} 
        | LTE{printf("Comp->LTE\n";)} 
        | GTE{printf("Comp->GTE\n";)}
        ;  

Expression: Multiplicative-Expr{printf("Expression->Multiplicative-Expr\n";)} 
           | SUB Multiplicative-Expr{printf("Expression->SUB Multiplicative-Expr\n";)}
           | ADD Multiplicative-Expr{printf("Expression->ADD Multiplicative-Expr\n";)} 
           | SUB ADD Multiplicative-Expr{printf("Expression->SUB ADD Multiplicative-Expr\n";)}
           ;

Multiplicative-Expr: Term{printf("Multiplicative-Expr->Term\n";)}
                    | Term MULT Term {printf("Multiplicative-Expr->Term MULT Term\n";)}
                    | Term MULT Term DIV Term {printf("Multiplicative-Expr->Term MULT Term DIV Term\n";)}
                    | Term MULT Term DIV Term MOD Term {printf("Multiplicative-Expr->Term MULT Term DIV Term MOD Term\n";)}
                    | Term DIV Term {printf("Multiplicative-Expr->Term DIV Term\n";)}
                    | Term DIV Term MOD Term {printf("Multiplicative-Expr->Term DIV Term MOD Term\n";)}
                    | Term MOD Term {printf("Multiplicative-Expr->Term MOD Term\n";)}
                    | Term MULT Term MOD Term {printf("Multiplicative-Expr-> Term MULT Term MOD Term\n";)}
                    | Term DIV Term {printf("Multiplicative-Expr-> Term DIV Term\n";)}
                    ;

Term: SUB Term {printf("Term->SUB Term\n ";)}
      | Var1 {printf("Term->Var1\n";)}
      |number {printf("Term->number\n";)}
      | L_PAREN Expression R_PAREN {printf("Term->L_PAREN Expression R_PAREN\n";)} 
      | identifier L_PAREN Expression1 R_PAREN {printf("Term->identifier L_PAREN Expression1 R_PAREN\n";)}

Expression1: Expression COMMA Expression1 {printf("Expression1->Expression COMMA Expression1\n";)}
             | Expression COMMA {printf("Expression1->Expression COMMA Expression1\n";)}
             | /*empty*/ {printf("Expression1->epsilon\n";)}

Var: identifier {printf("Var->identifier\n";)}
     | identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var->identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n";)}
            
%%
void yyerror(const char* s)
{
   printf("** Line %d, position %d: %s\n", linenum, col, s); 
}

int main(int argc, char **argv) {
   if (argc > 1) {
      yyin = fopen(argv[1], "r"); 
      if (yyin == NULL) {
         printf("syntax: %s filename\n", argv[0]); 
      } 
   }
   yyparse(); 
   return 0; 
}
