#ifndef MATRIX_H_
#define MATRIX_H_

typedef struct Matrix {
    int memorySize;
    int *pointer;
    int rows;
    int cols;
} Matrix;

void createMatrix(Matrix* matrix/*, int rows, int cols*/);
void destroyMatrix(Matrix matrix);
void initializeMatrix(Matrix *matrix, int *array);
void setMatrixValueAt(Matrix *matrix, int row, int column, int value);
int getMatrixValueAt(Matrix matrix, int row, int column);
void printMatrix(Matrix matrix);
void printArray(int * array, int size);
#endif
