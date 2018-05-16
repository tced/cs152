%{
int yyerror (char *s); 
int yylex (void); 
%}

%union{
int val; 
string* op_val; 
}
%start Program

%token FUNCTION BEGINPARAMS ENDPARAMS BEGINBODY ENDBODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE TRUE FALSE SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN RETURN 
%token <val> NUMBERS
%token <op_val> IDENTIFIERS
%left MULT DIV MOD ADD SUB 
%left LT LTE GT GTE EQ NEQ
%right NOT
%left AND OR 
%right ASSIGN 

%% 

Program: Functions { cout << "Program->functions\n";}
     ;

Functions: /*empty*/ {cout << "Function->epsilon\n";}
         | Function Functions {cout <<"Functions -> Function Functions\n";}
         ;

Function: FUNCTION IDENTIFIERS SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration2 END_LOCALS BEGIN_BODY Statement1 SEMICOLON END_BODY {cout <<"FUNCTION IDENT " <<*($2) <<" SEMICOLON BEGIN_PARAMS Declaration1 END_PARAMS BEGIN_LOCALS Declaration1 END_LOCALS BEGIN_BODY Statement1 SEMICOLON END_BODY\n";}
         ;

Declaration1:/*empty*/ {cout << "Declaraction->epsilon\n";}  
            | Declaration SEMICOLON Declaration1 {cout << "Declaration SEMICOLON Declaration1\n";}
         ; 

Declaraction2: /*empty*/ {cout << "Declaraction->epsilon\n";}
            | Declaraction SEMICOLON Declaraction2 {cout << "Declaration SEMICOLON Declaraction2\n";}
         ;

Statement1: Statement SEMICOLON Statement1 {cout << "Statement SEMICOLON Statement1\n";} 
            | Statement SEMICOLON {cout << "Statement SEMICOLON\n";}
            ;

Declaration: IDENTIFIERS COMMA Declaration {cout << "IDENT " <<*($1) << " COMMA Declaration\n";}
            | IDENTIFIERS COLON INTEGER
            | IDENTIFIERS COLON array L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER 
            
%%
int yyerror(string s)
{
   extern int row, column; 
   extern char *yytext;
   
   cerr << "SYNTAX(PARSER) Error at line ""<<row<<", column "<<column<<" : Unexpected Symbol \"" << yytext << "\" Encountered." << endl; 
   exit(1); 
}
int yyerror(char *s)
{
  return yyerror(string(s)); 
 }
