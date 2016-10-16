%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include "matrix.h"
int matrixesIndex = 0;
int indexTmp = 0;
int rows = 0;
int cols = 0;
int tmp[20];
struct Matrix matrixes[52];
void addCol(int val);
void addRow();
void addMatrix();
void setViewOption();
void setFileName(char *filename);
%}

%union {int num; char *str;}         /* Yacc definitions */
%start line
%token view
%token save
%token <str> fileName
%token op
%token <num> number
%type <num> term 

%%

/*./calc 1 2 3|1 2 3 * 1 2|1 2|1 2 --view --save filename.txt*/

line    : exp options           {;}
        ;

exp    	: matrix                {addMatrix();}
       	| exp op matrix         {;}
       	;
matrix  : term                  {addRow();} 
        | matrix '|' term       {addRow();}
        ;
term   	: number                {addCol($1);};
        | term number           {addCol($2);};
        ;
        
options : option                {;}
        | options option        {;}
        ;
option      : viewOption | saveOption {;}
            ;
viewOption  : view               {setViewOption();}
            ;
saveOption  : save fileName      {setFileName($2);}
            ;
        
        
%%                     /* C code */

void addCol(int val){
    printf("New col %d\n", val);
    tmp[indexTmp] = val;    
    indexTmp++;
    cols++;
    
    if(matrixes[matrixesIndex].rows == 0) {
        matrixes[matrixesIndex].cols++;
    }
}

void addRow(){
    printf("New row \n");
    if(cols > matrixes[matrixesIndex].cols) {
        printf("Error: number of columns do not match in some matrix\n");
    }
    matrixes[matrixesIndex].rows++;
    cols=0;
}

void addMatrix(){
    printf("New matrix %d %d %d %d\n", rows, cols, matrixes[matrixesIndex].rows, matrixes[matrixesIndex].cols);
    createMatrix(&matrixes[matrixesIndex]);
    initializeMatrix(&matrixes[matrixesIndex], tmp);
    
    
    printMatrix(matrixes[matrixesIndex]);
    
    rows = 0;
    cols = 0;
    matrixesIndex++;
}

void setViewOption(){
    printf("Setting view option\n");
}

void setFileName(char *filename){
    printf("Setting Filename to save %s \n", filename );
}

int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

