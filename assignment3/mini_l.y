%{

#include "heading.h"
int yylex(void);
void yyerror(const char *s); 
extern int linenum;
extern int col;

int param_val = 0; 
vector <string> func_table; 
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
Program:	functions
		;	
	
functions:	/*empty*/
		| function functions
		
		;
function_name: FUNCTION IDENT
             {
                func_table.push_back(strdup($2));
                cout <<"func "<< strdup($2) <<endl;
             }
             ;
beginparam: BEGIN_PARAMS
          {
              add_to_param_table=true;
          }
          ;
endparam:   END_PARAMS
        {
            add_to_param_table=false;
        }
        ;
function:	function_name SEMICOLON beginparam declarations endparam BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY 
		{
			//func_table.push_back( strdup($2));
            //cout <<"func "<< strdup($2)<<endl;
            //VARIABLE AND PARAMETER DECLARATIONS
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
            for(unsigned i=0;i<stmnt_vctr.size();i++)
                cout<<stmnt_vctr.at(i)<<endl;
            cout<<"endfunc"<<endl;
            stmnt_vctr.clear();
            sym_table.clear();
            sym_type.clear();
            param_table.clear();
            param_val=0;

		}
		; 


declarations:	/*empty*/ 
		        | declaration SEMICOLON declarations 
		        ;

declaration:	id COLON assign 
		;

id:		IDENT 
		{
			sym_table.push_back(std::string("_") + strdup($1));
            if(add_to_param_table)
                param_table.push_back(std::string("_") + strdup($1));
		}
		| IDENT COMMA id 
		{
			sym_table.push_back(std::string("_") + strdup($1));
			sym_type.push_back("INTEGER");
		}
		;

assign:		INTEGER 
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

statements:	statement SEMICOLON statements
		    | statement SEMICOLON 
		    ;

statement:  aa
		    | bb
		    | cc
		    | dd
	       	| ee
            | ff
            | gg
        	| hh
            ;
aa:		IDENT ASSIGN expression
        {
            string var = std::string("_") + strdup($1);
            stmnt_vctr.push_back("= " + var + ", " + op.back() );
            op.pop_back();
            //cout<<op.size()<<endl;    TEST
            //op.clear()  //REMOVE AFTER TESTING
        }
        | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET ASSIGN expression
        {
            string var = std::string("_") + strdup($1);
            string array_result_expression = op.back();
            op.pop_back();
            string array_expression = op.back();
            op.pop_back();
            stmnt_vctr.push_back(std::string("[]= _") + strdup($1)+", " + array_expression + ", " + array_result_expression); 
        }
        ;


if_clause:		IF boolean_expr THEN
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
            stmnt_vctr.push_back("?:= "+if_label.back().at(0)+", "+op.back());
            op.pop_back();
            stmnt_vctr.push_back(":= "+if_label.back().at(1)); 
            stmnt_vctr.push_back(": "+if_label.back().at(0));    

        }
        ;

else_if:    if_clause statements ELSE
            {
                stmnt_vctr.push_back(":= "+if_label.back().at(2));
                stmnt_vctr.push_back(": "+if_label.back().at(1));
            }
            ;

bb:	    if_clause statements ENDIF
        {
            stmnt_vctr.push_back(": "+if_label.back().at(1));
            if_label.pop_back();
        }
        |else_if statements ENDIF 
		{
           stmnt_vctr.push_back(": "+if_label.back().at(2));
           if_label.pop_back();             //END_LOOP_HERE
        }
        ;

while_key:  WHILE
         {
            label_count++;
            m.str("");
            m.clear();      
            m<<label_count;
            string label_1 = "while_loop_"+m.str();  // loop label
            string label_2 = "conditional_true_"+m.str();  //if condition == true label
            string label_3 = "conditional_false_"+m.str();  //if contiditon == false label
            vector<string> temp;        //temp label vector
            temp.push_back(label_1);    
            temp.push_back(label_2);  
            temp.push_back(label_3);  
            loop_label.push_back(temp); 
            stmnt_vctr.push_back(": "+loop_label.back().at(0));
         }
         ;
while_clause: while_key boolean_expr BEGINLOOP
            {
                stmnt_vctr.push_back("?:= "+loop_label.back().at(1)+", "+op.back());
                op.pop_back();
                stmnt_vctr.push_back(":= "+loop_label.back().at(2));
                stmnt_vctr.push_back(": "+loop_label.back().at(1));
            }
            ;

cc:		 while_clause statements ENDLOOP 
		{
            stmnt_vctr.push_back(":= "+loop_label.back().at(0));
            stmnt_vctr.push_back(": "+loop_label.back().at(2));
            loop_label.pop_back();
        }
        ;

do_key: DO BEGINLOOP
      {
            label_count++; 
            m.str("");
            m.clear();     
            m<<label_count;
            string label_1 = "do_while_loop_"+m.str();  // do_while_loop label
            string label_2 = "do_while_conditional_check"+m.str(); //if condition == true label
            vector <string> temp;
            temp.push_back(label_1);
            temp.push_back(label_2);
            loop_label.push_back(temp);
            stmnt_vctr.push_back(": "+label_1);
        }
        ;

do_check: do_key statements ENDLOOP
        {
            stmnt_vctr.push_back(": "+ loop_label.back().at(1));
        }
dd:	     do_check WHILE boolean_expr 
		{
            stmnt_vctr.push_back("?:= "+ loop_label.back().at(0)+", "+op.back());
            //if condition is false only return first pass through loop
            op.pop_back();
            loop_label.pop_back();
        }
        ;

read_mult:  COMMA IDENT read_mult
            {
                string var = std::string("_") + strdup($2);
                read_queue.push(std::string(".< _") + strdup($2));

            }
            | COMMA IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET read_mult
            {
                string var = std::string("_") + strdup($2);
                m.str("");
                m.clear();                             
                m<<temp_var_count;                  
                temp_var_count++;                       
                string new_temp_var='t'+ m.str();       
                sym_table.push_back(new_temp_var);    
                sym_type.push_back("INTEGER");  
                read_queue.push(".< "+new_temp_var);
                read_queue.push(std::string("[]= _") + strdup($2) + ", " + op.back() + ", " + new_temp_var);
                op.pop_back();
            }
            | /*empty*/
            ;
                                                    
ee:		READ IDENT read_mult
        {                                      
            string var = std::string("_") + strdup($2);            
            stmnt_vctr.push_back(std::string(".< _") + strdup($2));
            while(!read_queue.empty())
            {
                stmnt_vctr.push_back(read_queue.top());
                read_queue.pop();
            }
        }
        |READ IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET read_mult
        {
            string var = std::string("_") + strdup($2);
            m.str("");
            m.clear();                            
            m<<temp_var_count;               
            temp_var_count++;                       
            string new_temp_var='t'+ m.str();     
            sym_table.push_back(new_temp_var);  
            sym_type.push_back("INTEGER");      
            stmnt_vctr.push_back(std::string(".< ") +new_temp_var);
            stmnt_vctr.push_back(std::string("[]= _") + strdup($2)+ ", " + op.back() + ", " + new_temp_var);
            op.pop_back();
            while(!read_queue.empty())
            {
                stmnt_vctr.push_back(read_queue.top());
                read_queue.pop();
            }
        }
	    ;

ii:		/*empty*/ 
		| COMMA posterm ii 
		
        ;

ff:		WRITE posterm ii
        {
            while(!op.empty())
            {
            	string s= op.front();
                op.erase(op.begin());
                stmnt_vctr.push_back(".> "+ s);
            }
            op.clear();
        }
		;

gg:		CONTINUE 
        {
            if (!loop_label.empty())
            {
                if(loop_label.back().at(0).at(0)=='d')
                    stmnt_vctr.push_back(":= "+ loop_label.back().at(1)); 
                else
                    stmnt_vctr.push_back(":= "+ loop_label.back().at(0));
            }
        }
		;

hh:		RETURN expression
        {
            stmnt_vctr.push_back("ret "+op.back());
            op.pop_back();
        }
		;

boolean_expr:	relation_exprr
		| boolean_expr OR relation_exprr 
		{
            m.str("");
            m.clear();                             
            m<<temp_var_count;                    
            temp_var_count++;
            string new_temp_var='t'+ m.str();      
            sym_table.push_back(new_temp_var);   
            sym_type.push_back("INTEGER");     
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("|| "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }
        ;

relation_exprr:	relation_expr 
		| relation_exprr AND relation_expr 
		{
            m.str("");
            m.clear();                      
            m<<temp_var_count;
            temp_var_count++;
            string new_temp_var='t'+ m.str();      
            sym_table.push_back(new_temp_var);  
            sym_type.push_back("INTEGER");  
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("&& "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var); 
        }

        ;

relation_expr:	rexpr
		| NOT rexpr
        {
            m.str("");
            m.clear();      
            m<<temp_var_count;  
            temp_var_count++;
            string new_temp_var='t'+ m.str(); 
            sym_table.push_back(new_temp_var); 
            sym_type.push_back("INTEGER");  
            string op1 = op.back();
            op.pop_back();        
            stmnt_vctr.push_back("! "+new_temp_var+", "+op1); 
            op.push_back(new_temp_var);

        }
		;

rexpr:	expression EQ expression
        {
            m.str("");
            m.clear();       
            m<<temp_var_count;       
            temp_var_count++;
            string new_temp_var='t'+ m.str();  
            sym_table.push_back(new_temp_var);   
            sym_type.push_back("INTEGER");    
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("== "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }
		| expression NEQ expression
        {
            m.str("");
            m.clear();             
            m<<temp_var_count;              
            temp_var_count++;
            string new_temp_var='t'+ m.str();    
            sym_table.push_back(new_temp_var); 
            sym_type.push_back("INTEGER"); 
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("!= "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }

        | expression LT expression 
        {
            m.str("");
            m.clear();
            m<<temp_var_count;
            temp_var_count++;
            string new_temp_var='t'+ m.str(); 
            sym_table.push_back(new_temp_var); 
            sym_type.push_back("INTEGER");
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("< "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }
        | expression GT expression 
        {
            m.str("");
            m.clear();      
            m<<temp_var_count; 
            temp_var_count++;
            string new_temp_var='t'+ m.str(); 
            sym_table.push_back(new_temp_var);
            sym_type.push_back("INTEGER"); 
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("> "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }
        | expression LTE expression 
        {
            m.str("");
            m.clear();           
            m<<temp_var_count;  
            temp_var_count++;
            string new_temp_var='t'+ m.str(); 
            sym_table.push_back(new_temp_var); 
            sym_type.push_back("INTEGER"); 
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("<= "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }
        | expression GTE expression 
        {
            m.str("");
            m.clear();
            m<<temp_var_count;  
            temp_var_count++;
            string new_temp_var='t'+ m.str(); 
            sym_table.push_back(new_temp_var);
            sym_type.push_back("INTEGER"); 
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back(">= "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var);
        }
        |TRUE
        {
            m.str("");
            m.clear();   
            m<<temp_var_count;
            temp_var_count++;
            string new_temp_var='t'+ m.str();
            sym_table.push_back(new_temp_var);
            sym_type.push_back("INTEGER"); 
            stmnt_vctr.push_back("= "+new_temp_var+", 1");
            op.push_back(new_temp_var);
        }
		| FALSE
        {
            m.str("");
            m.clear();       
            m<<temp_var_count;   
            temp_var_count++;
            string new_temp_var='t'+ m.str();   
            sym_table.push_back(new_temp_var);
            sym_type.push_back("INTEGER");  
            stmnt_vctr.push_back("= "+new_temp_var+", 0"); 
            op.push_back(new_temp_var);
        }
		| L_PAREN boolean_expr R_PAREN 
        ;		


expression:	mul_expr expradd
		;

expradd:	/*empty*/ 
		| ADD mul_expr expradd
        {
            m.str("");
            m.clear();                              //clearing string stream for conversion from int to str
            m<<temp_var_count;                      //feeding int to stringstream
            temp_var_count++;
            string new_temp_var='t'+ m.str();       //creating temp variable name
            sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
            sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("+ "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var); //pushing new temp variable

        }
		| SUB mul_expr expradd
        {
            //- t[temp_var_num],second_to_last_operand,last_operand_from_vector
            m.str("");
            m.clear();                              //clearing string stream for conversion from int to str
            m<<temp_var_count;                      //feeding int to stringstream
            temp_var_count++;
            string new_temp_var='t'+ m.str();       //creating temp variable name
            sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
            sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("- "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var); //pushing new temp variable
        }
		;

mul_expr:	term multi_term 
		;

multi_term:	/*empty*/ 
		| MULT term multi_term 
        {
            // t[temp_var_num],second_to_last_operand,last_operand_from_vector
            m.str("");
            m.clear();                              //clearing string stream for conversion from int to str
            m<<temp_var_count;                      //feeding int to stringstream
            temp_var_count++;
            string new_temp_var='t'+ m.str();       //creating temp variable name
            sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
            sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("* "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var); //pushing new temp variable
        }
		| DIV term multi_term
        {
            // / t[temp_var_num],second_to_last_operand,last_operand_from_vector
            m.str("");
            m.clear();                              //clearing string stream for conversion from int to str
            m<<temp_var_count;                      //feeding int to stringstream
            temp_var_count++;
            string new_temp_var='t'+ m.str();       //creating temp variable name
            sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
            sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("/ "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var); //pushing new temp variable
        }

		| MOD term multi_term
        {
            //% t[temp_var_num],second_to_last_operand,last_operand_from_vector
            m.str("");
            m.clear();                              //clearing string stream for conversion from int to str
            m<<temp_var_count;                      //feeding int to stringstream
            temp_var_count++;
            string new_temp_var='t'+ m.str();       //creating temp variable name
            sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
            sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table
            string op2 = op.back();
            op.pop_back();
            string op1 =op.back();
            op.pop_back();
            stmnt_vctr.push_back("% "+ new_temp_var + ", "+op1+", "+op2);    
            op.push_back(new_temp_var); //pushing new temp variable
        }

		;

term:           posterm 
                {
                    //empty transition. Last operand on stack si still a valid part
                }
                | SUB posterm
                {
                    //UNARY MINUS: -value = 0 - value
                    //- t[temp_var_num],0,[last_var in operand list]
                    m.str("");
                    m.clear();                              //clearing string stream for conversion from int to str
                    m<<temp_var_count;                      //feeding int to stringstream
                    temp_var_count++;
                    string new_temp_var='t'+ m.str();       //creating temp variable name
                    sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
                    sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table 
                    stmnt_vctr.push_back("- "+ new_temp_var + ", 0, " +op.back());    
                    op.pop_back();  //removing the old variable and replacing with new temp variable 
                    op.push_back(new_temp_var); //pushing new temp variable

                }
                | IDENT term_iden
                {
                    //calling functions
                    m.str("");
                    m.clear();                       //clearing string stream for conversion from int to str
                    m<<temp_var_count;                  //feeding int to stringstream
                    temp_var_count++;
                    string new_temp_var='t'+ m.str();       //creating temp variable name
                    sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
                    sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table
                    stmnt_vctr.push_back(std::string("call ") + strdup($1) + ", " + new_temp_var);
                    op.push_back(new_temp_var); 
                }
                ;

posterm:        var                 //THIS ENTIRE STEP  IS NOT REDUNDANT__IT IS ABSOLUTELY NECESSARY TO MAINTAIN THE 3 ADDRESS MODE
                                    //This has been used to remove the identifiers from the symbol table, and replace them with 
                                    // temporary variables. This reduces teh number of places where identifier checks have been 
                                    //performed to just one.
                {
                    //= t[temp_var_num], [var in operand list]
                    m.str("");
                    m.clear();                       //clearing string stream for conversion from int to str
                    m<<temp_var_count;                  //feeding int to stringstream
                    temp_var_count++;
                    string new_temp_var='t'+ m.str();       //creating temp variable name
                    sym_table.push_back(new_temp_var);      //adding temporary variable to symbol table
                    sym_type.push_back("INTEGER");          //adding datatype for the temp var to symbol table 
                    string op1=op.back();       
                    if(op1.at(0)=='[')                  //Copy Statement for array elements
                        stmnt_vctr.push_back("=[] "+new_temp_var+", "+op1.substr(3,op1.length()-3));
                    else                                    //Copy statement for normal variables
                        stmnt_vctr.push_back("= "+ new_temp_var+", "+op.back());    
                    op.pop_back();  //removing the old variable and replacing with new temp variable 
                    op.push_back(new_temp_var);
                }
                | NUMBER
                {
                    // t[temp_var_num] =39
                    //.= t[temp_var_num],39 
                    m.str("");
                    m.clear(); 
                    m<<temp_var_count; 
                    temp_var_count++; 
                    string new_temp_var='t'+ m.str();
                    sym_table.push_back(new_temp_var); 
                    sym_type.push_back("INTEGER"); 
                    stringstream ss;
                    ss << $1;
                    stmnt_vctr.push_back("= "+ new_temp_var +", "+ ss.str());
                    op.push_back(new_temp_var);
                }
                | L_PAREN expression R_PAREN
                ;

term_iden:      L_PAREN term_ex R_PAREN
                {
                    while(!param_queue.empty())
                    {
                        stmnt_vctr.push_back("param "+param_queue.top());
                        param_queue.pop();
                    }
                }
                | L_PAREN R_PAREN
                {
                }
                ;

term_ex:        expression
                {
                    param_queue.push(op.back());
                    op.pop_back();
                }
                | expression COMMA term_ex
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

