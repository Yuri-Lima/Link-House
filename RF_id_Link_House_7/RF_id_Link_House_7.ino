
//Inclusão de bibliotecas
#include "SoftwareSerial.h"
#include <SD.h>
#define butao 2
#define portao 7
#define ledvermelho 32
#define ledverde 31
SoftwareSerial RFID(12, 11); 

//Char ponteiro de cadastro-----------------------------------------------------
char* cartoes[]={"710024D7AF2D","710024D7AF2s","710024D7AF2v","710024D7AF2a","710024D7AF2k"};

//Variaceis Strigs e Char-------------------------------------------------------
String RFleitura="",RFcartao="",cartaonovo="",cartaogravado="";
char leicartao,valorlido;
char lei[17]={};
int leiturabutao=0,funcaolida;

//Classe da biblioteca Sd que ajuda na manipulação de arquivos------------------
//Classe File
File arquivo;
//Para saber o programa inicio ok ou nao
byte inicio_ok;


//Inicio da função Setup--------------------------------------------------------
void setup()  
{ 
  pinMode(ledverde,1);
  pinMode(ledvermelho,1);
  pinMode(butao,INPUT_PULLUP);
  pinMode(portao,1);
  pinMode(4, 1); 
  
  Serial.begin(9600);
  RFID.begin(9600);
  
  
  //Não inicia o Sd, se não tiver cartão----------------------------------------
   inicio_ok=1;
  if(!SD.begin(4)){
    Serial.println("Erro ao iniciar cartao SD");
    Serial.println("Diagnostico: Sem cartao SD");
    inicio_ok=1;
    return;
  }
  else{
    Serial.println("Cartao SD Iniciado");
  }
  Serial.println("Passe o cartao!");
}// Fecha Setup----------------------------------------------------------------

char i;
void cadastro(){
  Serial.println("Passe o cartao novo.");
  while(1){
    if(RFID.available()){
      for(i=0;i<=15;i++){
        lei[i]=RFID.read();
        delay(10);
     }
     if (sizeof(lei)>=15){
        arquivo=SD.open("cadastro.txt",FILE_WRITE);
        if(arquivo){
          arquivo.println(lei);
          Serial.print("Cartao salvo com sucesso!: ");
          Serial.print(lei);
          //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
          arquivo.close();
          break;
        }
        else{
          Serial.println("Erro ao abrir o arquivo para escrita");
        }
      }
    }//Fecha If RFID available*/
  }//Fecha While flag
 return;
}//Fecha Funcao Cadastro------------------------------------------------------
void desabilitar(){
  SD.remove("cadastro.txt");
    if(!SD.exists("cadastro.txt")){
      Serial.println("Cartoes apagados com sucesso");
    }
    else{
      Serial.println("Erro ao apagar os cartoes, tente novamente!");
    } 
}//Fecha Desabilitar-----------------------------------------------------------

void ativos(){
 
  arquivo = SD.open("cadastro.txt",FILE_READ);
  if (arquivo) {
    Serial.println("Cartoes cadastrado: ");
    while (arquivo.available()) {
      Serial.write(arquivo.read());
    }
    arquivo.close();
  }
    else{
      Serial.println("Nenhum arquivo encontrado");
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
        arquivo=SD.open("Cadastro.txt");
        if(arquivo){
          while(arquivo.available()){
            leicartao = arquivo.read();
            cartaogravado += leicartao;
          }//fecha while Sd open---------------------------------------------------
          arquivo.close();
          Serial.println("Cartao salvo no SD: ");
          Serial.println(cartaogravado.substring(1,13));
          Serial.println(cartaogravado.substring(19,31));
          Serial.println(cartaogravado.substring(37,49));
          Serial.println(cartaogravado.substring(55,67));
          Serial.println(cartaogravado.substring(73,85));
          Serial.println(cartaogravado.substring(91,103));
          Serial.println(cartaogravado.substring(109,121));
          Serial.println(cartaogravado.substring(127,139));
          Serial.println(cartaogravado.substring(145,157));
          Serial.println(cartaogravado.substring(163,175));
          Serial.println(cartaogravado.substring(181,193));
        }//Fecha if arquivo------------------------------------------------------------
        else{
          Serial.println("Erro ao abrir o arquivo de leitura");
        }
       
         for (int i=0;i<5;i++) {            
           if (RFleitura.substring(1,13).equals(cartoes[i])){
             Serial.println("Usuario Valido!");
             Serial.println("Acesso Liberado!");break;
            }//Fecha if equals------------------------------------------------------
            else if(i==4){
              Serial.println("Usuario Invalido");
              Serial.println("Acesso Negado");
            }

          } //Fecha for--------------------------------------------------------------
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
          default: Serial.println("Funcao invalida");
          return;
        }//Fecha Switch funcaolida---------------------------------------------
      }//Fecha While Serial----------------------------------------------------
    }////Fecha While 1-----------------------------------------------------------
    RFleitura= ""; //Zera a variavel RFleitura
  }//Fecha Inicio_ok
}//Fecha loop-----------------------------------------------------------------

