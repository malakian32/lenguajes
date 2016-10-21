#ifndef MATRIX_H_
#define MATRIX_H_

typedef struct Matrix {
    float *data;
    int rows;
    int cols;
} Matrix;

void createMatrix(Matrix* matrix, int rows, int cols);
void destroyMatrix(Matrix matrix);
void initializeMatrix(Matrix *matrix, float *array);
void setMatrixValueAt(Matrix *matrix, int row, int column, float value);
float getMatrixValueAt(Matrix matrix, int row, int column);
void printMatrix(Matrix matrix);
void printArray(float *array, size_t lenght);
#endif
