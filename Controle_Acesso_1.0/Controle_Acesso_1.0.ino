
//Inclusão de bibliotecas
#include "SoftwareSerial.h"
#include <SD.h>

SoftwareSerial RFID(12, 11); 

//Char ponteiro de cadastro-----------------------------------------------------
char* cartoes[]={"710024D7AF2D","590010905188","710024F48D2C"};

//Variaceis Strigs e Char-------------------------------------------------------
String RFleitura="",RFcartao="",leitura="",cartaonovo="",cartaogravado="",NomeCompleto;
char leicartao,valorlido, Nome;

//Variaveis Inteiras------------------------------------------------------------
int ledverde=31,ledvermelho=32,butao=2,leiturabutao=0,funcaolida,portao=7;

//Classe da biblioteca Sd que ajuda na manipulação de arquivos------------------
//Classe File
File arquivo;

//Cronometro
static unsigned long h=0,m=0,s;

//Para saber o programa inicio ok ou nao
byte inicio_ok;

boolean cadas=true;


//Inicio da função Setup--------------------------------------------------------
void setup()  
{ 
  pinMode(ledverde,OUTPUT);
  pinMode(ledvermelho,OUTPUT);
  pinMode(butao,INPUT_PULLUP);
  pinMode(portao,OUTPUT);
  pinMode(4, OUTPUT); 
  
  Serial.begin(9600);
  
  Serial.println("Serial Ok");
  RFID.begin(9600);
  Serial.println("Rfid Ok");
 
  
  //Não inicia o Sd, se não tiver cartão----------------------------------------
   inicio_ok=1;
  if(!SD.begin(4)){
    Serial.println("Erro ao iniciar cartao SD");
    Serial.println("Diagnostico: Sem cartao SD");
    inicio_ok=0;
    return;
  }
  else{
    Serial.println("Cartao SD Iniciado");
  }
  
}// Fecha Setup----------------------------------------------------------------


void nome(){
  
Serial.println("Digite seu nome: ");

          if (Serial.available() > 0) {
                // read the incoming byte:
                Nome = Serial.read();

                // say what you got:
                Serial.print("I received: ");
                Serial.println(Nome, DEC);
        }
        
    }


void cadastro(){
  
 Serial.println("Passe o cartao novo: ");       
 boolean cadastro=true;
   while(cadastro){
    if(RFID.available()){
      valorlido = RFID.read();
      leitura += valorlido;
      delay(5);

//Compara o tamanho da variavel leitura----------------------------------------      
   if (leitura.length()>=16){
     arquivo=SD.open("Carte.txt",FILE_WRITE);
     if(arquivo){
       arquivo.println(leitura);
 //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
     arquivo.close();
   }
   else{
     Serial.println("Erro ao abrir o arquivo para escrita");
   }
   Serial.print("Cartao salvo com sucesso!: ");
   Serial.println(leitura);
   cadastro=false;
      
   }//Fecha  If Length
  }//Fecha If RFID available
 }//Fecha While flag
}//Fecha Funcao Cadastro------------------------------------------------------


void desabilitar(){
  Serial.println("Desabilitar ok");
  SD.remove("Carte.txt");
    if(!SD.exists("Carte.txt")){
    Serial.println("Cartoes apagados com sucesso");
    }
  else{
    Serial.println("Erro ao apagar os cartoes, tente novamente!");
  }  
}//Fecha Desabilitar-----------------------------------------------------------

void ativos(){
  
  if(ativos){
  arquivo = SD.open("carte.txt");
  if (arquivo) {
    Serial.println("Nome do arquivo: carte.txt");
    Serial.println("Cartoes cadastrado: ");
    while (arquivo.available()) {
    	Serial.write(arquivo.read());
    }
    arquivo.close();
  } else 
    {
    Serial.println("Nenhum arquivo para leitura!");
  }
 }

}//Fecha Ativos----------------------------------------------------------------    
  

void loop() 
{
if (inicio_ok){
     
   //Inicio das leituras dos cartoes ou tags------------------------------------
 
  while(RFID.available()){
    valorlido= RFID.read();
    delay(5);
    RFleitura += valorlido;
    if (RFleitura.length()>=16 ){
      Serial.print("Numero do Cartao:");
      Serial.println(RFleitura);
       
    //Abrir arquivo SD -------------------------------------------------------------- 
      arquivo=SD.open("Carte.txt");
      if(arquivo){
        while(arquivo.available()){
          leicartao = arquivo.read();
          cartaogravado += leicartao;
     }//fecha while Sd open---------------------------------------------------
        arquivo.close();
          Serial.print("Cartao salvo no SD: ");
          if("/n")
          Serial.println(cartaogravado);
          //Serial.println(cartaogravado.substring(19,31));
          //Serial.println(cartaogravado.substring(37,49));
       
     }//Fecha if arquivo------------------------------------------------------------
      
      else{
        Serial.println("Erro ao abrir o arquivo de leitura");
      }
     //Comparando os dados das tags de fabrica || salvas na EEPROM ------------------
     
        for (int i=0;i<=5;i++) {            
         if (RFleitura.substring(1,13).equals(cartoes[i])){
         
           if (RFleitura.substring(1,13).equals(cartoes[0])){
             Serial.println("Ola, Yuri seja bem vindo!");}
             
           if (RFleitura.substring(1,13).equals(cartoes[1])){
             Serial.println("Ola,Patricia seja bem vinda!");}
             
           if (RFleitura.substring(1,13).equals(cartoes[2])){
             Serial.println("Ola,Isaac seja bem vindo!");}
             
           if (RFleitura.substring(1,13).equals(cartoes[3])){
             Serial.println("Ola,Izabelle seja bem vinda!");}
             
           if (RFleitura.substring(1,13).equals(cartoes[4])){
             Serial.println("Ola,Didi seja bem vindo!");}
      
  }//Fecha while equals------------------------------------------------------

    
}//Fecha for--------------------------------------------------------------
      /*if (!condicao){
           Serial.println("Usuario Invalido");
           Serial.println("Acesso Negado");
           digitalWrite(ledvermelho,HIGH);
           delay(1500);
           digitalWrite(ledvermelho,LOW);
           
       }*/
      
     }//Fecha RFleitura.length()------------------------------------------------
   
  
}//Fecha primeiro While-------------------------------------------------------
     
     
     
     
     
     
    leiturabutao = digitalRead(butao);
    if (leiturabutao==HIGH) {
    //Entra no modo função
       Serial.println("Digite qual a funcao voce deseja realizar.");
       Serial.println();
       Serial.println("1 - Cadastro de novo cartao.");
       Serial.println();
       Serial.println("2 - Desabilitar cartao.");
       Serial.println();
       Serial.println("3 - Quantos cartoes ativos.");
       Serial.println();
      
   }//Fecha if HIGH-----------------------------------------------------------
   
  delay(5);
  while(leiturabutao==HIGH){
   while (Serial.available()){
      funcaolida = Serial.read();
      switch (funcaolida) {
        case '1': cadastro();
        return;
        break;
        case '2': desabilitar();
        return;
        break;
        case '3': ativos();
        return;
        break;
        case '4': nome();
        return;
        break;
        default: Serial.println("Funcao invalida");
        return;
        
      }//Fecha Switch funcaolida---------------------------------------------
   }//Fecha While Serial----------------------------------------------------
   
}////Fecha While 1-----------------------------------------------------------
  

    
  RFleitura= ""; //Zera a variavel RFleitura
  
 
  
  }//Fecha Inicio_ok
}//Fecha loop-----------------------------------------------------------------

