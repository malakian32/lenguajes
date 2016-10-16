#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <time.h>
#include "matrix.h"

void createMatrix(Matrix* matrix/*, int rows, int cols*/) {
    //matrix->rows = rows;
    //matrix->cols = cols;
    matrix->memorySize = matrix->rows * matrix->cols * sizeof(int);
    matrix->pointer = (int*) malloc(matrix->memorySize);
}

void addMatrixRow(Matrix* matrix) {
    matrix->memorySize = matrix->rows * (matrix->cols + 1) * sizeof(int);
    matrix->pointer = (int*) realloc(matrix->pointer, matrix->memorySize);
}

void destroyMatrix(Matrix matrix) {
    free(matrix.pointer);
}

void initializeMatrix(Matrix *matrix, int *array) {
    int tmp = 0;
    for (int i = 0; i < matrix->rows; i++) {
        for (int j = 0; j < matrix->cols; j++) {
            int value = array[tmp];
            setMatrixValueAt(matrix, i, j, value);
            tmp++;
        }
    }
}

void setMatrixValueAt(Matrix *matrix, int row, int column, int value) {
    matrix->pointer[row + column * matrix->rows * matrix->cols] = value;
}

int getMatrixValueAt(Matrix matrix, int row, int column) {
    return matrix.pointer[row + column * matrix.rows * matrix.cols];
}

void printMatrix(Matrix matrix) {
    for (int i = 0; i < matrix.rows; i++) {
        for (int j = 0; j < matrix.cols; j++) {
            printf("%i ", getMatrixValueAt(matrix, i, j));
        }

        printf("\n");
    }
    printf("__________________________________\n");
}

void printArray(int *array, int size) {
    for (int i = 0; i < size; i++) {
        printf("%i ", array[i]);
    }

    printf("\n");
}
