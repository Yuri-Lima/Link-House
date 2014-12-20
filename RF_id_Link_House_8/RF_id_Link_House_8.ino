// TESTE RFID ID12.ino

//Inclusão de bibliotecas
#include "SoftwareSerial.h"
#include <SD.h>
#define botao 2
SoftwareSerial RFID(12, 11);

//Variaceis Strigs e Char-------------------------------------------------------
String RFleitura="",cartaogravado="",opcao="",Leite="";
char leicartao, leiturabutao,funcaolida;
char lei[17]={};
char valorlido[17]={};

//Classe da biblioteca Sd que ajuda na manipulação de arquivos------------------
//Classe File
File arquivo;
File Doc;
//Condicao para ir para o loop se o cartao sd estiver ok
byte ok;
String desativado="000000000000\0";
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

void Desabilitar(){
  int m;
  Serial.println("Passe o cartao que que vai Desabilitar.");
  while(1){
    if(RFID.available()){
      for(int i=0;i<=15;i++){
        lei[i]=RFID.read();
        delay(10);
      }
      if (sizeof(lei)>=15){
        Leite=lei;

        AbrirSD(); 
        boolean flag=false; 
        for(m=0;m<686;m+=14){ 
          if(Leite.substring(1,13).equals(cartaogravado.substring(m,m+12))){
            flag=true;
            break;
          }
        }
        if (flag){
          Serial.println(cartaogravado.substring(m,m+12));
          Serial.print("Posição da gravação: ");
          Serial.println(m); 

          Serial.println("Cartao desabilitado com sucesso!");
          arquivo=SD.open("cadas.txt",FILE_WRITE);
          if(arquivo){
            arquivo.seek(m);
            arquivo.println(desativado.substring(0,12));
            cartaogravado="";
            //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
            arquivo.close();
            break;
          }
          else{
            Serial.println("Erro ao abrir o arquivo para escrita");
          }
          Menu();
        }//Fecha if -----------------------------------------------------------------
        else{
          Serial.println("Este cartão está desabilitado!");
          Serial.println("Procure a administração!");
          Menu();
          break;
        }
      }
    }//Fecha If RFID available
  }//Fecha While flag
 
}//Fecha Funcao Cadastro------------------------------------------------------

void Cadastro(){
  
  int m,b;
  
  boolean flag=false;
  AbrirSD();
  Serial.println("Passe o cartao novo.");
  while(1){
    if(RFID.available()){
      for(int i=0;i<=15;i++){
        lei[i]=RFID.read();
        delay(10);
      }
      if (sizeof(lei)>=15){
        Leite=lei;
        
        for(m=0;m<686;m+=14){ 
          if(Leite.substring(1,13).equals(cartaogravado.substring(m,m+12))){
            Serial.print("Este cartão já esta cadastrado! ");
            Serial.println(m);
            return;
          }
        }
          if(m==686){
            Serial.println("m=686");
              for(b=0;b<686;b+=14){ 
                if (desativado.substring(0,12) == (cartaogravado.substring(b,b+12))){
                  flag=true;
                  break;
                }
              }
          }    
            if(flag){
              arquivo=SD.open("cadas.txt",FILE_WRITE);
              Serial.println(m);
              arquivo.seek(b);
              arquivo.println(Leite.substring(1,13));
              Serial.print("Cartao salvo com sucesso1!: ");
              Serial.println(Leite.substring(1,13));
              //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
              arquivo.close();
              Serial.println("Yuri ok");
              break;
            }
            else {
              arquivo=SD.open("cadas.txt",FILE_WRITE);
              arquivo.println(Leite.substring(1,13));
              Serial.print("Cartao salvo com sucesso2!: ");
              Serial.println(Leite.substring(1,13));
              //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
              arquivo.close();
              break;
            }
           
          
          
      }
        Menu();
        //Fecha if -----------------------------------------------------------------
    }//Fecha If RFID available*/
  }//Fecha While flag
}//Fecha Funcao Cadastro------------------------------------------------------
void ExcluirArq(){

 SD.remove("cadas.txt");
  if(!SD.exists("cadastro.txt")){
    Serial.println("Cartoes apagados com sucesso");
    cartaogravado="";
  }
  else{
    Serial.println("Erro ao apagar os cartoes, tente novamente!");
  } 
}//Fecha ExcluirArq-----------------------------------------------------------

void Ativos(){
 arquivo = SD.open("cadas.txt",FILE_READ);
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
}//Fecha Ativos------------------------------------------------------------------- 

void Menu(){
  
  if (digitalRead(botao)==HIGH) {
    //Entra no modo função
    Serial.println("Qual a funcao do menu voce deseja?");
    Serial.println();
    Serial.println("1 - Cadastro de novo cartao.");
    Serial.println();
    Serial.println("2 - Excluir arquivo.");
    Serial.println();
    Serial.println("3 - Cartoes ativos.");
    Serial.println();
    Serial.println("4 - Desabilitar cartão.");
    Serial.println();
    delay(100);
  }//Fecha if HIGH-------------------------------------------------------------
  delay(10);
  //while(leiturabutao==HIGH){
    while (Serial.available()){
      funcaolida = Serial.read();
      switch (funcaolida) {
        case '1': Cadastro();
        return;
        break;
        case '2': ExcluirArq();
        return;
        break;
        case '3': Ativos();
        return;
        break;
        case '4': Desabilitar();
        return;
        break;
        default: Serial.println("Funcao invalida");
        return;
      }//Fecha Switch funcaolida-------------------------------------------------
    }//Fecha While Serial--------------------------------------------------------
  //}//Fecha While HIGH------------------------------------------------------------
}//Fecha Leiturabotao()----------------------------------------------------------

void Verificar(){
 // Faz as comparações com o que esta gravado no SD e com o ponteiro char* cartoes[]  
  AbrirSD(); 
  boolean flag=false; 
  for(int m=0;m<686;m+=14){ 
  	if(RFleitura.substring(1,13).equals(cartaogravado.substring(m,m+12))){
  		flag=true;
  		Serial.print(m); Serial.print(",");
		  Serial.println(m+12);	
  		break;
  	}
  }
  if (flag){
   	
  
    Serial.println("Usuario Valido!");
    Serial.println("Acesso Liberado!");
    Menu();
    //Cargas();
  }//Fecha if -----------------------------------------------------------------
  else{
    Serial.println("Acesso Negado");
    Serial.println("Fale com a Administracao");
    Menu();
    //Recadastro();
  }
}
void Cargas(){
return;
}
void AbrirSD(){
//Abrir arquivo SD -------------------------------------------------------- 
  arquivo=SD.open("cadas.txt");
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
    for(int j=0;j<=15;j++){
      valorlido[j]= RFID.read();                         //Valolido é char
      delay(10);
    }
    if (sizeof(valorlido)>=15){                          //Verifica o tamanho de valorlido
     Serial.print("Numero do Cartao: ");
      for(int j=1;j<=14;j++){                           //Faz a leitura do array valor lido sem lixo
        Serial.print(valorlido[j]);                      //A posição [0] e [15] são espaços em branco
        RFleitura=valorlido;                             //Armazena na Strnig RFleitura para posterior comparação com cartões guardados no SD     
      }       
      Verificar();
    }//Fecha SizaOf-------------------------------------------------------------
  }//Fecha primeiro While-------------------------------------------------------
}

void loop(){ 
  if(ok){
    Passatag();
    Menu(); 
  }//Fecha Inicio_ok
}//Fecha loop-------------------------------------------------------------------
