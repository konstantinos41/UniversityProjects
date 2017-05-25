#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main()
{
    int n,i,z;
    float min_dis,max_dis,Cx,Cy,centerX,centerY,R,X,Y,distance,dis_Ship_Rock;
    float Rx[1000],Ry[10000],dis_X[1000],dis_Y[1000],dis[1000];

    printf("Insert the number of the Rocks:\n");
    scanf("%d",&n);

    i=0;
    Cx=Cy=max_dis=0;

    while(i<n) {
        printf("Insert the coordinates of a Rock (first X and then Y):\n");
        scanf("%f",&Rx[i]);
        scanf("%f",&Ry[i]);

        Cx=Cx+Rx[i];
        Cy=Cy+Ry[i];

        i++;
    }

    printf("Insert the minimum safety distance:\n");
    scanf("%f",&min_dis);

    centerX=(Cx/n);
    centerY=(Cy/n);

    for(i=0;i<n;i++) {

        dis_X[i]=(centerX-Rx[i])*(centerX-Rx[i]);
        dis_Y[i]=(centerY-Ry[i])*(centerY-Ry[i]);
        dis[i]=sqrt(dis_X[i]+dis_Y[i]);

        if(dis[i]>max_dis) max_dis=dis[i];
    }

    R=min_dis+max_dis;
    z=0;
    while(1<2) {

        printf("Insert coordinates of the ship:\n");
        scanf("%f",&X);
        scanf("%f",&Y);

        distance=sqrt( (centerX-X)*(centerX-X)+(centerY-Y)*(centerY-Y) );

            if(distance<=R) {
                z=0;
                for(i=0;i<n;i++) {
                    dis_Ship_Rock = sqrt( (X-Rx[i])*(X-Rx[i]) + (Y-Ry[i])*(Y-Ry[i]) );

                        if( dis_Ship_Rock <= min_dis ) {
                        printf("The ship is %f units away from the rock %f,%f,%f\n",dis_Ship_Rock,Rx[i],Ry[i]);
                        z++;
                    }
                }
                printf("The number of Rocks near the ship is %d\n",z);

            }
            if(distance>R && z!=0) {
                    printf("The ship is safe.");
                    break;
            }
    }

    return 0;
}
