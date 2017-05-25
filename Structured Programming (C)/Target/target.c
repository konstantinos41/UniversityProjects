#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void ntco_or( float *ptr_X, float *ptr_Y, float *ptr_me);
void nbco_or( float *ptr_x, float *ptr_y, float *ptr_me, float *ptr_X, float *ptr_Y);


int main()
{
    float X,Y,x,y,me,sd,px,py,pd,d;

    printf("Dose arxikes suntetagmenes stoxou:\n");
    scanf("%f",&X);
    scanf("%f",&Y);
    printf("Dose arxikes suntetagmenes blimatos:\n");
    scanf("%f",&x);
    scanf("%f",&y);
    printf("Dose apostasi sd:\n");
    scanf("%f",&sd);
    printf("Dose megisti timi tuxaiwn arithmwn:\n");
    scanf("%f",&me);

    while(1<2){
        printf("Oi suntetagmnenes tou blimatos einai: %f %f\n",x,y);

        ntco_or(&X, &Y, &me);
        nbco_or(&x, &y, &me, &X, &Y);

        printf("Problepse ti nea thesi tou blimatos\n");
        scanf("%f",&px);
        scanf("%f",&py);

        pd=(x-px)*(x-px) + (y-py)*(y-py);
        if(pd<=(sd*sd)) {
            printf("Sugxaritiria! To blima katastrafike.\n");
            break;
        }

        d=(X-x)*(X-x) + (Y-y)*(Y-y);
        if(d<=(sd*sd)){
            printf("O stoxos katastrafike.\nGAME OVER");
            break;
        }
    }
    return 0;
}

void ntco_or( float *ptr_X, float *ptr_Y, float *ptr_me)
{
    srand(time(NULL));
    float R1,R2;
    int m;

    m = (int) ((*ptr_me)/4);

    R1=rand()%m;
    R2=rand()%m;


    if (m%2==0) {
        (*ptr_X) = (*ptr_X) + R1;
        (*ptr_Y) = (*ptr_Y) + R2;
    }
    else {
        (*ptr_X) = (*ptr_X) - R1;
        (*ptr_Y) = (*ptr_Y) - R2;
    }
}


void nbco_or( float *ptr_x, float *ptr_y, float *ptr_me, float *ptr_X, float *ptr_Y){

    srand(time(NULL));
    float R1,R2,d,x,y,Y,X;
    int m;

    m = (int) (*ptr_me);

    R1=rand()%m;
    R2=rand()%m;

    (*ptr_x)=x;
    (*ptr_y)=y;
    (*ptr_X)=X;
    (*ptr_Y)=Y;

    d = (X-x)*(X-x) + (Y-y)*(Y-y);


    if( ((X-(x+R1))*(X-(x+R1)) + (Y-y)*(Y-y))<d ) {
        *ptr_x=x+R1;}
    else  *ptr_x=x-R1;

    if( (X-x)*(X-x) + (Y-(y+R2))*(Y-(y+R2))<d ) {
        *ptr_y=y+R2;}
    else  *ptr_y=y-R2;
}


