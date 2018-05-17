%{
#include <stdio.h> 
#include <stdlib.h>
//int yylex(void);
void yyerror(const char *s); 
extern int linenum, col;
FILE *yyin;  
%}

%union{
   int num_val;
   char* sval; 
}

%error-verbose
%start Program

%token FUNCTION
%token BEGIN_PARAMS END_PARAMS 
%token BEGIN_BODY token END_BODY
%token BEGIN_LOCALS END_LOCALS 
%token INTEGER 
%token ARRAY 
%token OF 
%token IF THEN ENDIF ELSE 
%token WHILE DO 
%token BEGINLOOP ENDLOOP 
%token CONTINUE 
%token READ WRITE 
%token TRUE FALSE 
%token AND OR NOT
%token SEMICOLON COLON COMMA 
%token L_PAREN R_PAREN 
%token L_SQUARE_BRACKET R_SQUARE_BRACKET 
%token ASSIGN RETURN 
%token <num_val> NUMBER
%token <sval> IDENT
%left MULT DIV MOD ADD SUB LT LTE GT GTE EQ NEQ AND OR
%right NOT ASSIGN

%% 

Program:	Functions{printf("Program->functions\n");}
		;

Functions:	/*empty*/ {printf("Function->epsilon\n");}
         	| Function Functions {printf("Functions -> Function Functions\n");}
         	;

Function:	FUNCTION identifier SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1  END_LOCALS BEGIN_BODY Statement1  END_BODY {printf("Function -> FUNCTION identifier SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1 END_LOCALS BEGIN_BODY Statement1  END_BODY\n");}
         	;

Declaration1:	/*empty*/ {printf("Declaration1->epsilon\n");}  
            	| Declaration SEMICOLON Declaration1 {printf("Declaration1-> Declaration SEMICOLON Declaration1\n");}
                ; 

Declaration: Identifier COLON Type {printf("Declaration-> Identifier COLON Type\n");}

Statement1: Statement SEMICOLON Statement1 {printf("Statement1-> Statement SEMICOLON Statement1\n");} 
            | Statement SEMICOLON {printf("Statement1-> Statement SEMICOLON\n");}
            ;


Identifier:  identifier {printf("Identifier-> identifier\n");}
            | identifier COMMA Identifier {printf("Identifier-> identifier COMMA Identifier\n");}
	;

identifier:  IDENT {printf("identifer -> IDENT %s\n", $1);}
	;         
Type:	     INTEGER { printf("Type-> INTEGER\n");}   
	    | ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("Type-> ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
            ;

Statement: Var1 ASSIGN Expression {printf("Statement->Var1 ASSIGN Expression\n");}
           | IF-STMT {printf("Statement-> IF-STMT\n");}
           | WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP {printf("Statement->WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP\n");}
           | DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr {printf("Statement->DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr\n");} 
           | READ Var1 {printf("Statement->READ Var1\n");}
           | WRITE Var1{printf("Statement->WRITE Var1\n");}
           | CONTINUE{printf("Statement->CONTINUE\n");}
           | RETURN Expression{printf("Statement->RETURN Expression\n");}
           ;

IF-STMT:   IF Bool-Expr THEN Statement1 ENDIF {printf("IF-STMT->IF Bool-Expr THEN Statement1 ENDIF\n");}
           | IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF {printf("IF-STMT-> IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF\n");}
          ; 

Var1: Var COMMA Var1 {printf("Var1-> Var COMMA Var1\n");} 
     | Var {printf("Var1-> Var\n");}
     ;

Bool-Expr: Relation_And_Expr {printf("Bool-Expr-> Relation_And_Expr\n");}
           | Relation_And_Expr OR Bool-Expr {printf("Bool-Expr -> Relation_And_Expr OR Relation_And_Expr\n");}
         ; 

Relation_And_Expr: Relation_Exprs {printf("Relation_And_Expr-> Relation_Expr\n");}
                  | Relation_Exprs AND Relation_And_Expr {printf("Relation_And_Exprs-> Relation_Expr AND Relation_Exprs\n");}
                  ;

Relation_Exprs:	NOT Relation_Expr {printf("Relation_Expr -> NOT Relation_Expr\n");}
                | Relation_Expr {printf("Relation_Expr -> Relation_Expr\n");}
		; 

Relation_Expr:	Expression Comp Expression {printf("Relation_Exprs->Expression Comp Expression\n");}
              	| TRUE {printf("Relation_Expr->TRUE\n");}
             	| FALSE {printf("Relation_Expr->FALSE\n");}
              	| L_PAREN Bool-Expr R_PAREN {printf("Relation-Expr->L_PAREN Bool-Expr R_PAREN\n");}
              	; 

Comp:	EQ {printf("Comp->EQ\n");}
    	| NEQ{printf("Comp->NEQ\n");} 
	| LT{printf("Comp->LT\n");} 
	| GT{printf("Comp->GT\n");} 
        | LTE{printf("Comp->LTE\n");} 
        | GTE{printf("Comp->GTE\n");}
        ;  

Expression: 	Multiplicative-Expr ADD Expression {printf("Expression->Multiplicative-Expr ADD Expression\n");}
 		| Multiplicative-Expr SUB Expression {printf("Expression->Multiplicative-Expr SUB Expression\n");}
   		| Multiplicative-Expr {printf("Expression-> Multiplicative-Expr\n");}
 		; 
           
Multiplicative-Expr:	Term MULT Term {printf("Multiplicative-Expr-> Term MULT Term\n");}
			| Term DIV Term {printf("Multiplicative-Expr-> Term DIV Term\n");}
                        | Term MOD Term {printf("Multiplicative-Expr-> TErm MOD Term\n");}
                        | Term {printf("Multiplicative-Expr-> Term\n");} 
			; 

Term:		Normal{} /*can call Normal aka Term2 to reduce conflit/reduce*/ 
      		| SUB Var {printf("Term->SUB Var\n");}
		| SUB NUMBER {printf("Term-> SUB NUMBER %s\n", $2);} 
                | SUB L_PAREN Expression R_PAREN {printf("Term-> SUB L_PAREN Expression R_PAREN\n");} 
      	        | identifier L_PAREN Expression1 R_PAREN {printf("Term -> identifier L_PAREN Expression1 R_PAREN\n");}
      		;

/*-----form of Term2-------*/ 
Normal:		Var {printf("Term->Var\n");}
		| NUMBER {printf("Term->NUMBER %s\n", $1);}
		| L_PAREN Expression1 R_PAREN {printf("L_PAREN Expression1 R_PAREN\n");}
		;

Expression1:	Expression COMMA Expression1 {printf("Expression1->Expression COMMA Expression1\n");}
             	| Expression {printf("Expression1->Expression\n");}
             	| /*empty*/ {printf("Expression1->epsilon\n");}

Var:	identifier {printf("Var->identifier\n");}
     	| identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var->identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
     	;
            
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
