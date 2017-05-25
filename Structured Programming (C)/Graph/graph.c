#include <stdio.h>
#include <stdlib.h>
#define MAX 100

int main()
{
    int N,i,j,w,s,sum,z,k,c;
    int adj[MAX][100], weight[100][100], a[100];
    sum=c=k=0;

    printf("Insert number of peaks:\n");
    scanf("%d",&N);

    for(i=0;i<N;i++) {
        a[i]=0;
        for(j=0;j<N;j++) {
            adj[i][j]=0;
        }
    }

    while(1<2) {
        printf("Insert two peaks that communicate or -1 twice to end:\n");
        scanf("%d %d",&i,&j);
        if(i!=-1) {
            if(i>=0 && i<N && j>=0 && j<N){
                adj[i][j]=1;
                adj[j][i]=1;
                printf("Insert the weight of this akmi:\n");
                scanf("%d",&weight[i][j]);
                weight[j][i]=weight[i][j];
            }
            else printf("Peaks should have numbers between 0 and %d.\n",N-1);
        }
        else break;
    }

    printf("Insert the start peak:\n");
    scanf("%d",&i);
    printf("The path is:\n");

    while(1<2){
        s=0;
        w=0;
        for(j=0;j<N;j++) {
            if(adj[i][j]==1){
                if(w==0 || s>weight[i][j]) {
                    s=weight[i][j];
                    z=j;
                    w++;
                }
            }
        }

        sum=sum+s;
        printf("%d\n",i);
        adj[i][z]=adj[z][i]=0;

        a[i]=1;
        while(1<2){
            if(k==N) {
                c=1;
                break;
            }
            if(a[k]==1) k++;
            else break;
        }
        i=z;
        if(w==0) break;
        if(c==1) break;
    }
    printf("The total weight is %d",sum);

    return 0;
}
