%{

#include "heading.h"
int yylex(void);
void yyerror(const char *s); 
extern int linenum;
extern int col;

int param_val = 0; 
std::vector <string> func_table; 
std::vector <string> sym_table; 
std::vector <string> sym_type; 
std::vector <string> param_table; 
bool add_to_param_table = false; 
std::vector <string> op;
std::vector <string> stmnt_vctr; 
string temp_string; 
int temp_var_count; 
int label_count; 
vector <vector <string> > if_label; 
vector <vector <string> > loop_label; 
stack <string> param_queue;
stack <string> read_queue; 
stringstream m; 
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
	
		   	while(!param_table.empty()){
                		cout<<"= "<<param_table.front()<<", $"<<param_val<<endl;
                		param_table.erase(param_table.begin());
                		param_val++;
            	   	}
		   	//STATEMENT PRINT
            	   	for(unsigned i=0;i<stmnt_vctr.size();i++)
                		cout<<stmnt_vctr.at(i)<<endl;
                   	cout <<"endfunc" << endl; 
		   	stmnt_vctr.clear();
            	   	sym_table.clear();
            	   	sym_type.clear();
            	   	param_table.clear();
            	   	param_val=0;
		 } 
         	| error{ yyerrok; yyclearin;}
		;

Declaration1:	/*empty*/ {}  
            	| Declaration SEMICOLON Declaration1 {}
                ; 

Declaration:	Identifier COLON Type {}
		| error{yyerrok; yyclearin;}
		;

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
Type:		INTEGER 
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

Statement:	Var ASSIGN Expression 
		{
			
		} 
           	| if_rule
           	| while_rule
           	| do_while_rule  
           	| read_in 
           	| WRITE comma_mult
			{
				while(!op.empty())
           			{
            				string s= op.front();
                			op.erase(op.begin());
                			stmnt_vctr.push_back(".> "+ s);
                		}
            			op.clear();
		  	}
           	| CONTINUE
			{
				  if (!loop_label.empty())
            			  {
                			if(loop_label.back().at(0).at(0)=='d')
                    				stmnt_vctr.push_back(":= "+ loop_label.back().at(1)); 
                			else
                    				stmnt_vctr.push_back(":= "+ loop_label.back().at(0));
            			  }
			}
           	| RETURN Expression
			{
				stmnt_vctr.push_back("ret "+op.back());
            			op.pop_back();
			}
	   	| error {yyerrok; yyclearin;}
           	;

if_rule:	if_condition Statement1 ENDIF
			{
				stmnt_vctr.push_back(": "+if_label.back().at(1));
            			if_label.pop_back(); 
			}
		| else_condition Statement1 ENDIF
			{
				stmnt_vctr.push_back(": "+if_label.back().at(2));
           			if_label.pop_back();             
			}
		;

if_condition:	IF Bool-Expr THEN
			{
				label_count++;
            			m.str("");
            			m.clear();     
            			m<<label_count;
            			string label_1 = "if_condition_true_"+m.str(); 
            			string label_2 = "if_condition_false_"+m.str();
            			string label_3 = "end_if_"+m.str();   
            			vector<string> temp;       
            			temp.push_back(label_1);    
            			temp.push_back(label_2);    
            			temp.push_back(label_3);
            			if_label.push_back(temp);  
            			stmnt_vctr.push_back("?:= "+if_label.back().at(0)+", "+op.back());
            			op.pop_back();
            			stmnt_vctr.push_back(":= "+if_label.back().at(1));  
            			stmnt_vctr.push_back(": "+if_label.back().at(0));      
			}
		;

else_condition:	if_condition Statement1 ELSE   
			{
				stmnt_vctr.push_back(":= "+if_label.back().at(2));
                		stmnt_vctr.push_back(": "+if_label.back().at(1));
			}
		; 

while_rule:	while_condition Statement1 ENDLOOP
			{
				  stmnt_vctr.push_back(":= "+loop_label.back().at(0));
            			  stmnt_vctr.push_back(": "+loop_label.back().at(2));
            			  loop_label.pop_back();
			}
		; 

while_condition:	WHILE Bool-Expr BEGINLOOP
			{
				label_count++; 
            			m.str("");
            			m.clear(); 
            			m<<label_count;
            			string label_1 = "while_loop_"+m.str();
            			string label_2 = "conditional_true_"+m.str(); 
            			string label_3 = "conditional_false_"+m.str();
            			vector<string> temp;   
            			temp.push_back(label_1);
            			temp.push_back(label_2);   
            			temp.push_back(label_3);   
            			loop_label.push_back(temp);   
            			stmnt_vctr.push_back(": "+loop_label.back().at(0));  
			
				stmnt_vctr.push_back("?:= "+loop_label.back().at(1)+", "+op.back());
                		op.pop_back();
                		stmnt_vctr.push_back(":= "+loop_label.back().at(2));
                		stmnt_vctr.push_back(": "+loop_label.back().at(1));
			}
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
     	| /*identifier*/ IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET 
	{
		string op1 = op.back();
                op.pop_back();
                string var = "_"+*($1);
                op.push_back("[] " + var + ", " + op1);
	}
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

