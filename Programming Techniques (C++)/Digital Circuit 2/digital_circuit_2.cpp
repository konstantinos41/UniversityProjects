#include <iostream>
#include <stdlib.h>

using namespace std;

int AND(int x, int y);
int OR(int x, int y);
int NOT(int x);
float pAND(int x, int y);
float pOR(int x,int y);
float pNOT(int x);
float pR(int x, int y, float V, float R);


class A{
    int a,b,c,d,position;
    float p,r;
    float V=5;
public:
    A();
    void run(int _a,int _b);
    float get_p() {return p;};
    int get_c() {return c;};
    int get_d() {return d;};
    int get_position() {return position;};
    float get_r() {return r;};
};
A::A(){
    cout << "------------------------\n";
    cout << "Neo Kuklwma A\n";
    cout << "Antistasi kuklwmatos: ";
    cin >> r;
    cout << "Thesi tou kuklwmatos: ";
    cin >> position;
}
void A::run(int _a,int _b){
    a = _a;
    b = _b;
    c = AND(a,b);
    d = OR(a,b);
    p = pAND(a,b) + pOR(a,b) + pR(c,d,V,r);
}


class B{
    int a,b,c,d,position;
    float p,r;
    float V=5;
public:
    B();
    void run(int _a,int _b);
    float get_p() {return p;};
    int get_c() {return c;};
    int get_d() {return d;};
    int get_position() {return position;};
    float get_r() {return r;};
};
B::B(){
    cout << "------------------------\n";
    cout << "Neo Kuklwma B\n";
    cout << "Antistasi kuklwmatos: ";
    cin >> r;
    cout << "Thesi tou kuklwmatos: ";
    cin >> position;
}
void B::run(int _a,int _b){
    a = _a;
    b = _b;
    c = AND(a,pNOT(b));
    d = OR(a,b);
    p = pAND(a,pNOT(b)) + pOR(a,b) + pR(c,d,V,r);
}


template <class Type1, class Type2>
class make_circuit{
    Type1 A;
    Type2 B;
    int nCA,nCB;
    Type1 *pA;
    Type2 *pB;
    int *pos,*cir;
    float *R;
public:
    make_circuit();
    void cir_sort();
    Type1 *get_pA() {return pA;};
    Type2 *get_pB() {return pB;};
    int *get_pos() {return pos;};
    int *get_cir() {return cir;};
    int get_nCA() {return nCA;};
    int get_nCB() {return nCB;};
};

template <class Type1, class Type2>
make_circuit<Type1,Type2>::make_circuit(){
    cout << "Arithmos kuklwmatwn A: ";
    cin >> nCA;
    cout << "Arithmos kuklomatwn B: ";
    cin >> nCB;

    pA=new Type1[nCA];
	pB=new Type2[nCB];

	if ((pos = (int*)malloc((nCA+nCB)*sizeof(int))) == NULL){
	    cout << "Memory Error!";
		exit(1);
	}
	if ((cir = (int*)malloc((nCA+nCB)*sizeof(int))) == NULL){
	    cout << "Memory Error!";
		exit(1);
	}
}

template <class Type1, class Type2>
void make_circuit<Type1,Type2>::cir_sort(){

    int k,z1=0 ,z2=nCA ;
    float tempR;
    int tempPos,tempCir;

    if ((R = (float*)malloc((nCA+nCB)*sizeof(float))) == NULL){
	    cout << "Memory Error!";
		exit(1);
	}
    for(int i=0;i<nCA;i++){
        R[i]=pA[i].get_r();
        pos[i]=pA[i].get_position();
        cir[i]=0;
    }
    for(int i=0;i<nCB;i++){
        R[i+nCA]=pB[i].get_r();
        pos[i+nCA]=pB[i].get_position();
        cir[i+nCA]=1;
    }

    while(true){
        int counter=0;
        for(int q;q<(nCA+nCB-1);q++){
            if(R[q]>R[q+1]){
                counter++;
                tempR=R[q+1];
                R[q+1]=R[q];
                R[q]=tempR;

                tempPos=pos[q+1];
                pos[q+1]=pos[q];
                pos[q]=tempPos;

                tempCir=cir[q+1];
                cir[q+1]=cir[q];
                cir[q]=tempCir;
            }
        }
        if(counter==0) break;
    }
}


template <class Type1,class Type2>
void calc_circuit(Type1 *pA, Type2 *pB, int *pos, int *cir,int a, int b, int nCA, int nCB){
    float sumP=0;
    for(int i=0;i<(nCA+nCB);i++){
        int j;
        for(j=0;j<(nCA+nCB);j++){
            if(pos[j]==i) break;
        }
        if(cir[j]==0) {
            for(int k=0;k<(nCA+nCB);k++){
                if(pA[k]==i){
                    pA[k]->run(a,b);
                    sumP = sumP + pA[k]->get_p();
                    a = pA[k]->get_c();
                    b = pA[k]->get_d();
                }
            }
        }
        if(cir[j]==1) {
            for(int k=0;k<(nCA+nCB);k++){
                if(pB[k]==i){
                    pB[k]->run(a,b);
                    sumP = sumP + pB[k]->get_p();
                    a = pB[k]->get_c();
                    b = pB[k]->get_d();
                }
            }
        }
    }
    cout << "Sunlokiki isxus: " << sumP << endl;
    cout << "Akrodektes exodou: " << a << b << endl;
}

int main(){
    int a,b;
    make_circuit <A,B> C;
    C.cir_sort();
    cout << "Akrodektis a: ";
    cin >> a;
    cout << "Akrodektis b: ";
    cin >> b;
    calc_circuit(C.get_pA(),C.get_pB(),C.get_pos(),C.get_cir(),a,b,C.get_nCA(),C.get_nCB());
    system("PAUSE");
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
float pR(int x, int y, float V, float R){
    if(x!=y) return((V*V)/R);
    else return(0);
}
