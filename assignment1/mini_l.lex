/*
	Mini_L Analyzer
	mini_l.lex written in c++
	Description: This lexical analyzer outputs the
		     list of tokens identified from an
		     inputted Mini_L program.
  [a-zA-Z0-9_]*([a-zA-Z0-9])+
  ""#"*[ \t]*" "*(" "*[a-z]|[A-Z]|[0-9])*
*/

 
%{
  #include <iostream>
  using namespace std;
  int col = 0, linenum = 1;
%}
number	[0-9]
alphabet [a-z]|[A-Z]
identifier ([a-z]|[A-Z])+?"_"*[a-zA-Z0-9]+

endsw_ ([a-z]|[A-Z])+"_"
beginsw ("_"|[0-9])+
comment "##""#"*[ \t]*" "*(" "*[a-z]|[A-Z]|[0-9])*
commentb ^"##".*

%%
"function"			{cout << "FUNCTION " << endl; col += yyleng;}
"beginparams"			{cout << "BEGIN_PARAMS " << endl; col += yyleng;}
"endparams"			{cout << "END_PARAMS " << endl; col += yyleng;}
"beginlocals"			{cout << "BEGIN_LOCALS " << endl; col += yyleng;}
"endlocals"			{cout << "END_LOCALS " << endl; col += yyleng;}
"beginbody"			{cout << "BEGIN_BODY " << endl; col += yyleng;}
"endbody"			{cout << "END_BODY " << endl; col += yyleng;}
"integer"			{cout << "INTEGER " << endl; col += yyleng;}
"array"				{cout << "ARRAY " << endl; col += yyleng;}
"of"				{cout << "OF " << endl; col += yyleng;}
"if"				{cout << "IF " << endl; col += yyleng;}
"then"				{cout << "THEN " << endl; col += yyleng;}
"endif"				{cout << "ENDIF " << endl; col += yyleng;}
"else"				{cout << "ELSE " << endl; col += yyleng;}
"while"				{cout << "WHILE " << endl; col += yyleng;}
"do"				{cout << "DO " << endl; col += yyleng;}
"beginloop"			{cout << "BEGINLOOP " << endl; col += yyleng;}
"endloop"			{cout << "ENDLOOP " << endl; col += yyleng;}
"continue"			{cout << "CONTINUE " << endl; col += yyleng;}
"read"				{cout << "READ " << endl; col += yyleng;}
"write"				{cout << "WRITE " << endl; col += yyleng;}
"and"				{cout << "AND " << endl; col += yyleng;}
"or"				{cout << "OR " << endl; col += yyleng;}
"not"				{cout << "NOT " << endl; col += yyleng;}
"true"				{cout << "TRUE " << endl; col += yyleng;}
"false"				{cout << "FALSE " << endl; col += yyleng;}
"return"			{cout << "RETURN " << endl; col += yyleng;}


"-"				{cout << "SUB" << endl; col += yyleng;}
"*"				{cout << "MULT" << endl; col += yyleng;}
"/"				{cout << "DIV" << endl; col += yyleng;}
"%"				{cout << "MOD" << endl; col += yyleng;}
"+"				{cout << "ADD " << endl; col += yyleng;}
"=="				{cout << "EQ" << endl; col += yyleng;}
"<>"				{cout << "NEQ " << endl; col += yyleng;}
"<"				{cout << "LT " << endl; col += yyleng;}
">"				{cout << "GT " << endl; col += yyleng;}
"<="				{cout << "LTE " << endl; col += yyleng;}
">="				{cout << "GTE " << endl; col += yyleng;}

{number}+			{cout << "NUMBER " << yytext << endl; col += yyleng;}
{identifier}			{cout << "IDENT " << yytext << endl; col += yyleng;}
";"				{cout << "SEMICOLON "  << endl; col += yyleng;}
":"				{cout << "COLON " << endl; col += yyleng;}
","				{cout << "COMMA " << endl; col += yyleng;}
"("				{cout << "L_PAREN" << endl; col += yyleng;}
")"				{cout << "R_PAREN" << endl; col += yyleng;}
"["				{cout << "L_SQUARE_BRACKET " << endl; col += yyleng;}
"]"				{cout << "R_SQUARE_BRACKET " << endl; col += yyleng;}
":="				{cout << "ASSIGN " << endl; col += yyleng;}

{commentb}			{/* ignore comment block*/ col = 0; linenum++;}
{comment}			{/*ignore comment----add blank spaces*/ col = 0; linenum++;}
[ \t]+				{ /*ignore tabs*/ col += yyleng;}
"\n"				{linenum++; col = 0;}
{beginsw}            		{cout << "Error at line " << linenum << ", column " << col << ": identifer " <<  yytext << " must begin with a letter\n"; exit(0);}
{endsw_}			{cout << "Error at line " << linenum << ", column " << col << ": identifier " << yytext << " cannot end with an underscore" << endl; exit(0);}
.				{cout << "Error at line " << linenum << ", column " << col << ": unrecognized symbol " << yytext << endl; exit(0);}


%%
main() 
{
   yylex();
}
