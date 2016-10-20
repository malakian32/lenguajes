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
char *readFile(char *filename);
%}

%union {int num; char *str;}         /* Yacc definitions */
%start line
%token print
%token save
%token op
%token <str> fileName
%token <num> number

%%

/*./calc mat1.txt * mat2.txt --print-result --save filename.txt*/

line                : exp options                       {;}
                    ;

exp    	            : matrix                            {;}
       	            | exp op matrix                     {;}
       	            ;
matrix              : fileName                          {addMatrix($1);} 
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

void addMatrix(char *filename){
    Matrix matrix = matrixes[matrixesIndex];
    int row = 0;
    int col = 0;
    char *content = readFile(filename);
    
        printf("%d ", strlen(content));
        printf("%c ", content[0]);
        printf("%s ", content);
    /*
        printf("%c ", content[0]);

    for (int i = 0; i < 100; i++) {
        printf("%c ", content[i]);
        if(content[i] == '\n') {
            row++;
        } else {
            printf(" %s", content[i]);
            //setMatrixValueAt(&matrix, row, col, atoi(content[i]));
            col++;
        }
    }*/
    
    
    
    
    /*
    printf("New matrix %d rows %d cols\n", matrixes[matrixesIndex].rows, matrixes[matrixesIndex].cols);
    createMatrix(&matrixes[matrixesIndex]);
    initializeMatrix(&matrixes[matrixesIndex], tmp);
    printMatrix(matrixes[matrixesIndex]);
    
    cols = 0;
    indexTmp = 0;*/
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

char *readFile(char *filename) {
    FILE *file;
    char *buffer;
    long size;
    file = fopen(filename, "rb");

    if (!file)
        printf("File %s doesn't exist\n", filename), exit(1);
    
    fseek(file, 0L, SEEK_END);
    size = ftell(file);
    rewind(file);

    buffer = calloc(1, size + 1);
    if (!buffer)
        fclose(file), fputs("memory alloc fails", stderr), exit(1);

    if (1 != fread(buffer, size, 1, file))
        fclose(file), free(buffer), fputs("entire read fails", stderr), exit(1);

    fclose(file);
    
    return buffer;
}

int main (void) {
	return yyparse ( );
}
void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

