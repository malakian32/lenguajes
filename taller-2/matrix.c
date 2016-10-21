#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <time.h>
#include "matrix.h"

void createMatrix(Matrix* matrix, int rows, int cols) {
    matrix->rows = rows;
    matrix->cols = cols;
    matrix->data = calloc(rows * cols, sizeof(float));
}

void destroyMatrix(Matrix matrix) {
    free(matrix.data);
}

void initializeMatrix(Matrix *matrix, float *array) {
    int tmp = 0;

    for (int i = 0; i < matrix->rows; i++) {
        for (int j = 0; j < matrix->cols; j++) {
            float value = array[tmp];
            setMatrixValueAt(matrix, i, j, value);
            tmp++;
        }
    }
}

void setMatrixValueAt(Matrix *matrix, int row, int column, float value) {
    matrix->data[row + column * matrix->rows * matrix->cols] = value;
}

float getMatrixValueAt(Matrix matrix, int row, int column) {
    return matrix.data[row + column * matrix.rows * matrix.cols];
}

void printMatrix(Matrix matrix) {
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
