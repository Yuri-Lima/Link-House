// Inclusão das bibliotecas

#include <SPI.h>            // Para comunicação com Sd-card, chip MP3 e o RC522
#include <SdFat.h>          // Sistema do Sd-card
#include <SFEMP3Shield.h>   // Decodificador Mp3
//===============================================================================
#include <MFRC522.h> 
#define SS_PIN A4     //Um dos pinos de Comunicação SPI
#define RST_PIN 12    //Um dos pinos de Comunicação SPI
MFRC522 mfrc522(SS_PIN, RST_PIN);   // Cria uma instancia MFRC522 da biblioteca para os pinos.

//===============================================================================
//Controle de volume
//#define VOLUME 1
unsigned char volume = 15; //Esse é o volume ideal para tocar a musica toda de acordo com os teste que fiz!
//Quanto mais aumentar o valor menor será o volume!
//===============================================================================
//Controle do chip amplificador
const int EN_GPIO1 = A2; // Amp enable + MIDI/MP3 mode select
const int SD_CS = 9;     // Chip Select for SD card
//===============================================================================
//Define a quantidade de Muscas que tem no SD card
#define QNTD 10
//===============================================================================
// Objetos da boblioteca:

SFEMP3Shield MP3player;
SdFat sd;
//===============================================================================
//Para debugar no Serial Monitor
boolean debugging = true;
//===============================================================================
//Variaveis para controle dos arquivos e visualização dos mesmos.
char filename[QNTD][20];
int x, index;
byte result;
char tempfilename[20];
//===============================================================================

void setup()
{
  //========================================================================
  Serial.begin(9600);   // Inicia Serial
  SPI.begin();          // Inicia SPI
  mfrc522.PCD_Init();   // Inicia MFRC522
  //========================================================================
  
  Serial.println("----------------- Programa para Deficiente Visuais ou Daltonismo!-----------------");
  Serial.println();
 //========================================================================
 // Ativa o Chip amplificador  

 pinMode(EN_GPIO1,OUTPUT);
 digitalWrite(EN_GPIO1,LOW);  // Modo MP3/ desativado. Amp Off  
 if (debugging){
    SdCard();
    Serial.println("");
    Serial.println(F("Aproxime o seu cartao do leitor..."));
    Acesso();
  }
}
//========================================================================
boolean flag=true; //Variavel de controle do loop do RC522
String UID="";    //Inicializa a string vazia
int a=1;         //Controle de arquivo não existente

void Acesso(){
  if(flag){
    // Esperar continuamente até que se passe uma tag
    if ( ! mfrc522.PICC_IsNewCardPresent()){
      return;
    }
    // Assim que detectado, é feito a leitura
    if ( ! mfrc522.PICC_ReadCardSerial()){
      return;
    }
    //Feito tratamento da leitura para armazenar como String na forma HEXDECIMAL
    Serial.print("UID da tag :");
    for (byte i = 0; i < mfrc522.uid.size; i++){//vê o tamanho o UID que é em modulos
      UID.concat(String(mfrc522.uid.uidByte[i]< 0x10 ? " 0" : " "));
      UID.concat(String(mfrc522.uid.uidByte[i], HEX));
    }
    //Tratamento de Case Sensitive anulado, pois tudo vai para maiusculo
    UID.toUpperCase();
    Serial.print(String(UID));
    Serial.println();
    Serial.print("Mensagem: ");
    //Condição de entrada para tocar uma musica especifica        
    if (String(UID) == " 63 92 65 86"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else if(String(UID) == " 63 6B 61 86"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else if(String(UID) == " 62 E3 F4 FA"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else if(String(UID) == " 2E DE 48 B5"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else if(String(UID) == " 8C 0A FF 04"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else if(String(UID) == " 07 73 B4 BF"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else if(String(UID) == " 54 34 15 15"){
      Serial.println("Acesso liberado!");
      delay(200);
      TocarMusica();
      flag=false;
    }
    else{
      UID="";
      Serial.println("Cartao invalido!");
      delay(300);
      return;
    }
  } 
}

void Musica(){
  //====================================================================================  
  int t;              // Numero da musica a ser tocada
  byte result;        //Controle do range de musicas do SD CARD
   
  if(String(UID) == " 63 92 65 86"){
    t=1;
    goto play;
  }
  else if(String(UID) == " 63 6B 61 86"){
    t=2;
    goto play;
  }
  else if(String(UID)== " 62 E3 F4 FA"){
    t=3;
    goto play;
  }
  else if(String(UID) == " 2E DE 48 B5"){
    t=4;
    goto play;
  }
  else if(String(UID) == " 8C 0A FF 04"){
    t=5;
    goto play;
  }
  else if(String(UID) == " 07 73 B4 BF"){

    t=6;
    goto play;
  }
  else if(String(UID) == " 54 34 15 15"){

    t=7;
    goto play;
  }
  play:
  //Testa se tem arquivo com nome de arquivo diferente das leituras
  if (filename[t-1][0] == 0 && a==1){
    if (debugging){
      Serial.println(F("Nao existe arquivo com este numero! Renomeios."));
      a=2;
    }  
  }
  else{ 
    result = MP3player.playMP3(filename[t-1]);
    if (result == 0){
      if(debugging){
        if(result != 0){
          Serial.print(F("Error "));
          Serial.print(result);
          Serial.print(F(" ao tentar tocar a musica! "));
        }
        else{
          Serial.print(F("Tocando "));
          Serial.println(filename[t-1]);
          
        }
      }
    }
  }
}
void loop()
{
  Acesso();
  Musica();
}  
//====================================================================================================================================== 
//A inicialização do SDcard tem que ser separada pois ele utiliza a mesma porta de comunicação do leitor REFID e fica dando conflito
void SdCard(){
  // Inicia  SD-CARD; SS = pin 9, half speed at first
  SdFile file;
  if (debugging){ 
    Serial.print(F("SD card Inicializando... "));
    result = sd.begin(SD_CS, SPI_HALF_SPEED); // 1 para ok sucesso
  }
  if (result != 1){ // Problema na inicialização do Sd-card
    if (debugging) {
      Serial.print(F("error, de leitura"));
    }
  }
  else{
    if (debugging){
      Serial.println(F("Sucesso!"));
    }
  }  
  if (debugging){ 
    Serial.print(F("Inicializa o Chip MP3... "));
    result = MP3player.begin(); // 0 or 6 for success
  }
  // Checa o result para ver se deu algum erro
  if ((result != 0) && (result != 6)){ // Problemas no inicio da MP3player.begin();
    if (debugging){
      Serial.print(F("error code "));
      Serial.print(result);
      Serial.print(F(", persistente."));
    }
  }
  else{
    if (debugging){Serial.println(F("Sucesso!"));}
  }
  // Agora ele ler o SD card para ver os arquivos
  if (debugging){ 
    Serial.println(F("Fazendo leitura dos arquivos..."));
    delay(200);
  }
  // Start at the first file in root and step through all of them:
  sd.chdir("/",true);
    while (file.openNext(sd.vwd(),O_READ)){
    // pega filename
    file.getFilename(tempfilename);
    // Aqui voce vai definir quantas musicas tem de 1 a  dentro do SD car.
    if (tempfilename[0] >= '1' || tempfilename[0] <= 'QNTD'){
     // Subtrair caractere "1" para obter um índice de 0 a QNTD.
     index = tempfilename[0] - '1';
     //Imprimi o Numero e o Nome da Musica
     strcpy(filename[index],tempfilename);
     if (debugging){
        Serial.print(F("Encontrado arquivo"));
        //Serial.print(index+1);
        Serial.print(F(": "));
        Serial.println(filename[index]);
      }
    }
    file.close();
  }
}
void TocarMusica(){
 // Seta o chip amplificador VS1053 com os volumes da direita e esquerda.
 MP3player.setVolume(volume,volume);
 // Liga o chip amplificador. Se tiver desligado a musica não toca.
 digitalWrite(EN_GPIO1,HIGH);
 delay(5); 
 if (debugging){
    Serial.print(F("volume "));
    Serial.println(volume);
  } 
  Acesso();
}