%{

#include "heading.h"
int yylex(void);
void yyerror(const char *s);
void grab_variables();  
void grab_operators_frm_vector(); 
extern int linenum;
extern int col;

int param_val = 0; 
vector <string> func_table; 
std::vector <string> sym_table; 
std::vector <string> sym_type; 
std::vector <string> param_table; 
bool add_to_param_table = false; 
std::vector <string> op;
std::vector <string> mil_vector; 
string temp_string; 
int temp_count; 
int label_count; 
vector <vector <string> > if_label; 
vector <vector <string> > loop_label; 
stack <string> param_queue;
stack <string> read_queue; 
stringstream m; 

//grabs the variables for the COMP rules  
string new_temp_var; 
//grabs appropriate operation from rule 
string grab_operation;
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
Program:	Functions
		;	
	
Functions:	/*empty*/
		| Function Functions
		
		;

beginparam:	BEGIN_PARAMS { add_to_param_table=true;}
          	;

endparam:	END_PARAMS{ add_to_param_table=false;}
		;

Function:	FUNCTION IDENT {func_table.push_back(strdup($2)); cout << "func " << strdup($2) << endl;} SEMICOLON beginparam Declaration1 endparam BEGIN_LOCALS Declaration1 END_LOCALS BEGIN_BODY Statement1 END_BODY 
		{
			for(unsigned int j=0;j<sym_table.size();j++)
			{
				if(sym_type.at(j)=="INTEGER")
					cout<<". "<<sym_table.at(j)<<endl;

				else
					cout<<".[] "<<sym_table.at(j)<<", "<<sym_type.at(j)<<endl;
			}
            		while(!param_table.empty())
            		{
                		cout<<"= "<<param_table.front()<<", $"<<param_val<<endl;
                		param_table.erase(param_table.begin());
                		param_val++;
            		}
            		//STATEMENT PRINT
            		for(unsigned i=0;i<mil_vector.size();i++)
                		cout<<mil_vector.at(i)<<endl;
            		cout<<"endfunc"<<endl;
            		mil_vector.clear();
            		sym_table.clear();
            		sym_type.clear();
            		param_table.clear();
           		param_val=0;
		}
		; 


Declaration1:	/*empty*/ 
				| Declaration SEMICOLON Declaration1 
				;

Declaration:	identifier COLON TYPE 
				;

Statement1:	Statement SEMICOLON Statement1
			| Statement SEMICOLON 
			;

identifier:		IDENT 
				{
					sym_table.push_back(std::string("_") + strdup($1));
            			if(add_to_param_table)
                			param_table.push_back(std::string("_") + strdup($1));
				}
				| IDENT COMMA identifier
				{
					sym_table.push_back(std::string("_") + strdup($1));
					sym_type.push_back("INTEGER");
				}
				;

TYPE:		INTEGER 
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

Statement:  	assign_rule
				| If_rule
				| while_rule
				| do_while_rule
	       		| Read_in
	        	| write_rule
                | CONTINUE
				{
					if (!loop_label.empty())
            		{
						if(loop_label.back().at(0).at(0)=='d')
                    			mil_vector.push_back(":= "+ loop_label.back().at(1)); 
                		else
                    			mil_vector.push_back(":= "+ loop_label.back().at(0));
            		}
        		}
				;

        		| RETURN expression
        		{
            		mil_vector.push_back("ret "+op.back());
            		op.pop_back();
        		}
				;

assign_rule:	IDENT ASSIGN expression
        		{
            		string var = std::string("_") + strdup($1);
            		mil_vector.push_back("= " + var + ", " + op.back() );
            		op.pop_back();
        		}
       			| IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET ASSIGN expression
        		{
            		string var = std::string("_") + strdup($1);
            		string array_result_expression = op.back();
            		op.pop_back();
            		string array_expression = op.back();
            		op.pop_back();
            		mil_vector.push_back(std::string("[]= _") + strdup($1)+", " + array_expression + ", " + array_result_expression); 
        		}
        		;


if_clause:		IF Bool-Expr THEN
        		{
            		label_count++;    
            		m.str("");
            		m.clear();     
            		m<<label_count;
            		string label_1 = "if_condition_true_"+m.str(); 
            		string label_2 = "if_condition_false_"+m.str();
            		string label_3 = "end_if_"+m.str();
            		vector<string> temp;        //temp label vector
            		temp.push_back(label_1);    
            		temp.push_back(label_2);    
           			temp.push_back(label_3);
            		if_label.push_back(temp);   //pushing temp vector onto if label
            		mil_vector.push_back("?:= "+if_label.back().at(0)+", "+op.back());
            		op.pop_back();
            		mil_vector.push_back(":= "+if_label.back().at(1)); 
            		mil_vector.push_back(": "+if_label.back().at(0));    
				}
        		;

else_if:		if_clause Statement1 ELSE
            	{
               		mil_vector.push_back(":= "+if_label.back().at(2));
                	mil_vector.push_back(": "+if_label.back().at(1));
            	}	
            	;

If_rule:		if_clause Statement1 ENDIF
        		{
            		mil_vector.push_back(": "+if_label.back().at(1));
            		if_label.pop_back();
        		}
        		|else_if Statement1 ENDIF 
				{
           			mil_vector.push_back(": "+if_label.back().at(2));
           			if_label.pop_back();
        		}
        		;	

while_key:  WHILE
            {
            	label_count++;
            	m.str("");
            	m.clear();      
            	m<<label_count;
            	string label_1 = "while_loop_"+m.str();
            	string label_2 = "conditional_true_"+m.str();
            	string label_3 = "conditional_false_"+m.str();
            	vector<string> temp;        //temp label vector
            	temp.push_back(label_1);    
            	temp.push_back(label_2);  
            	temp.push_back(label_3);  
            	loop_label.push_back(temp); 
            	mil_vector.push_back(": "+loop_label.back().at(0));
            }
            ;

while_clause: while_key Bool-Expr BEGINLOOP
            {
                mil_vector.push_back("?:= "+loop_label.back().at(1)+", "+op.back());
                op.pop_back();
                mil_vector.push_back(":= "+loop_label.back().at(2));
                mil_vector.push_back(": "+loop_label.back().at(1));
            }
            ;

while_rule:	while_clause Statement1 ENDLOOP 
			{
            	mil_vector.push_back(":= "+loop_label.back().at(0));
            	mil_vector.push_back(": "+loop_label.back().at(2));
            	loop_label.pop_back();
        	}
        	;

do_key:	DO BEGINLOOP
      	{
            label_count++; 
            m.str("");
            m.clear();     
            m<<label_count;
            string label_1 = "do_while_loop_"+m.str();
            string label_2 = "do_while_conditional_check"+m.str();
            vector <string> temp;
            temp.push_back(label_1);
            temp.push_back(label_2);
            loop_label.push_back(temp);
            mil_vector.push_back(": "+label_1);
        }
        ;

do_check: do_key Statement1 ENDLOOP
          {
            	mil_vector.push_back(": "+ loop_label.back().at(1));
          }
          ;

do_while_rule:	     do_check WHILE Bool-Expr 
					{
            			mil_vector.push_back("?:= "+ loop_label.back().at(0)+", "+op.back());
            			op.pop_back();
            			loop_label.pop_back();
        			}
        			;

read_mult:  COMMA IDENT read_mult
            {
                string var = std::string("_") + strdup($2);
                read_queue.push(std::string(".< _") + strdup($2));

            }; 

            | COMMA IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET read_mult
            {
                string var = std::string("_") + strdup($2);
                grab_variables();  
                read_queue.push(".< "+new_temp_var);
                read_queue.push(std::string("[]= _") + strdup($2) + ", " + op.back() + ", " + new_temp_var);
                op.pop_back();
            }
            | /*empty*/
            ;
                                                    
Read_in:	READ IDENT read_mult
        	{                                      
            	string var = std::string("_") + strdup($2);            
            	mil_vector.push_back(std::string(".< _") + strdup($2));
            	while(!read_queue.empty())
            	{
                	mil_vector.push_back(read_queue.top());
                	read_queue.pop();
            	}
        	}; 
        	|READ IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET read_mult
        	{
            	string var = std::string("_") + strdup($2);
            	grab_variables();      
            	mil_vector.push_back(std::string(".< ") +new_temp_var);
            	mil_vector.push_back(std::string("[]= _") + strdup($2)+ ", " + op.back() + ", " + new_temp_var);
            	op.pop_back();
            	while(!read_queue.empty())
            	{
                	mil_vector.push_back(read_queue.top());
                	read_queue.pop();
            	}
        	}
	    	;

comma_mult:		/*empty*/ 
				| COMMA Normal comma_mult 
				;

write_rule:		WRITE Normal comma_mult
        		{
            		while(!op.empty())
            		{
            			string s= op.front();
                		op.erase(op.begin());
                		mil_vector.push_back(".> "+ s);
            		}
            		op.clear();
        		}
				;

Bool-Expr:	relation_exprr
			| Bool-Expr OR relation_exprr 
			{
            		grab_variables();     
            		grab_operation = "|| "; 
            		grab_operators_frm_vector();  
			}
        	;

relation_exprr:	relation_expr 
				| relation_exprr AND relation_expr 
				{
		 			grab_operation = "&& "; 
            		grab_variables(); 
					grab_operators_frm_vector();  
            	}
        		;

relation_expr:	Relation_Expr 
				| NOT Relation_Expr 
        		{
	    			grab_variables(); 
            		string op1 = op.back();
            		op.pop_back();        
           	        mil_vector.push_back("! "+new_temp_var+", "+op1); 
            		op.push_back(new_temp_var);
				}
				;

Relation_Expr:	expression Comp expression
				{
					grab_variables();
					grab_operators_frm_vector(); 
				};

				| TRUE
				{
					grab_variables();             
	    			mil_vector.push_back("= "+new_temp_var+", 1");
            		op.push_back(new_temp_var);
				};

				| FALSE 
				{
					grab_variables();             
	    			mil_vector.push_back("= "+new_temp_var+", 0"); 
            		op.push_back(new_temp_var);
				};	
				| L_PAREN Bool-Expr R_PAREN 
				; 

Comp:	EQ {grab_operation = "== ";};  
	| NEQ {grab_operation = "!= ";};
	| LT {grab_operation = "< ";}; 
	| GT {grab_operation = "> ";}; 
	| LTE {grab_operation = "<= ";}; 
	| GTE {grab_operation = ">= ";}; 
	; 


expression:	mul_expr expradd
		;

expradd:	/*empty*/ 
		| ADD mul_expr expradd
        {
			grab_operation = "+ "; 
            grab_variables();  
           	grab_operators_frm_vector(); 	
        }
		| SUB mul_expr expradd
        {
			grab_operation = "- "; 
            grab_variables();             
	    	grab_operators_frm_vector();  
        }	
		;

mul_expr:	term multi_term 
		;

multi_term:	/*empty*/ 
		| MULT term multi_term 
        {
			grab_operation = "* "; 
           	grab_variables(); 
	    	grab_operators_frm_vector();       	
		}
		; 

		| DIV term multi_term
        {
			grab_operation = "/ "; 
            grab_variables();  
            grab_operators_frm_vector(); 
		}
		;

		| MOD term multi_term
        {
			grab_operation = "% ";
            grab_variables(); 
			grab_operators_frm_vector(); 
	   	}
		;

term:           Normal  { }
                | SUB Normal
                {
 		    		grab_variables();                    
                    mil_vector.push_back("- "+ new_temp_var + ", 0, " +op.back());    
                    op.pop_back(); 
                    op.push_back(new_temp_var); 

                }
                | IDENT Term_1
                {
                    grab_variables();                     
		    		mil_vector.push_back(std::string("call ") + strdup($1) + ", " + new_temp_var);
                    op.push_back(new_temp_var); 
                }
                ;

Term_1:		L_PAREN Expression1 R_PAREN
                {
                    while(!param_queue.empty())
                    {
                        mil_vector.push_back("param "+param_queue.top());
                        param_queue.pop();
                    }
                }
                | L_PAREN R_PAREN {}
                ;


Normal:		var 
                {
                    grab_variables();  
                    string op1=op.back();       
                    if(op1.at(0)=='[') 
                        mil_vector.push_back("=[] "+new_temp_var+", "+op1.substr(3,op1.length()-3));
                    else 
                        mil_vector.push_back("= "+ new_temp_var+", "+op.back());    
                    op.pop_back(); 
                    op.push_back(new_temp_var);
                }
                | NUMBER
                {
                    grab_variables();  
                    stringstream ss;
                    ss << $1;
                    mil_vector.push_back("= "+ new_temp_var +", "+ ss.str());
                    op.push_back(new_temp_var);
                }
                | L_PAREN expression R_PAREN
                ;

Expression1:    expression
                {
                    param_queue.push(op.back());
                    op.pop_back();
                }
                | expression COMMA Expression1
                {
                    param_queue.push(op.back());
                    op.pop_back();
                }
                ;

var:            IDENT
                {
                    string var = std::string("_") + strdup($1); 
                    op.push_back(var);
                }
                | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET
                {
                    string op1 = op.back();
                    op.pop_back();
                    string var = std::string("_") + strdup($1);
                    op.push_back("[] " + var + ", " + op1);
                }
                ;
                
%%
void grab_variables() {
            m.str("");
            m.clear();   
            m<<temp_count;   
            temp_count++;
            new_temp_var=std::string("_temp_")+ m.str();  
            sym_table.push_back(new_temp_var);  
            sym_type.push_back("INTEGER"); 
}

void grab_operators_frm_vector(){
	    string op2 = op.back();
            op.pop_back();
            string op1 = op.back();
            op.pop_back();
            mil_vector.push_back(grab_operation + new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
}

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

