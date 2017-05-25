#include <iostream>
#include <stdlib.h>
#include <cmath>


using namespace std;

class matrix {
    int r,c;
    float **m;
public:
    void operator () (int n, int k);
    int operator ! ();
    float* operator [] (int i);

    void diabase();
    int get_r() {return r;};
    int get_c() {return c;};
};

class vector {
    int n;
    float *v;
public:
    void operator () (int k);
    int operator () (vector d, float e);
    void operator = (matrix a);
    vector operator * (vector d);
    vector operator - (vector d);
    vector operator + (vector d);
    vector operator / (vector d);
    float operator [] (int i) {return v[i];};

    void diabase ();
    float get_v (int i) {return v[i];};
    int get_n () {return n;};
    void set_v (float *x) {v=x;};
    void set_v (float y,int i) {v[i]=y;};
};

class system_solve {
    matrix a;
    vector b;
    int z;
public:
    system_solve();
    vector solve(int k, float e);
    int get_z(){return z;};
};

void matrix::operator () (int n, int k){
    r=n;
    c=k;

    if((m=(float **)malloc(c*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    for(int i=0;i<c;i++){
        if((m[i]=(float *)malloc(r*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
        }
    };
}

int matrix::operator ! (){
    if(r!=c) cout << "O pinakas den einai tetragwikos.";
    else{
        float *g,*s;
        int counter=0;

        if((g=(float *)malloc(r*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
        }
        if((s=(float *)malloc(r*sizeof(float)))==NULL){
            cout << "Memory Error!\n";
            exit(1);
        }

        for(int i=0;i<r;i++){
            g[i]=0;
            s[i]=0;
        };

        for(int i=0;i<r;i++){
            for(int j=0;j<r;j++){
                g[i]=g[i]+abs(m[i][j]);
            };
        }
        for(int j=0;j<r;j++){
            for(int i=0;i<r;i++){
                s[j]=s[j]+abs(m[i][j]);
            };
        }

        for(int i=0;i<r;i++){
            if(abs(m[i][i])>(g[i]-abs(m[i][i])) || abs(m[i][i])>(s[i]-abs(m[i][i]))) counter++;
        };
        if(counter==r) return 0;
        else return 1;
    }
}

float* matrix::operator [] (int i) {
    return m[i];
}

void matrix::diabase(){
    cout << "Dwse Stoixeia tou pinaka:\n";
    for(int i=0;i<r;i++){
        cout << "Stoixeia "<< i+1 << " grammhs: \n";
        for(int j=0;j<c;j++){
            cin >> m[i][j];
        };
    };
}


void vector::operator()(int k){
    if((v=(float *)malloc(k*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    n=k;
}

int vector::operator () (vector d, float e){
    int counter=0;
    for(int i=0;i<n;i++){
        if (abs(v[i]-d.v[i])<e) counter ++;
    };
    if(counter==n) return 1;
    else return 0;
}

void vector::operator = (matrix a){

    if(a.get_c()!=a.get_r()){
        cout << "O pinakas den einai einai tetragwnikos.\n";
        }
    else{
        for (int i=0;i<a.get_c();i++){
           v[i]=a[i][i];
        };
    }
}

vector vector::operator * (vector d){
    if(n!=d.n){
        cout << "Ta dianusmata exoun diaforetiko arithmo stoixeiwn.\n";
    }
    else{
        vector v1;
        v1(n);
        for(int i=0;i<this->n;i++){
            v1.v[i]=v[i]*d.v[i];
        }
        return(v1);
    }
}

vector vector::operator - (vector d){
    if(n!=d.n){
        cout << "Ta dianusmata exoun diaforetiko arithmo stoixeiwn.\n";
    }
    else{
        vector v1;
        v1(n);
        for(int i=0;i<this->n;i++){
            v1.v[i]=v[i]-d.v[i];
        }
        return(v1);
    }
}

vector vector::operator + (vector d){
    if(n!=d.n){
        cout << "Ta dianusmata exoun diaforetiko arithmo stoixeiwn.\n";
    }
    else{
        vector v1;
        v1(n);
        for(int i=0;i<this->n;i++){
            v1.v[i]=v[i]+d.v[i];
        }
        return(v1);
    }
}

vector vector::operator / (vector d){
    if(n!=d.n){
        cout << "Ta dianusmata exoun diaforetiko arithmo stoixeiwn.\n";
    }
    else{
        vector v1;
        v1(n);
        for(int i=0;i<this->n;i++){
            if(d.v[i]==0){
                cout << "Yparxxei mideniko stoixeiou sto deutero dainisma. H diairesi den einai dunati. Epistrafike to prwto dianusma.\n";
                return (*this);
            }
            v1.v[i]=v[i]/d.v[i];
            }
        return(v1);
    }
}

vector operator * (matrix a, vector b){
    if(a.get_r()!=a.get_c()) cout << "O pinakas den einai tetragwikos.";
    else{
        if(a.get_r()!=b.get_n()) cout << "O arithmos twn stoixeiwn tou dianusmatos einai diaforetikos apo ton arithmo twn grammwn/stilwn tou pinaka\n";
        else{
            vector v1;
            v1(b.get_n());
            for (int i=0;i<a.get_r();i++){
                float s=0;
                for (int j=0;j<a.get_r();j++){
                    s=s+(a[i][j]*b[j]);
                }
                v1.set_v(s,i);
            }
            return (v1);
        }
    }
}

void vector::diabase(){
    cout << "Stoixeia tou dianusmatos:\n";
    for (int i=0;i<n;i++) cin >> v[i];
}

system_solve::system_solve(){
    cout << "Arithmos exiswsewn sustumatos:\n";
    cin >> z;
    a(z,z);
    b(z);
    a.diabase();
    b.diabase();
}

vector system_solve::solve(int k,float e){
    vector X,x,d;
    x(z);
    X(z);
    d(z);

    d=a;
    if(!a==1) {
        cout << "O pinakas den einai diagwnios uperterwn, o algorithmos den mporei na xrisimopoiithei.";
        exit (1);
    }
    for(int i=0;i<z;i++) x.set_v(1,i);

    for(int i=0;i<k;i++){
        X=(b-a*x+d*x)/d;
        if (x(X,e)) break;
        x=X;
    }
    return(x);
}

int main(){
    int k,e;
    vector solution;
    system_solve S;

    solution(S.get_z());
    cout << "k= ";
    cin >> k;
    cout << "e= ";
    cin >> e;
    solution=S.solve(k,e);

    cout << "Oi luseis einai: \n";
    for (int i=0;i<S.get_z();i++){
        cout << solution[i] << "  ";
    }

    return 0;
}
