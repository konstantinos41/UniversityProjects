#include <iostream>
#include <stdlib.h>
#include <ctime>

using namespace std;

class data{
    int n_zwnwn;
    float *ant_oik, *ant_kti, *foros_oik, *foros_kti;
    float foros_dend, foros_kall, meiwsi;
public:
    data();
    float get_ant_oik(int zwni) {return ant_oik[zwni];};
    float get_foros_oik(int zwni) {return foros_oik[zwni];};
    float get_ant_kti(int zwni) {return ant_kti[zwni];};
    float get_foros_kti(int zwni) {return foros_kti[zwni];};
    float get_foros_dend() {return foros_dend;};
    float get_foros_kall() {return foros_kall;};
    float get_meiwsi() {return meiwsi;};
};

class ground{
    int zwni,eidos;
    float emvadon, anteik, foros;
public:
    ground(int _zwni, float _emvadon, data D);    //oikopedo
    ground(float _emvadon, int _eidos, data D);   //agrotemaxio
    void set_times2(int _zwni,float _emvadon, int _eidos);
    float foros_oik() {return (emvadon*anteik*foros);};
    float foros_agr() {return (emvadon*foros);};
};

class building{
    int zwni,orofoi;
    float emvadon,foros,anteik,meiwsi;
public:
    building(int _zwni,float _emvadon, int _orofoi, data D);   //katoikia
    building(int _zwni,float _emvadon, data D);               //apothiki
    void set_times(int _zwni,float _emvadon,float _orofoi);
    float foros_spi() {return (emvadon*anteik*foros*orofoi);};
    float foros_apo() {return (emvadon*anteik*foros*meiwsi);};
};


class property:private ground, private building{
    float sunolo;
public:
    property(int zwni,float emv_oik,float emv_kti,int orofoi,data D);
    property(int zwni,float emv_oik,float emv_kti,data D);
    property(float emv_oik,int eidos,float emv_kti,int orofoi,data D);
    property(float emv_oik,int eidos,float emv_kti,data D);
    float get_sunolo()  {return sunolo;};
};


data::data(){
    cout << "Arithmos zwmwm: ";
    cin >> n_zwnwn;

    if((ant_oik=(float *)malloc(n_zwnwn*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    if((ant_kti=(float *)malloc(n_zwnwn*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    if((foros_kti=(float *)malloc(n_zwnwn*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }
    if((foros_oik=(float *)malloc(n_zwnwn*sizeof(float)))==NULL){
        cout << "Memory Error!\n";
        exit(1);
    }

    for(int i=0;i<n_zwnwn;i++){
        cout << "Zwni: " << i << " :\n";
        cout << "---------\n";
        cout << "Antikeimeniki axia oikopedwn: ";
        cin >> ant_oik[i];
        cout << "Antikeimeniki axia ktiriwn: ";
        cin >> ant_kti[i];
        cout << "Suntelestis forologisis oikopedwn: ";
        cin >> foros_oik[i];
        cout << "Suntelestis forologisis ktiriwn: ";
        cin >> foros_kti[i];
        cout << "---------------------------------------\n";
    };

    cout << "Suntelestis forologisis agrotemaxiwn me dendrokalliergies: ";
    cin >> foros_dend;
    cout << "Suntelestis forologisis agrotemaxiwn me ethsies kalliergies: ";
    cin >> foros_kall;
    cout << "Suntelestis meiwsis forou apothikwn: ";
    cin >> meiwsi;
}

ground::ground(int _zwni, float _emvadon, data D){
    set_times2(_zwni,_emvadon,0);
    anteik=D.get_ant_oik(zwni);
    foros=D.get_foros_oik(zwni);
}

ground::ground(float _emvadon, int _eidos, data D){
    set_times2(0,_emvadon,_eidos);
    zwni=0;
    if(eidos==1) foros=D.get_foros_dend();
    if(eidos==2) foros=D.get_foros_kall();
    if(eidos!=1 && eidos!=2){
        cout << "ERROR!";
        exit(1);
    }
}

building::building(int _zwni,float _emvadon, int _orofoi, data D){
    set_times(_zwni,_emvadon,_orofoi);
    anteik=D.get_ant_kti(zwni);
    foros=D.get_foros_kti(zwni);
}

building::building(int _zwni,float _emvadon, data D){
    set_times(_zwni,_emvadon,0);
    anteik=D.get_ant_kti(zwni);
    foros=D.get_foros_kti(zwni);
    meiwsi=D.get_meiwsi();
}

void ground::set_times2(int _zwni,float _emvadon,int _eidos){
    zwni=_zwni;
    emvadon=_emvadon;
    eidos=_eidos;
}

void building::set_times(int _zwni,float _emvadon,float _orofoi){
    zwni=_zwni;
    emvadon=_emvadon;
    orofoi=_orofoi;
}


property::property(int zwni,float emv_oik,float emv_kti,int orofoi,data D):ground(zwni,emv_oik,D),building(zwni,emv_kti,orofoi,D){
    sunolo=foros_oik()+foros_spi();
    cout << "Prepei na plirwsete :" << sunolo;
}

property::property(int zwni,float emv_oik,float emv_kti,data D):ground(zwni,emv_oik,D),building(zwni,emv_kti,D){
    sunolo=foros_oik()+foros_apo();
    cout << "Prepei na plirwsete :" << sunolo;
}

property::property(float emv_oik,int eidos,float emv_kti,int orofoi,data D):ground(emv_oik,eidos,D),building(0,emv_kti,orofoi,D){
    sunolo=foros_agr()+foros_spi();
    cout << "Prepei na plirwsete :" << sunolo;
}

property::property(float emv_oik,int eidos,float emv_kti,data D):ground(emv_oik,eidos,D),building(0,emv_kti,D){
    sunolo=foros_agr()+foros_spi();
    cout << "Prepei na plirwsete :" << sunolo;
}


int main()
{
    int menu, zwni,eidos,orofoi;
    float sum,emv_oik,emv_kti;
    int d,m,y;
    int today,date;

    data D;
    sum=0;

    cout << "Hmerominia termatismou tou programmatos: (HH/MM/EEEE)\n";
    cin >> d;
    cin >> m;
    cin >> y;

    date=y*10000+m*100+d;

    while(true){
        cout << "\nKalwsirthate!\n"
             << "1.Oikopedo me oikia.\n"
             << "2.Oikopedo me apothiki.\n"
             << "3.Agrotemaxio me oikia.\n"
             << "4.Agrotemaxio me apothiki.\n";
        cin >> menu;

        if(menu==1){
            cout << "Zwni stin opoia anikei i idioktisia: ";
            cin >> zwni;
            cout << "Emvadon oikopedou: ";
            cin >> emv_oik;

            cout << "Emvadon katoikias: ";
            cin >> emv_kti;
            cout << "Orofoi katoikias: ";
            cin >> orofoi;

            property P(zwni,emv_oik,emv_kti,orofoi,D);
            sum= sum + P.get_sunolo();
    }

        if(menu==2){
            cout << "Zwni stin opoia anikei i idioktisia: ";
            cin >> zwni;
            cout << "Emvadon oikopedou: ";
            cin >> emv_oik;

            cout << "Emvadon apothikis: ";
            cin >> emv_kti;

            property P(zwni,emv_oik,emv_kti,D);
            sum= sum + P.get_sunolo();
        }

        if (menu==3){
            cout << "Eidos Agrotemaxiou:\n"
                 << "1.Gia dentrokalliergies\n"
                 << "2.Gia ethsies Kalliergies:\n";
            cin >> eidos;
            cout << "Emvadon agrotemaxiou: ";
            cin >> emv_oik;

            cout << "Emvadon katoikias: ";
            cin >> emv_kti;
            cout << "Orofoi katoikias: ";
            cin >> orofoi;

            property P(emv_oik,eidos,emv_oik,orofoi,D);
            sum= sum + P.get_sunolo();
        }

        if(menu==4){
            cout << "Eidos Agrotemaxiou:\n"
                 << "1.Gia dentrokalliergies\n"
                 << "2.Gia ethsies Kalliergies:\n";
            cin >> eidos;
            cout << "Emvadon agrotemaxiou: ";
            cin >> emv_oik;

            cout << "Emvadon apothikis: ";
            cin >> emv_kti;

            property P(emv_oik,eidos,emv_kti,D);
            sum= sum + P.get_sunolo();
        }

        time_t now = time(0);
        tm *ltm = localtime(&now);
        today = (1900 + ltm->tm_year)*10000 + (1 + ltm->tm_mon)*100 +(ltm->tm_mday);

        if(today>date){
            cout << "\nTo programma termatistike.";
            break;
        }
    }
    return 0;
}
