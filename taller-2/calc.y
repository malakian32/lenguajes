%{
void yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *file_name;
FILE *file;
int printResult = 0;
int matrixIndex = 0;
float matrixes[20][100][100];
int row_col[20][2];

void printMatrix(int matrixIndex);
void addMatrix(char *filename);
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

void addMatrix(char *filename){
    int colVerification = 0;
    int i = 0;
    int j = 0;
    char *content = readFile(filename);
    char *strcopy = calloc(strlen(content), sizeof(char));
    char *token, *token2;
    
    strcopy = strdup (content);
    
    while ((token = strsep(&content, "\n"))) {
        char *tokencopy = calloc(strlen(token), sizeof(char));
        tokencopy = strdup (token);
        j = 0;
        
        while ((token2 = strsep(&tokencopy, " "))) {
            /*if(token2 == " "){
                printf("y %s",token2);
            }*/
            matrixes[matrixIndex][i][j] = atof(token2);
            j++;
        }
        
        if(i == 0) {
            colVerification = j;                
        }
        
        if(colVerification != j) {
            printf("Error, matrix columns do not match!");
            exit(1);
        }
        
        i++;
        free(tokencopy);  
    }
    
          
    row_col[matrixIndex][0] = i;
    row_col[matrixIndex][1] = j;
    
    printMatrix(matrixIndex);
    matrixIndex++;
    
    free(content);
    free(strcopy);
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

void printMatrix(int matrixIndex) {
    int rows = row_col[matrixIndex][0];
    int cols = row_col[matrixIndex][1];
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%4.2f ", matrixes[matrixIndex][i][j]);
        }

        printf("\n");
    }
    printf("__________________________________\n");
}

int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

