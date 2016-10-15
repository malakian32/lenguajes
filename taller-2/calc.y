%{
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
void add(int val);
void addRow();
%}

%union {int num; char id;}         /* Yacc definitions */
%start line
%token op
%token <num> number
%type <num> term 

%%

/* calc 1 2 3|1 2 3 op 1 2|1 2|1 2 */

line    : exp                   {;}
        ;

exp    	: mat                   {;}
       	| exp op mat            {;}
       	;
mat     : term                  {addRow();} 
        | mat '|' term          {addRow();}
        ;
term   	: number                {add($1);};
        | term number           {add($2);};
        ;
        
        
%%                     /* C code */

void add(int val){
    printf("adding %d\n", val);
}

void addRow(){
    printf("adding new row \n");
}

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

