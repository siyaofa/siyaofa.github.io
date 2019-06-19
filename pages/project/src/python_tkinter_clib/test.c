
#include <stdio.h>
#include <stdlib.h>
#include "test.h"

int download()
{
    printf("CDLL Download\n");
    return 0;
}

int add(int a, int b, double *c)
{
    *c = a + b;
    printf("CDLL %d + %d = %lf \n", a, b, *c);
    return 0;
}

int initialize()
{
    printf("CDLL initialize\n");
    return 0;
}

int terminate()
{
    printf("CDLL terminate\n");
    return 0;
}

int get_status()
{
    printf("CDLL get_status\n");
    return 0;
}

int get_result(RESULT_STRUCT *result)
{
    printf("CDLL get_result\n");
    result->double_result = 0.123;
    result->int_result = 1;
    return 0;
}
