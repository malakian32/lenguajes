%{
#include "y.tab.h"
%}
%%
[1-9][0-9]*|0               {yylval.num = atoi(yytext); return number;}
"+"|"-"|"*"|"/"|"dot"       {return op;}
"--view"                    {return view;}
"--save"                    {return save;}
[a-zA-Z]+                   {yylval.str = yytext; return fileName;}
[ \t\n]                     ;
[=;|$]           	        {return yytext[0];}
.                           {ECHO; yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}

