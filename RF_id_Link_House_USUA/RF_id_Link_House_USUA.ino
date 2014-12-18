
//Inclusão de bibliotecas
#include "SoftwareSerial.h"
#include <SD.h>
#define botao 2
SoftwareSerial RFID(12, 11); 

//Variaceis Strigs e Char-------------------------------------------------------
String RFleitura="",cartaogravado="",opcao="";
char leicartao, leiturabutao,funcaolida;
char lei[17]={};
char valorlido[17]={};

//Classe da biblioteca Sd que ajuda na manipulação de arquivos------------------
//Classe File
File arquivo;
//Condicao para ir para o loop se o cartao sd estiver ok
byte ok;

//Inicio da função Setup--------------------------------------------------------
void setup(){ 
  pinMode(botao,INPUT_PULLUP);
  Serial.begin(9600);
  RFID.begin(9600);
   
  //Não vai pro loop, se não tiver cartão----------------------------------------
  ok=1;
  if(!SD.begin(4)){
    Serial.println("Erro ao iniciar cartao SD");
    Serial.println("Diagnostico: Sem cartao SD");
    ok=1;
    return;
  }
  else{
    Serial.println("Cartao SD Iniciado");
  }
  Serial.println("Passe o cartao de acesso!");
}// Fecha Setup----------------------------------------------------------------

void Verificar(){
 // Faz as comparações com o que esta gravado no SD e com o ponteiro char* cartoes[]       
  if ( RFleitura.substring(1,13).equals(cartaogravado.substring(0,12))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(14,26))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(28,40))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(42,54))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(56,68))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(70,82))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(84,96))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(98,110))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(112,124))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(126,138))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(140,152))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(154,166))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(168,180))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(182,194))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(196,208))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(210,222))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(224,236)) 
    || RFleitura.substring(1,13).equals(cartaogravado.substring(238,250))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(252,264))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(266,278))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(280,292))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(294,306))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(308,320))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(322,334))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(336,348))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(350,362))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(364,376))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(378,390))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(392,404))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(406,418))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(420,432))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(434,446))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(448,460))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(462,474))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(476,488))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(490,502))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(504,516))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(518,530))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(532,544)) 
    || RFleitura.substring(1,13).equals(cartaogravado.substring(546,558))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(560,572))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(574,586))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(588,600))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(602,614))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(616,628))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(630,642))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(644,656))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(658,670))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(672,684))
    || RFleitura.substring(1,13).equals(cartaogravado.substring(686,698)) 
    //Para aumentar o numero de comparações: cartaogravado.substring(487 + 18,481 + 18)
   ){
    Serial.println("Usuario Valido!");
    Serial.println("Acesso Liberado!");
    Cargas();
  }//Fecha if -----------------------------------------------------------------
  else{
    Serial.println("Acesso Negado");
    Serial.println("Fale com a Administração");
    //Recadastro();
  }
}
void Cargas(){
return;
}
void AbrirSD(){
//Abrir arquivo SD -------------------------------------------------------- 
  arquivo=SD.open("Cadastro.txt");
  if(arquivo){
    while(arquivo.available()){
      leicartao = arquivo.read();                    //leicartao é char
      cartaogravado += leicartao;                    //cartaogravado String
    }//fecha while Sd open---------------------------------------------------
    arquivo.close();
  }//Fecha if arquivo--------------------------------------------------------
  else{
    //Serial.println("Erro ao abrir o arquivo de leitura");
  }
}
void Passatag(){
  //Inicio das leituras dos cartoes ou tags-------------------------------------
  while(RFID.available()){
    for(char j=0;j<=15;j++){
      valorlido[j]= RFID.read();                         //Valolido é char
      delay(10);
    }
    if (sizeof(valorlido)>=15){                          //Verifica o tamanho de valorlido
     Serial.print("Numero do Cartao: ");
      for(char j=1;j<=14;j++){                           //Faz a leitura do array valor lido sem lixo
        Serial.print(valorlido[j]);                      //A posição [0] e [15] são espaços em branco
        RFleitura=valorlido;                             //Armazena na Strnig RFleitura para posterior comparação com cartões guardados no SD     
      }       
        AbrirSD();
        Verificar();
    }//Fecha SizaOf-------------------------------------------------------------
  }//Fecha primeiro While-------------------------------------------------------
}

void loop(){ 
  if(ok){
    Passatag();
   
  }//Fecha Inicio_ok
}//Fecha loop-------------------------------------------------------------------
