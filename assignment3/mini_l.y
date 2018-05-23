%{
#include <iostream>
using namespace std;
//#include <stdio.h> 
//#include <stdlib.h>
//#include <string.h>
#include <fstream>
int yylex(void);
void yyerror(const char *s); 
extern int linenum;
extern int col;
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

Program:	Functions{cout << "Program->functions\n";}
		;

Functions:	/*empty*/ {cout << "Function->epsilon\n";}
         	| Function Functions {cout << "Functions -> Function Functions\n";}
         	;

Function:	FUNCTION identifier SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1  END_LOCALS BEGIN_BODY Statement1  END_BODY { cout << "Function -> FUNCTION identifier SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1 END_LOCALS BEGIN_BODY Statement1  END_BODY\n";}
         	;

Declaration1:	/*empty*/ {cout << "Declaration1->epsilon\n";}  
            	| Declaration SEMICOLON Declaration1 {cout << "Declaration1-> Declaration SEMICOLON Declaration1\n";}
                ; 

Declaration: Identifier COLON Type {cout << "Declaration-> Identifier COLON Type\n";}

Statement1: Statement SEMICOLON Statement1 {cout << "Statement1-> Statement SEMICOLON Statement1\n";} 
            | Statement SEMICOLON {cout << "Statement1-> Statement SEMICOLON\n";}
            ;


Identifier:  identifier {cout << "Identifier-> identifier\n";}
            | identifier COMMA Identifier {cout << "Identifier-> identifier COMMA Identifier\n";}
	;

identifier:  IDENT {cout << "identifer -> IDENT %s\n", yylval.sval;}
	;         
Type:	     INTEGER { cout << "Type-> INTEGER\n";}   
	    | ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {cout << "Type-> ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n";}
            ;

Statement: Var1 ASSIGN Expression {cout << "Statement->Var1 ASSIGN Expression\n";}
           | IF-STMT {cout << "Statement-> IF-STMT\n";}
           | WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP {cout << "Statement->WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP\n";}
           | DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr {cout << "Statement->DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr\n";} 
           | READ Var1 {cout << "Statement->READ Var1\n";}
           | WRITE Var1{cout << "Statement->WRITE Var1\n";}
           | CONTINUE{cout << "Statement->CONTINUE\n";}
           | RETURN Expression{cout << "Statement->RETURN Expression\n";}
           ;

IF-STMT:   IF Bool-Expr THEN Statement1 ENDIF {cout << "IF-STMT->IF Bool-Expr THEN Statement1 ENDIF\n";}
           | IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF {cout << "IF-STMT-> IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF\n";}
          ; 

Var1: Var COMMA Var1 {cout << "Var1-> Var COMMA Var1\n";} 
     | Var {cout << "Var1-> Var\n";}
     ;

Bool-Expr: Relation_And_Expr {cout << "Bool-Expr-> Relation_And_Expr\n";}
           | Relation_And_Expr OR Bool-Expr {cout << "Bool-Expr -> Relation_And_Expr OR Relation_And_Expr\n";}
         ; 

Relation_And_Expr: Relation_Exprs {cout << "Relation_And_Expr-> Relation_Expr\n";}
                  | Relation_Exprs AND Relation_And_Expr {cout << "Relation_And_Exprs-> Relation_Expr AND Relation_Exprs\n";}
                  ;

Relation_Exprs:	NOT Relation_Expr {cout << "Relation_Expr -> NOT Relation_Expr\n";}
                | Relation_Expr {cout << "Relation_Expr -> Relation_Expr\n";}
		; 

Relation_Expr:	Expression Comp Expression {cout << "Relation_Exprs->Expression Comp Expression\n";}
              	| TRUE {cout << "Relation_Expr->TRUE\n";}
             	| FALSE {cout << "Relation_Expr->FALSE\n";}
              	| L_PAREN Bool-Expr R_PAREN {cout << "Relation-Expr->L_PAREN Bool-Expr R_PAREN\n";}
              	; 

Comp:	EQ {cout << "Comp->EQ\n";}
    	| NEQ{cout << "Comp->NEQ\n";} 
	| LT{cout << "Comp->LT\n";} 
	| GT{cout << "Comp->GT\n";} 
        | LTE{cout << "Comp->LTE\n";} 
        | GTE{cout << "Comp->GTE\n";}
        ;  

Expression: 	Multiplicative-Expr ADD Expression {cout << "Expression->Multiplicative-Expr ADD Expression\n";}
 		| Multiplicative-Expr SUB Expression {cout << "Expression->Multiplicative-Expr SUB Expression\n";}
   		| Multiplicative-Expr {cout << "Expression-> Multiplicative-Expr\n";}
 		; 
           
Multiplicative-Expr:	Term MULT Term {cout << "Multiplicative-Expr-> Term MULT Term\n";}
			| Term DIV Term {cout << "Multiplicative-Expr-> Term DIV Term\n";}
                        | Term MOD Term {cout << "Multiplicative-Expr-> Term MOD Term\n";}
                        | Term {cout << "Multiplicative-Expr-> Term\n";} 
			; 

Term:		Normal{} /*can call Normal aka Term2 to reduce conflit/reduce*/ 
      		| SUB Var {cout << "Term->SUB Var\n";}
		| SUB NUMBER {cout << "Term-> SUB NUMBER " <<  yylval.num_val << endl;} 
                | SUB L_PAREN Expression R_PAREN {cout << "Term-> SUB L_PAREN Expression R_PAREN\n";} 
      	        | identifier L_PAREN Expression1 R_PAREN {cout << "Term -> identifier L_PAREN Expression1 R_PAREN\n";}
      		;

/*-----form of Term2-------*/ 
Normal:		Var {cout << "Term->Var\n";}
		| NUMBER {cout << "Term->NUMBER " <<  yylval.num_val << endl;}
		| L_PAREN Expression1 R_PAREN {cout << "L_PAREN Expression1 R_PAREN\n";}
		;

Expression1:	Expression COMMA Expression1 {cout << "Expression1->Expression COMMA Expression1\n";}
             	| Expression {cout << "Expression1->Expression\n";}
             	| /*empty*/ {cout << "Expression1->epsilon\n";}

Var:	identifier {cout << "Var->identifier\n";}
     	| identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {cout << "Var->identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n";}
     	;
            
%%
void yyerror(const char* s)
{
   cout << "** Line " << linenum << ", position " << col << ": " << s << endl; 
}

int main(int argc, char **argv) {
   if (argc > 1) {
      ifstream fs;
      yyin = fs.open(argv[1], fstream::in);
      if (yyin == NULL){
         cout << "syntax: " << argv[0] << " filename\n";
      }
   }
   yyparse(); 
   return 0; 
}

