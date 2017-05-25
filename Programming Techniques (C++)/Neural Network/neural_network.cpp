#include <iostream>
#include <stdlib.h>

using namespace std;

class neuron{
    int state,num,id;
    float th;
    int *matrixID;
    float *matrixWeight;
public:
    friend istream &operator>(istream &s, neuron obj);
    void *operator new[](size_t size);
    void operator delete[](void *p) {free(p);};
    int get_state() {return state;};
    int get_id() {return id;};
    int get_num() {return num;};
    int get_Mid(int i) {return matrixID[i];};
    float get_Mw(int i) {return matrixWeight[i];};
    float get_th() {return th;};
    void set_state(int x) {state=x;};
};

class network{
    int number;
    neuron *M;
public:
    void *operator new(size_t size);
    void operator delete(void *p) {free(p);};
    friend ostream &operator<(ostream &s, network obj);
    void calk_state();
};

istream &operator>(istream &s, neuron obj) {
    for(int i=0;i<obj.num;i++){
        cout << "Tautotita enos neurona pou epikoinwnei me auton: ";
        s >> obj.matrixID[i];
        cout << "Baros anamesa tous: ";
        s >> obj.matrixWeight[i];
    }
    cout << "Katwfli energopoihsis: ";
    s >> obj.th;
    cout << "Arxiki katastasi: ";
    s >> obj.state;

    return s;
}

void *neuron::operator new[](size_t size){
    int n;
    neuron *p;
    if ((p = (neuron*)malloc(size)) == NULL)
	{
	    cout << "Memory Error!";
		exit(1);
	}
	n=(int)size/sizeof(neuron);
	for(int i=0;i<n;i++){
        p[i].id=i;
        cout << "Arithmos neuronwn pou epikoinwnoun me auton: ";
        cin >> p[i].num;

        if((p[i].matrixID=(int *)malloc(p[i].num*sizeof(int)))==NULL){
            cout << "Memory Error!\n";
            exit(1);
        }
        if((p[i].matrixWeight=(float *)malloc(p[i].num*sizeof(float)))==NULL){
            cout << "Memory Error!\n";
            exit(1);
        }
        cin>p[i];
	}
	return p;
}


void *network::operator new(size_t size){
    network *p;
    if ((p = (network*)malloc(size)) == NULL){
		cout << "Memorry Error!";
		exit(1);
	}
	cout << "Arithmos neuronwn diktuou: ";
	cin >> p->number;
    p->M=new neuron[p->number];

    return p;
}

ostream &operator<(ostream &s, network obj){
    int flag=0;
    float newState;
    for(int i=0;i<obj.number;i++){
        float sum=0;
        for(int j=0;j<obj.M[i].get_num();j++){
            sum= sum + obj.M[i].get_state()*obj.M[i].get_Mw(j);
        }
        if(sum>obj.M[i].get_th()) newState=1;
        else newState=-1;

        if(newState!=obj.M[i].get_state()){
            s << "Neuronas " << obj.M[i].get_id() << ": -1\n";
            flag=1;
        }
        else s << "Neuronas " << obj.M[i].get_id() << ": 1\n";
    }
    if(flag!=0) s << "Diktuo " << "UNSTABLE\n";

    return s;
}

void network::calk_state() {
    int e;
    cout << "Megistos arithmos epanalipsewn: ";
    cin >> e;
    for(int k=0;k<e;k++){
        int flag=0;
        int *oldState;
        if ((oldState = (int*)malloc(number*sizeof(int))) == NULL){
            cout << "Memorry Error!";
            exit(1);
        }
        for(int i=0;i<number;i++) oldState[i]=M[i].get_state();

        for(int i=0;i<number;i++){
            float sum=0;
            for(int j=0;j<M[i].get_num();j++){
                sum= sum + oldState[i]*M[i].get_Mw(j);
            }
            if(sum>M[i].get_th()) M[i].set_state(1);
            else M[i].set_state(-1);

            if(oldState[i]==M[i].get_state()) flag++;
        }
        if (flag==number) break;
    }
}

int main()
{
    network *a;
    a = new network;
    a->calk_state();
    cout <*a;
    delete a;

    system("PAUSE");
    return 0;
}
