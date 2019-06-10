
typedef struct
{
    int int_result;
    double double_result;
} RESULT_STRUCT;

int download();
int add(int a,int b,double *c );
int initialize();
int terminate();
int get_status();
int get_result(RESULT_STRUCT* result);
