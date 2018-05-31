%{

#include "heading.h"
int yylex(void);
void yyerror(const char *s); 
extern int linenum;
extern int col;
//FILE *yyin;  
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

Program:	Functions{}
		;

Functions:	/*empty*/ {}
         	| Function Functions {}
         	;

Function:	FUNCTION IDENT {cout << "func " << strdup($2) << endl;} SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1  END_LOCALS BEGIN_BODY Statement1  END_BODY  {cout << "endfunc" << endl;} 
         	| error{ yyerrok; yyclearin;}
		;

Declaration1:	/*empty*/ {}  
            	| Declaration SEMICOLON Declaration1 {}
                ; 

Declaration:  Identifier COLON Type {}
		| error{yyerrok; yyclearin;}

Statement1: Statement SEMICOLON Statement1 {} 
            | Statement SEMICOLON {}
            ;


Identifier:  identifier {}
            | identifier COMMA Identifier {}
	;

identifier:  IDENT {cout <<  "." << strdup($1) << endl;}
	;         
Type:	     INTEGER {}   
	    | ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {}
            ;

Statement: Var1 ASSIGN Expression {} 
           | IF-STMT {}
           | WHILE Bool-Expr BEGINLOOP Statement1 ENDLOOP {}
           | DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr {} 
           | READ {cout << ".<";} Var1
           | WRITE {cout << ".>";} Var1
           | CONTINUE
           | RETURN Expression{cout << "ret src" << endl; }
	   | error {yyerrok; yyclearin;}
           ;

IF-STMT:   IF Bool-Expr THEN Statement1 ENDIF
           | IF Bool-Expr THEN Statement1 ELSE Statement1 ENDIF
          ; 

Var1: Var COMMA Var1
     | Var
     ;

Bool-Expr: Relation_And_Expr {}
           | Relation_And_Expr OR {cout << "|| ";} Bool-Expr
         ; 

Relation_And_Expr: Relation_Exprs {}
                  | Relation_Exprs AND {cout << "&& ";} Relation_And_Expr
                  ;

Relation_Exprs:	NOT {cout << "! ";} Relation_Expr {}
                | Relation_Expr {}
		; 

Relation_Expr:	Expression Comp Expression {}
              	| TRUE {}
             	| FALSE {}
              	| L_PAREN Bool-Expr R_PAREN {}
              	; 

Comp:	EQ
    	| NEQ 
	| LT
	| GT 
        | LTE 
        | GTE
        ;  

Expression: 	Multiplicative-Expr ADD {cout << "+ ";} Expression
 		| Multiplicative-Expr SUB {cout << "- ";} Expression
   		| Multiplicative-Expr {}
 		; 
           
Multiplicative-Expr:	Term MULT {cout << "* ";} Term 
			| Term DIV {cout << "/ ";} Term
                        | Term MOD {cout << "% "; }Term
                        | Term {} 
			; 

Term:		Normal{} /*can call Normal aka Term2 to reduce conflit/reduce*/ 
      		| SUB Var
		| SUB NUMBER 
                | SUB L_PAREN Expression R_PAREN       	        
		| identifier L_PAREN Expression1 R_PAREN {}
      		;

/*-----form of Term2-------*/ 
Normal:		Var {}
		| NUMBER {}
		| L_PAREN Expression1 R_PAREN {}
		;

Expression1:	Expression COMMA Expression1 {}
             	| Expression {}
             	| /*empty*/ {}

Var:	identifier {}
     	| identifier L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {}
     	;
            
%%
void yyerror(const char* s)
{
   cout << "** Line " << linenum << ", position " << col << ": " << s << endl; 
}

int main(int argc, char **argv) {
   if (argc > 1 && (freopen(argv[1], "r", stdin) == NULL)) {
      cerr << argv[0] << ": File " << argv[1] << " cannot beopened.\n"; 
 	exit(1);  
   }
   yyparse(); 
   return 0;
}

