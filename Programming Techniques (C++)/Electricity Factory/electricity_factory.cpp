#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <stdio.h>

using namespace std;

class source{
protected:
    char *ClassID;
    static source **T;
    static int n;
    static source **ID;
    static int m;
public:
    source();
    source(char *p);

    char *ret_ID_B() {return ClassID;};

    virtual char *ret_ID()=0;
    virtual float ret_power()=0;
    virtual float ret_pith_vlavis()=0;
    virtual void create(int number)=0;

    static source **get_T(){return T;};
    static int get_n() {return n;};
    static source **get_ID() {return ID;}
    static int get_m() {return m;}
};

source **source::T;
int source::n;
source **source::ID;
int source::m;

source::source(){
    n++;
    if(n==1) T=(source **)malloc(n*sizeof(source *));
    else T=(source **)realloc(T,n*sizeof(source *));
    T[n-1]=this;
}

source::source(char *p){
    ClassID=p;
    m++;
    if(m==1) ID=(source **)malloc(m*sizeof(source *));
    else  ID=(source **)realloc(ID,m*sizeof(source *));
    if(ID==0){
        cout <<"Memory Error.";
        exit(1);
    }
    ID[m-1]=this;
}

int control(source **T_array,int n,float n_pow, float *sum){
    *sum=0;
    char *ID;
    for(int i=0;i<n;i++){
        ID=T_array[i]->ret_ID();
        srand (time(NULL));
        float r=rand()%100;
        r=r/100;
        if(r < T_array[i]->ret_pith_vlavis()) *sum = *sum + T_array[i]->ret_power();
        else {
            cout << "H pugi me tautotita ";
            cout << ID;
            cout << " den leitourgei.\n";
        }
    }
    if (*sum<n_pow) return (1);
    if(*sum>=n_pow && *sum<(n_pow*1.1)) return (2);
    else return (3);
}


int main()
{
    source **P;
    char *id;
    float n_pow;

    int number,z,ctrl;
    float sum;

    z=source::get_m();
    P=source::get_ID();

    for (int i=0;i<z;i++){
        id=P[i]->ret_ID_B();
        cout << "Dwse aithmo pugwn tupou " << id << " :";
        cin >> number;
        if(number<1) continue;
        P[i]->create(number);
    }

    cout << "Elaxisti isxus pou apeteitai gia ti leitourgia tou stathmou: ";
    cin >> n_pow;

    ctrl = control(source::get_T(),source::get_n(),n_pow,&sum);

    cout << "H sunoliki isxus pou paragetai einai : " << sum << endl;
    if(ctrl==1) cout << "H isxus den eparkei.\n";
    if(ctrl==2) cout << "H isxus einai katw apo to orio asfaleias.\n";
    if(ctrl==3) cout << "H trofodosia ginetai omala.\n";

    system("PAUSE");
    return 0;
}

class sun:public source{
    float power,emvadon,roi,S,pith_vlavis;
    char o_ID[20];
public:
    sun();
    sun(char *ch);
    char *ret_ID() {return o_ID;};
    float ret_power() {return (emvadon*roi*S);};
    float ret_pith_vlavis() {return pith_vlavis;};
    void create(int number);

}B("sun");

sun::sun(){
    pith_vlavis=0.6;
    cout << "Hliakos sulektis\n";
    cout << "Tautotita: ";
    cin >> o_ID;
    cout << "Emdadon sulekti: ";
    cin >> emvadon;
    cout << "Fwtini roi: ";
    cin >> roi;
    cout << "Eidikos sunetelestis S: ";
    cin >> S;
}

sun::sun(char *ch):source(ch){}

void sun::create(int number){
    sun *p;
    p=new sun[number];
    if(p==0){
        cout << "Memory Allocation Error.\n";
        exit(1);
    }
}

class air:public source{
    float velocity,A,pith_vlavis;
    char o_ID[20];
public:
    air();
    air(char *ch);
    char *ret_ID() {return o_ID;};
    float ret_power() {return A*velocity;};
    float ret_pith_vlavis() {return pith_vlavis;};
    void create(int number);
}C("air");


air::air(){
    pith_vlavis=0.4;
    cout << "Anemogennitria\n";
    cout << "Tautotita: ";
    cin >> o_ID;
    cout << "Taxuthta Anemou: ";
    cin >> velocity;
    cout << "Eidikos suntelestis A: ";
    cin >> A;
}

air::air(char *ch):source(ch){};

void air::create(int number){
    air *p;
    p=new air[number];
    if(p==0){
        cout << "Memory Allocation Error.\n";
        exit(1);
    }
}
