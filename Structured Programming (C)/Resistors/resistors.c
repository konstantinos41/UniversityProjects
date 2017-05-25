#include <stdio.h>
#include <stdlib.h>


int main() {

    int a,b,n,p,z;
    float R1,R2,R3,R4,V,R,r,G,m,i,I;


    printf("Enter R1 and R2:\n");
    scanf("%f",&R1);
    scanf("%f",&R2);
    "\n";

    printf("Enter R3 and R4:\n");
    scanf("%f",&R3);
    scanf("%f",&R4);
    "\n";

    printf("Enter V:\n");
    scanf("%f",&V);

    printf("Enter total amount of Resistors:\n");
    scanf("%d",&n);

    R=r=G=a=b=m=z=p=i=I=0;

    while(p<n){
        printf("Enter a Resistor and its maximum I:\n");
        scanf("%f",&m);
        scanf("%f",&I);
        i=V/m;

        if(i<=I){

            if(m>=R1 && m<=R2 && m<R3) a++;

            if(m>R2 && m>=R3 && m<=R4) b++;

            if(m<=R2 && m>=R3) {
                if(z==0){
                    a++;
                    z++;
                }
                else{
                    b++;
                    z=z-1;
                }

            }
            if(m<R1 || m>R4) printf("The resistor's value exceeds the given limits.\n");

            else {
                R=R+m;
                G=G+(1/m);
                r=(1/G);
            }
            }
        else printf("The circuit's electric current exceeds the resistor's max current.\n");

        p++;
    }
    printf("\nThe first group contains %d resistors and the second %d.", a, b);
    printf("\nAll Resistors placed in a row give %f.\nAll Resistors placed parallel give %f.", R, r);

    return 0;
}
