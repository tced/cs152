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
%token <num_val> number
%token <sval> identifier
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

Statement1: Statement SEMICOLON Statement1 {printf("Statement1-> Statement SEMICOLON Statement1\n");} 
            | Statement SEMICOLON {printf("Statement1-> Statement SEMICOLON\n");}
            ;

Declaration: Identifier COLON Type {printf("Declaration-> Identifier COLON Type");}

Identifier:  identifier {printf("Identifier-> identifier\n");}
            | identifier COMMA Identifier {printf("Identifier-> identifier COMMA Identifier\n");}
	;
         
Type:	     INTEGER { printf("Type-> INTEGER\n");}   
	    | ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER {printf("Type-> ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER\n");}
            ;

Statement: Var1 ASSIGN Expression {printf("Statement->Var1 ASSIGN Expression\n";}
           | IF-STMT {printf("Statement-> IF-STMT\n");}
           | WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP {printf("Statement->WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP\n");}
           | DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr {printf("Statement->DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr\n";)} 
           | READ Var1 {printf("Statement->READ Var1\n");}
           | WRITE Var1{printf("Statement->WRITE Var1\n";)}
           | CONTINUE{printf("Statement->CONTINUE\n";)}
           | RETURN Expression{printf("Statement->RETURN Expression\n";)}
           ;

IF-STMT:   IF Bool-Expr THEN Statement1 ENDIF {printf("IF-STMT->IF Bool-Expr THEN Statement1 ENDIF\n");}
           | IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF {printf("IF-STMT-> IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF\n");}
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

Expression: Multiplicative-Expr Sub_Add-Expr {printf("Expression->Multiplicative-Expr Sub_Add-Expr\n";)} 
           
Sub_Add-Expr:  /*empty*/ {printf("Sub_Add-Expr->epsilon\n";)}
           | ADD Multiplicative-Expr Sub_Add-Expr {printf("Sub_Add-Expr->ADD Multiplicative-Expr Sub_Add-Expr\n";)} 
           | SUB  Multiplicative-Expr Sub_Add-Expr {printf("Sub_Add-Expr->SUB Multiplicative-Expr Sub_Add-Expr\n";)}
           ;

Multiplicative-Expr: Term Mod_Div_Mult {printf("Multiplicative-Expr->Term Mod_Div_Mult\n";)}
		;
Mod_Div_Mult:	    /*empty*/ {printf("Mod_Div_Mult->epsilon\n");}
                    | MOD Term Mod_Div_Mult {printf("Mod_Div_Mult-> MOD Term Mod_Div_Mult\n";)}
                    | DIV Term Mod_Div_Mult {printf("Mod_Div_Mult-> DIV Term Mod-Div_Mult\n";)}
                    | MULT Term Mod_Div_Mult {printf("Mod_Div_Mult-> MULT Termn Mod_Div_Mult\n";)}
                    ;

Term: Normal {printf("Term->Normal\n");}
      | SUB Normal {printf("Term->SUB Normal\n ";)}
      | identifier Ident-Expr {printf("Term->identifier Ident-Expr\n";)}
      ;

Normal:	Var {printf("Normal->Var\n");}
	| number {printf("Normal->number\n");}
	| L_PAREN Expression1 R_PAREN {printf("Normal->L_PAREN Expression1 R_PAREN\n");}
	;

Expression1: Expression COMMA Expression1 {printf("Expression1->Expression COMMA Expression1\n";)}
             | Expression {printf("Expression1->Expression\n";)}
             | /*empty*/ {printf("Expression1->epsilon\n";)}

Ident-Expr:	L_PAREN Expression1 R_PAREN {printf("Ident-Expr->L_PAREN Expression1 R_PAREN\n");}
		| L_PAREN R_PAREN {printf("Ident-Expr-> L_PAREN R_PAREN");}
		;

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
