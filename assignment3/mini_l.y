%{

#include "heading.h"
int yylex(void);
void yyerror(const char *s); 
extern int linenum;
extern int col;

std::vector <string> sym_table; 
std::vector <string> sym_type; 
std::vector <string> param_table; 
bool add_to_param_table = false; 
std::vector <string> op;
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
         	| Function Functions 
		{}
         	;

Function:	FUNCTION IDENT {cout << "func " << strdup($2) << endl;} SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1  END_LOCALS BEGIN_BODY Statement1  END_BODY 
		 {		   
		   for (unsigned int j=0; j<sym_table.size(); ++j){
		       if(sym_type.at(j) == "INTEGER") {
		          cout << ". " << sym_table.at(j) << endl; 
                       }
		       else {
		          cout << ".[] " << sym_table.at(j) << ", " << sym_type.at(j) << endl; 
		       }
		   }
                   cout <<"endfunc" << endl; 
		 } 
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


Identifier:  IDENT 
	    { 
		sym_table.push_back("_" + *($1));
	        if(add_to_param_table) 
		   param_table.push_back("_"+*($1)); 
	    }
            | IDENT COMMA Identifier 
	      { sym_table.push_back("_" + *($1));
		sym_type.push_back("INTEGER");
	      }
	    ;

/*
identifier:  IDENT 
	     {/*cout <<  "." << strdup($1) << endl;
	       sym_table.push_back("_" + *($1)); 
	     }
	;         

*/ 

/*part of Declaration*/ 
Type:	     INTEGER 
	     {
		sym_type.push_back("INTEGER"); 
	     }   
	    | ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
	    {
	       stringstream ss; 
               ss << $3; 
               string s = ss.str(); 
               sym_type.push_back(s); 
	    }
            ;

Statement:	Var ASSIGN Expression {} 
           	| if_rule {}
           	| while_rule {}
           	| do_while_rule {} 
           	| read_in 
           	| WRITE comma_mult
           	| CONTINUE
           	| RETURN Expression
	   	| error {yyerrok; yyclearin;}
           	;

if_rule:	if_condition Statement1 ENDIF
		| else_condition Statement1 ENDIF
		;

if_condition:	IF Bool-Expr THEN
		;

else_condition:	if_condition Statement1 ELSE   
		; 

while_rule:	while_condition Statement1 ENDLOOP
		; 

while_condition:	WHILE Bool-Expr BEGINLOOP
			;

do_while_rule:	DO BEGINLOOP Statement1 ENDLOOP WHILE Bool-Expr
		;

read_in:	READ comma_mult 
		; 

comma_mult:	Var
	      	| Var COMMA comma_mult 
		; 
		
/* 
Var1: Var COMMA Var1
     | Var
     ;
*/ 
Bool-Expr:	Relation_Exprs {}
         	| Bool-Expr OR Relation_And_Expr {} 
         	; 

Relation_And_Expr:	Relation_Exprs {}
                  	| Relation_Exprs AND Relation_And_Expr {} 
                  	;

Relation_Exprs:		NOT Relation_Expr {}
                	| Relation_Expr {}
			; 

Relation_Expr:		Expression Comp Expression {}
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

Expression: 	Multiplicative-Expr ADD Expression {}
 		| Multiplicative-Expr SUB Expression {} 
   		| Multiplicative-Expr {}
 		; 

Term_Mult-Expr:		Term Multiplicative-Expr {} 
			; 

Multiplicative-Expr:	/*empty*/ {} 
			| MULT Term Term_Mult-Expr {} 
			| DIV Term Term_Mult-Expr {}
                        | MOD Term Term_Mult-Expr {}
			; 

Term:		Normal{} /*can call Normal aka Term2 to reduce conflit/reduce*/ 
      		| SUB Normal    	        
		| /*identifier*/ IDENT Term_1 {}
      		;

Term_1:		L_PAREN Expression1 R_PAREN {} 
		| L_PAREN R_PAREN {} 
		; 

/*-----form of Term2-------*/ 
Normal:		Var {}
		| NUMBER {}
		| L_PAREN Expression1 R_PAREN {}
		;

Expression1:	Expression {} 
		| Expression COMMA Expression1 {}
		; 

Var:	/*identifier*/
	IDENT 
	{
		string var = "_" + *($1);
		op.push_back(var);  
	}
     	| /*identifier*/ IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {}
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

