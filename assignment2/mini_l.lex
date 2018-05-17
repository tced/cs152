/*	CS152 Spring2018
	Flex scanner for mini_l
	Written in C++ by Andrea Cruz Castillo and Tiffany Cedeno	
*/

%{
	#include <stdio.h>
 	#include <stdlib.h>
        int yylex(void); 
        #include "y.tab.h"
        int yyerror(char *s); 
%}  
	int linenum = 1, col = 1;
number [0-9]
underscore "_"
identifier [a-zA-Z]+([_0-9]+[a-zA-Z0-9])*
comment "##"+.*

%%

"function"			{col += yyleng; return FUNCTION;}
"beginparams"			{col += yyleng; return BEGIN_PARAMS;}
"endparams"			{col += yyleng; return END_PARAMS;}
"beginlocals"			{col += yyleng; return BEGIN_LOCALS;}
"endlocals"			{col += yyleng; return END_LOCALS;}
"beginbody"			{col += yyleng; return BEGIN_BODY;}
"endbody"			{col += yyleng; return END_BODY;}
"integer"			{col += yyleng; return INTEGER;}
"array"				{col += yyleng; return ARRAY;} 
"of"				{col += yyleng; return OF;}	
"if"				{col += yyleng; return IF;}
"then"				{col += yyleng; return THEN;}
"endif"				{col += yyleng; return ENDIF;}
"else"				{col += yyleng; return ELSE;}
"while"				{col += yyleng; return WHILE;}
"do"				{col += yyleng; return DO;}
"beginloop"			{col += yyleng; return BEGINLOOP;}
"endloop"			{col += yyleng; return ENDLOOP;}
"continue"			{col += yyleng; return CONTINUE;}
"read"				{col += yyleng; return READ;}
"write"				{col += yyleng; return WRITE;}
"and"				{col += yyleng; return AND;}
"or"				{col += yyleng; return OR;}
"not"				{col += yyleng; return NOT;}
"true"				{col += yyleng; return TRUE;}
"false"				{col += yyleng; return FALSE;}
"return"			{col += yyleng; return RETURN;}


"-"				{col += yyleng; return SUB;}
"*"				{col += yyleng; return MULT;}
"/"				{col += yyleng; return DIV;}
"%"				{col += yyleng; return MOD;}
"+"				{col += yyleng; return ADD;}
"=="				{col += yyleng; return EQ;} 
"<>"				{col += yyleng; return NEQ;}
"<"				{col += yyleng; return LT;}
">"				{col += yyleng; return GT;}
"<="				{col += yyleng; return LTE;}
">="				{col += yyleng; return GTE;}

{number}+			{col += yyleng; yylval.sval = yytext; return NUMBER;}
{identifier}			{col += yyleng; yylval.sval = yytext; return IDENT;}
";"				{col += yyleng; return SEMICOLON;}
":"				{col += yyleng; return COLON;}
","				{col += yyleng; return COMMA;}
"("				{col += yyleng; return L_PAREN;}
")"				{col += yyleng; return R_PAREN;}
"["				{col += yyleng; return L_SQUARE_BRACKET;}
"]"				{col += yyleng; return R_SQUARE_BRACKET;}
":="				{col += yyleng; return ASSIGN;}

{comment}			{/*ignore comment*/ col = 1; linenum++;}
"\n"				{linenum++; col = 1;}
({number}|{underscore})+{identifier}*   {printf("Error at line %d, column %d: identifer \"%s\" must begin with a letter\n", linenum, col, yytext); exit(0);}
{identifier}{underscore}+	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore", linenum, col, yytext); exit(0);}
[ \t]+	{/*ignore spaces*/ col += yyleng;}
.	{printf("Error at line %d column %d: unrecognied symbol \"%s\"\n", linenum, col, yytext); exit(0);}

%%
