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
%token <val> number
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
            | IDENTIFIERS COLON INTEGER {cout << "IDENT " << *($1) << " COLON INTEGER\n";}
            | IDENTIFIERS COLON array L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER {cout << "IDENT "<< *($1) << " COLON array L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER}
            ;

Statement: Var1 ASSIGN Expression {cout << "Var1 ASSIGN Expression\n";}
         | IF Bool-Expr THEN Statement2 ENDIF {cout << "IF Bool-Expr THEN Statement2 ENDIF\n";} 
         | WHILE Bool-Expr BEGINLOOP Statement3 ENDLOOP 
         | do BEGINLOOP Statement3 ENDLOOP while Bool-Expr 
         | READ Var1
         | WRITE Var1
         | CONTINUE
         | RETURN Expression 
         ;

Statement2: Statement SEMICOLON
           | ELSE Statement2
          ; 
Statement3: Statement SEMICOLON Statement3  
           | Statement SEMICOLON
           ;

Var1: Var COMMA Var1 
     | Var 
     ;

Bool-Expr: Relation-And-Expr 
           | Relation-And-Expr OR Relation-And-Expr
         ; 

Relation-And-Expr: Relation-Expr 
                  | Relation-Expr AND Relation-Expr
                  ;

Relation-Expr: NOT Relation-Expr 
              | Expression Comp Expression 
              | TRUE 
              | FALSE 
              | L_PAREN Bool-Expr R_PAREN
              ; 

Comp: EQ | NEQ |  LT | GT | LTE | GTE 

Expression: Multiplicative-Expr 
           | SUB Multiplicative-Expr 
           | ADD Multiplicative-Expr 
           | SUB ADD Multiplicative-Expr  
           ;

Multiplicative-Expr: Term 
                    | Term MULT Term 
                    | Term MULT Term DIV Term 
                    | Term MULT Term DIV Term MOD Term
                    | Term DIV Term
                    | Term DIV Term MOD Term
                    | Term MOD Term
                    | Term MULT Term MOD Term
                    | Term DIV Term
                    ;

Term: SUB Term
      | Var1 | number | L_PAREN Expression R_PAREN 
      | identifier L_PAREN Expression1 R_PAREN 

Expression1: Expression COMMA Expression1 
             | Expression COMMA 
             | /*empty*/ 

Var: IDENTIFIERS
     | IDENTIFIERS L_SQUARE_BRACKET Expression R_SQUARE_BRACKET
            
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
