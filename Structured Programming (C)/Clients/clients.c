#include <stdio.h>
#include <stdlib.h>


struct customers {
    char name[20];
    int code1;
    int code2;
    float amount1;
};

struct products {
    int code3;
    float amount2;
};

void s1();
void s3();

int main() {
    int e;

    printf("Epilexte ena apo ta parakatw:\n");
    scanf("%d",&e);
    if (e!=1 && e!=2 && e!=3 && e!=4 && e!=5 && e!=6 && e!=7 && e!=8){
        printf("Prospathiste xana:\n");
        scanf("%d",&e);
    }
    if(e==1) s1();

    if(e==3) s3();


    return 0;
}

void s1() {
    FILE *fp;
    struct customers a;
    printf("Eisagete onoma pelati:\n");
    scanf("%s",&a.name[20]);
    printf("Eisagete kwdiko pelati:\n");
    scanf("%d",&a.code1);
    printf("Eisagete kwdiko prointos pou thelei:\n");
    scanf("%d",&a.code2);


    fp=fopen("customers","w+b");
    fwrite(&a,sizeof (a),1,fp);

}

void s3(){
    FILE *fp;

    struct products b;
    printf("Eisagete kwdiko proiontos:\n");
    scanf("%d",&b.code3);

    fp=fopen("products","w+b");
    fp=fwrite(&b,sizeof(b),1,fp);
}

//H ergasia den einai oloklirwmenh, den exoun ginei oles oi sunartiseis.
