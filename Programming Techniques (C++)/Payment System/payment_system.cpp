#include <iostream>
#include <stdlib.h>
using namespace std;

class Specialist;

class Project {
    int n;
    int *days, *special;
public:
    Project();
    int get_n() {return n;};
    int get_code(int w) {return special[w];};
    int get_days(int w) {return days[w];};
    friend void program(Project*,Specialist*,int e, int t);
};

class Specialist{
    int code;
    float pay;
public:
    Specialist();
    friend void program(Project*,Specialist*,int e, int t);
    int get_code() {return code;};
};


void program(Project *erga, Specialist *texnikoi,int e,int t){
    int *imeres;
    int ***pinakas;
    int all_days=0;

    if((imeres=(int *)malloc(t*sizeof(int)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    for(int i=0;i<t;i++){
        imeres[i]=0;
    };
    for(int i=0;i<t;i++){
        for(int j=0;j<e;j++){
            int k=erga[j].get_n();
            for(int g=0;g<k;g++){
                if(texnikoi[i].get_code()==erga[j].get_code(g)) imeres[i]=imeres[i]+erga[j].get_days(g);
            };
        };
    };
    for(int i=0;i<t;i++){
        if(imeres[i]>all_days) all_days=imeres[i];
    };

    if((pinakas=(int ***)malloc(t*sizeof(int)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    for(int i=0;i<t;i++){
        if((pinakas[i]=(int **)malloc(all_days*sizeof(int)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
        }
        for(int j=0;j<all_days;j++){
            if((pinakas[i][j]=(int *)malloc(e*sizeof(int)))==NULL){
            cout << "Memory Error!\n";
            exit(1);
            }
        };
    };
    for(int i=0;i<t;i++){
        for(int j=0;j<all_days;j++){
            for(int k=0;k<e;k++){
                pinakas[i][j][k]=0;
            };
        };
    };

    for(int i=0;i<t;i++){
        for(int j=0;j<all_days;j++){
            for(int k=0;k<e;k++){
                for(int q=0;q<erga[k].n;q++){
                    if(erga[k].special[q]==texnikoi[i].code && erga[k].days[q]!=0){
                        erga[k].days[q]=erga[k].days[q]-1;
                        pinakas[i][j][k]=1;
                        break;
                    }
                };
                break;
            };
            break;
        };
    };

    for(int k=0;k<e;k++){
        int fl=0;
        int x=0;
        int y=0;
        int u=0;
        int l=0;

        for(int j=0;j<all_days;j++){
            int p=0;
            for(int i=0;i<t;i++){
                if (pinakas[i][j][k]==1&&fl==0){
                    cout << "To ergo " << k+1 << " xekinise tin " << j+1 << " mera.";
                    x=1;
                    fl=1;
                    y=j;
                    p=1;
                    l = p * texnikoi[i].pay;
                    u=l+u;
                }
                if (pinakas[i][j][k]==1&&fl==1){
                    x++;
                    y=j;
                    p++;
                    l = p * texnikoi[i].pay;
                    u=l+u;
                }
            };

        };
        cout << "To ergo " << k+1 << " teleiwse tin " << y+1 << " mera.";
        cout << "To ergo " << k+1 << " kwstise " << u;
    };
}

Project::Project(){
    cout << "Arithmos texnikwn pou tha xreaistoun gia ena ergo: ";
    cin >> n;
    if((days=(int *)malloc(n*sizeof(int)))==NULL){
                        cout << "Memory Error!\n";
                        exit(1);
                    }
    if((special=(int *)malloc(n*sizeof(int)))==NULL){
                        cout << "Memory Error!\n";
                        exit(1);
                    }
    cout << "Kwdikoi eidikotitwn pou xreiazontai gia to ergo auto:\n";
    for(int i=0;i<n;i++) {
        cin >> special[i];
    }
    for(int i=0;i<n;i++){
       cout << "Hmeres pou xreiazetai o texnikos me eidikotita " << special[i] << " : ";
       cin >> days[i];
    }
}

Specialist::Specialist(){
    cout << "Eisagete ton kwdiko enos texnikou: ";
    cin >>  code;
    cout << "kai ton mistho tou ana mera: ";
    cin >> pay;
}

int main() {
    Specialist *texnikoi;
    Project *erga;
    int e,t,z;

    cout << "Arithmos texnikwn pou diathetei i etairia: ";
    cin >> t;

    if((texnikoi=(Specialist *)malloc(t*sizeof(Specialist)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    for(int i=0;i<t;i++){
        Specialist temp;
        texnikoi[i]=temp;
    };

    cout << "--------------------------------------------\n";
    cout << "Arithmos ergwn pou tha pragmatopoiithoun: ";
    cin >> e;

    if((erga=(Project *)malloc(e*sizeof(Project)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
        }

    for(int i=0;i<e;i++){
        Project temp2;
        erga[i]=temp2;
    };

    for (int i=0;i<e;i++){
        int k=erga[i].get_n();
        for (int w=0;w<k;w++){
            int flag=0;
            for (z=0;z<t;z++){
                if (erga[i].get_code(w)==texnikoi[z].get_code()) flag++;
            };
            if(flag!=1){
                    cout << "O texnikos " << erga[i].get_code(w) << " prepei na prostethei.\n";
                    t++;
                    texnikoi=(Specialist *)realloc(texnikoi,t*sizeof(Specialist));
                    if(texnikoi==NULL){
                        cout << "Memory Error\n";
                        exit(1);
                    }
                    Specialist temp;
                    texnikoi[t]=temp;
            }
        };
    };

    program(erga,texnikoi,e,t);

    cin >> t;
    return 0;
}
