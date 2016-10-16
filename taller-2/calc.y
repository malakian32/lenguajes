%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include "matrix.h"
int printResult = 0;
int matrixesIndex = 0;
int indexTmp = 0;
int cols = 0;
int tmp[20];
char *file_name;
FILE *file;
struct Matrix matrixes[52];
void addCol(int val);
void addRow();
void addMatrix();
void setPrintResultOption();
void setFileName(char *filename);
%}

%union {int num; char *str;}         /* Yacc definitions */
%start line
%token print
%token save
%token op
%token <str> fileName
%token <num> number
%type <num> term 

%%

/*./calc 1 2 3|4 5 6 * 1 2|3 4|5 6 --print-result --save filename.txt*/

line                : exp options                       {;}
                    ;

exp    	            : matrix                            {addMatrix();}
       	            | exp op matrix                     {addMatrix();}
       	            ;
matrix              : term                              {addRow();} 
                    | matrix '|' term                   {addRow();}
                    ;
term   	            : number                            {addCol($1);};
                    | term number                       {addCol($2);};
                    ;
        
options             : option                            {;}
                    | options option                    {;}
                    ;
option              : printResultOption | saveOption    {;}
                    ;
printResultOption   : print                             {setPrintResultOption();}
                    ;
saveOption          : save fileName                     {setFileName($2);}
                    ;
        
        
%%

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
    if(cols > matrixes[matrixesIndex].cols) {
        printf("Error: number of columns do not match in some matrix\n");
    }
    
    matrixes[matrixesIndex].rows++;
    cols=0;
}

void addMatrix(){
    printf("New matrix %d rows %d cols\n", matrixes[matrixesIndex].rows, matrixes[matrixesIndex].cols);
    createMatrix(&matrixes[matrixesIndex]);
    initializeMatrix(&matrixes[matrixesIndex], tmp);
    printMatrix(matrixes[matrixesIndex]);
    
    cols = 0;
    indexTmp = 0;
    matrixesIndex++;
}

void setPrintResultOption(){
    printf("Setting view option\n");
    printResult = 1;
}

void setFileName(char *filename){
    file_name = filename;
    printf("Setting Filename to save %s \n", file_name );
}


void saveFile(char *text) {
    if(file_name != NULL) {
        file = fopen(file_name, "w");
    }

    if (file != NULL) {
        fprintf(file, "%s", text);
        fclose(file);
    } else {
        printf("Error saving file!\n");
    }
}

int main (void) {
	return yyparse ( );
}
void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

