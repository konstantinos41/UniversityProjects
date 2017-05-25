#include <stdio.h>
#include <stdlib.h>

int **connection,**weights,*stiles;
int sum,w,N,r;
r=sum=0;

void next_vertex(int *s);

int main()
{
    int i,j,temp,s;


    printf("Dwse arithmo korufwn grafimatos:\n");
    scanf("%d",&N);

    connection=(float**)malloc(N*sizeof(int*));
    if(connection==NULL) return 0;

    weights=(float**)malloc(N*sizeof(int*));
    if(weights==NULL) return 0;

    stiles=(float*)malloc(N*sizeof(int*));
    if(stiles==NULL) return 0;




    for(i=0;i<N;i++){
        printf("Dwse arithmo korufwn pou epikoinwnoyn me tin korufh %d:\n",i);
        scanf("%d",&stiles[i]);
        connection[i]=(float*)malloc(stiles[i]*sizeof(int));
        if(connection[i]==NULL) return 0;
        weights[i]=(float*)malloc(stiles[i]*sizeof(int));
        if(weights[i]==NULL) return 0;

    }


    for(i=0;i<N;i++){
            for(j=0; j < stiles[i] ; j++){
                connection[i][j]=0;
                weights[i][j]=0;
            }
    }



    for(i=0;i<N;i++){
        printf("Dwse tis korufes me tis opoies epikoinwnei h %d:\n",i);
        for(j=0; j < stiles[i] ; j++){
            scanf("%d",&connection[i][j]);
        }
        for(j=0; j < stiles[i]-1 ;j++){
            if(connection[i][j]>connection[i][j+1]){
                temp=connection[i][j+1];
                connection[i][j+1]=connection[i][j];
                connection[i][j]=temp;
            }
        }

    }
    for(i=0;i<N;i++) {
        for(j=0; j < stiles[i] ;j++){
            if(weights[i][j]==0){
                printf("Dwse to baros anamesa stis korufes %d kai %d:\n",i,connection[i][j]);
                scanf("%d", &weights[i][j]);
                weights[connection[i][j]][i]=weights[i][j];
            }
        }
    }


    printf("Dwse korufh ekkinhshs:\n");
    scanf("%d",&s);

    printf("To monopati einai:\n%d\n",s);

    next_vertex(&s);




return(0);
}

void next_vertex(int *s)
{
    int n,i,j,k,l;
    k=0;
    n=-1;


    for(j=0; j < stiles[*s] ;j++){
        if (connection[*s][j]!=-1){
            if(k==0||w>weights[*s][j] ){
                w=weights[*s][j];
                n=j;
                k++;

            }
        }
    }


    for(i=0;i<N;i++){
        for(j=0;j<stiles[i];j++){
            if (connection[i][j]==(*s)) connection[i][j]=-1;

        }
    }

    l=connection[*s][n];
    if(n!=-1) {
        printf("%d\n",l);
        sum=sum+weights[*s][n];
        r++;
        next_vertex(&l);
    }
    else{
        printf("To baros einai: %d\n",sum);
        if(r==N-1){
           printf("To monopati oloklirwthike.");
           return 0;
        }
        else{
            printf("To monopati den oloklirwthike.");
            return 0;
        }

    }

}

