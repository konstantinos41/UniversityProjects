#include <iostream>
#include <stdlib.h>

using namespace std;


int AND(int x, int y);
int OR(int x, int y);
int NOT(int x);
float pAND(int x, int y);
float pOR(int x,int y);
float pNOT(int x);
void calk_circuit(circuit **T,int n);


class circuit{
public:
    virtual void run(int _a,int _b)=0;
    virtual int get_c() {};
    virtual int get_d() {};
    virtual float get_p() {};
};

class circuitA:public circuit{
    int a,b,c,d;
    float p;
public:
    void run(int _a,int _b);
    int get_c() {return c;};
    int get_d() {return d;};
    float get_p() {return p;};
};

class circuitB:public circuit{
    int a,b,c,d;
    float p;
public:
    void run(int _a,int _b);
    int get_c() {return c;};
    int get_d() {return d;};
    float get_p() {return p;};
};


void circuitA::run(int _a,int _b){
    a=_a;
    b=_b;
    c=AND(a,b);
    d=OR(a,b);
    p=pAND(a,b);
    p=p+pOR(a,b);
}

void circuitB::run(int _a,int _b){
    a=_a;
    b=_b;
    int nb;
    nb=NOT(b);
    c=AND(a,nb);
    d=OR(a,b);
    p=pAND(a,nb);
    p=p+pOR(a,b);
}


void calk_circuit(circuit **T,int n){
    int a,b;
    float sump;

    for(int i=0;i<2;i++){
        for(int j=0;j<2;j++){
            a=i;
            b=j;
            sump=0;
            cout << "Gia a=" << a << " kai b=" << b;
            for(int i=0;i<n;i++){
                T[i]->run(a,b);
                sump=sump+(T[i]->get_p());
                a = T[i]->get_c();
                b = T[i]->get_d();
            }
            cout << " exoume c=" << a << " kai d=" << b << ". H isxus pou katanalwnetai einai " << sump << "." << endl;
        }
    }
}


int main()
{
    int nA,nB,n,k;
    cout << "Arithmos kyklwmatwn A: ";
    cin >> nA;
    cout << "Arithmos kyklwmatwn B: ";
    cin >> nB;
    n=nA+nB;

    circuit **T;
    if((T=(circuit **)malloc(n*sizeof(circuit)))==NULL){
            cout << "Memory Error!\n";
            exit(1);
            }

    for(int i=0;i<n;i++){
        cout << "Thesi " << i+1 << ": Dwse 1 gia kuklwma A h 2 gia kuklwma B: ";
        cin >> k;
        if(k==1){
            circuitA A;
            T[i]=&A;
        }
        if(k==2){
            circuitB B;
            T[i]=&B;
        }
    }

    calk_circuit (T,n);

    return 0;
}


int AND(int x, int y){
    if(x==0||y==0) return(0);
    if (x==1&&y==1) return(1);
}
int OR(int x, int y){
    if(x==1||y==1) return(1);
    if(x=0&&y==0) return(0);
}
int NOT(int x){
    if(x==0) return(1);
    if(x==1) return(0);
}
float pAND(int x,int y){
    if(x==0&&y==0) return(0);
    if(x==1&&y==1) return(1);
    return(0.5);
}
float pOR(int x,int y){
    if(x==0&&y==0) return(0);
    if(x==1&&y==1) return(1);
    return(0.5);
}
float pNOT(int x){
    if(x==0) return(0);
    else return(1);
}
