
//Inclusão de bibliotecas
#include "SoftwareSerial.h"

#include <EEPROM.h>
#include <SD.h>

SoftwareSerial RFID(12, 11); 

//Char ponteiro de cadastro-----------------------------------------------------
char* cartoes[]={"710024D7AF2D"};

//Variaceis Strigs e Char-------------------------------------------------------
String RFleitura="",RFcartao="",leitura="",cartaonovo="",cartaogravado="";
char leicartao,valorlido;

//Variaveis Inteiras------------------------------------------------------------
int ledverde=31,ledvermelho=32,butao=2,leiturabutao=0,funcaolida,portao=7;

//Classe da biblioteca Sd que ajuda na manipulação de arquivos------------------
//Classe File
File arquivo;



//Para saber o programa inicio ok ou nao
byte inicio_ok;


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

void cadastro(){
 boolean cadastro=true;
  Serial.println("Passe o cartao novo.");
  while(cadastro){
    if(RFID.available()){
      valorlido = RFID.read();
      leitura += valorlido;
      delay(5);
//Escrevendo na EEPROM---------------------------------------------------------      
      /*
      for(int j=1;j<=12;j++){
      EEPROM.write(j,leitura[j]-48);
      }
      */
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
   
//Leitura na EEPROM------------------------------------------------------------
       /*       
        for(int c=1;c<=12;c++){
        leitura += EEPROM.read(c);
        cartaonovo=leitura;
      }*/
//Imprimi a tags salva na EEPROM-----------------------------------------------      
      //Serial.println(cartaonovo);
      
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
  
//Inicio das leituras dos cartoes ou tags------------------------------------
 
  while(RFID.available()){
    valorlido= RFID.read();
    delay(5);
    RFleitura += valorlido;
    if (RFleitura.length()>=16 ){
      Serial.print("Numero do Cartao:");
      Serial.println(RFleitura);
      
      
    //Abri os dados dos cartoes salvos                                              
    /*
       for(int c=1;c <=12;c++){
         leitura += EEPROM.read(c);
         cartaonovo=leitura;
         }//Fecha for
         Serial.print("TAG salva na EEPROM: ");
         Serial.println(cartaonovo);
    */     
      
    //Abrir arquivo SD -------------------------------------------------------------- 
      arquivo=SD.open("Carte.txt");
      if(arquivo){
        while(arquivo.available()){
          leicartao = arquivo.read();
          cartaogravado += leicartao;
     }//fecha while Sd open---------------------------------------------------
        arquivo.close();
          Serial.print("Cartao salvo no SD: ");
          Serial.println(cartaogravado.substring(1,13));
          //Serial.println(cartaogravado.substring(19,31));
          //Serial.println(cartaogravado.substring(37,49));
       
     }//Fecha if arquivo------------------------------------------------------------
      
      else{
        Serial.println("Erro ao abrir o arquivo de leitura");
      }
      //for (int j=1, i=0, m=13;  j<=37, i<=5, m<=49; j+18, i++, m+18)
      //for (int j=1, i=0, m=13;  j<=37, i<=5, m<=49; j++, i++, m++)
      //Comparando os dados das tags de fabrica || salvas na EEPROM ------------------
      //for (int j=1, m=13; j<=37, m<=49; j+18, m+18)
      //while(j<=1009 && i<=5 && m<=1021)
      //while(j<=73 && i<=1500 && m<=67 )
      //while(j<=91 && i<=1500 && m<=103 )
      // for (int i=0;i<=5;i++)
       int j=1, i=0, m=13;
       boolean condicao=false;
        while(j<=91 && i<=1500 && m<=103) {            
         if (RFleitura.substring(1,13).equals(cartoes[i])|| RFleitura.substring(1,13).equals(cartaogravado.substring(j,m))){
           condicao=true;
           Serial.println(j);
           Serial.println(m);
           Serial.println("Usuario Valido!");
           Serial.println("Acesso Liberado!");
           digitalWrite(ledverde,HIGH);
           digitalWrite(portao,HIGH);
           delay(500);
           digitalWrite(ledverde,LOW);
           digitalWrite(portao,LOW);
           break;
                            
        }//Fecha if equals------------------------------------------------------
       
       j+=18;
       m+=18;
       i++;
      }//Fecha for--------------------------------------------------------------
      if (!condicao){
           Serial.println("Usuario Invalido");
           Serial.println("Acesso Negado");
           digitalWrite(ledvermelho,HIGH);
           delay(1500);
           digitalWrite(ledvermelho,LOW);
           
       }
      
     }//Fecha RFleitura.length()------------------------------------------------
   
  
}//Fecha primeiro While-------------------------------------------------------
    
  RFleitura= ""; //Zera a variavel RFleitura
  
 
  
  }//Fecha Inicio_ok
}//Fecha loop-----------------------------------------------------------------

