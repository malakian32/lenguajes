%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int printResult = 0;
int matrixesIndex = 0;
int matrixIndex = 0;
int indexTmp = 0;
int cols = 0;
int tmp[100];
char *file_name;
FILE *file;
int MATRIXES = 20
float *matrix[MATRIXES];
int row_col[MATRIXES][2];
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
    Matrix mat;
    int row = 0;
    int col = 0;
    int i = 0;
    float tmp[100];
    char *content = readFile(filename);
    char *strcopy = calloc(strlen(content), sizeof(char));
    char *token, *token2;
    strcopy = strdup (content);
    while ((token = strsep(&content, "\n"))) {
        char *tokencopy = calloc(strlen(token), sizeof(char));
        tokencopy = strdup (token);
        
        while ((token2 = strsep(&tokencopy, " "))) {
            float num = atof(token2);
            tmp[i] = num;
            i++;
            
            if(row == 0) {
                col++;                
            }
        }
        
        free(tokencopy);  
        row++;
    }
    
    row_col[matrixIndex][0] = row;
    row_col[matrixIndex][1] = col;
    matrix[matrixIndex] = calloc(row * col, sizeof(float));
    
    for(int i=0; i<row*col; i++) {
        matrix[matrixIndex][i] = tmp[i];
    }
    
    printMatrix(matrix[matrixIndex], row*col);
    matrixesIndex++;
    
    free(content);
    free(strcopy);
    free(tokencopy);
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


void setMatrixValueAt(Matrix *matrix, int row, int column, float value) {
    matrix->data[row + column * matrix->rows * matrix->cols] = value;
}

float getMatrixValueAt(Matrix matrix, int row, int column) {
    return matrix.data[row + column * matrix.rows * matrix.cols];
}

void printMatrix(float *matrix) {
    for (int i = 0; i < matrix.rows; i++) {
        for (int j = 0; j < matrix.cols; j++) {
            printf("%f ", getMatrixValueAt(matrix, i, j));
        }

        printf("\n");
    }
    printf("__________________________________\n");
}

void printArray(float *array, size_t lenght) {
    for (int i = 0; i < lenght; i++) {
        printf("%4.2f ", array[i]);
    }

    printf("\n");
}

int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

