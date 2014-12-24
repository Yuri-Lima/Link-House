// TESTE RFID ID12.ino

//Inclusão de bibliotecas
#include "SoftwareSerial.h"
#include <Ethernet.h>
#include <SPI.h>
#include <SD.h>

#define botao 2

SoftwareSerial RFID(12, 11);

//Variaceis Strigs e Char-------------------------------------------------------
String RFleitura="",cartaogravado="",Leite="";
char leicartao, leiturabutao;
char lei[17]={};
char valorlido[17]={};
char* Carga[]={"Nome"};
char nome[50]={};


//Classe da biblioteca Sd que ajuda na manipulação de arquivos------------------
//Classe File
File arquivo;
File Doc;
//Condicao para ir para o loop se o cartao sd estiver ok
byte ok;
byte estadoip=0x00;                             //Variavel de teste. Se conexão interna ou externa
boolean Estado=false;
boolean flag2=false;

String desativado="000000000000\0";
 


byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
  IPAddress ip(192,168,25,177);                  // assign an IP address for the controller: 
  IPAddress gateway(192,168,25,2);    
  IPAddress subnet(255, 168, 25, 240);
  EthernetServer server(80);


//Inicio da função Setup--------------------------------------------------------
void setup(){ 
  Ethernet.begin(mac, ip);
  pinMode(botao,INPUT_PULLUP);
  Serial.begin(9600);
  Serial2.begin(9600);
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
          //Menu();
        }//Fecha if -----------------------------------------------------------------
        else{
          Serial.println("Este cartão está desabilitado!");
          Serial.println("Procure a administração!");
          //Menu();
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
    //Realiza a leitura da tag que será cadastrada
    if(RFID.available()){
      for(int i=0;i<=15;i++){
        lei[i]=RFID.read();
        delay(10);
      }
      if (sizeof(lei)>=15){
        Leite=lei;
        //Ver se o cartão já está gravado no SD
        for(m=0;m<686;m+=14){ 
          if(Leite.substring(1,13).equals(cartaogravado.substring(m,m+12))){
            Serial.print("Este cartão já esta cadastrado! ");
            Serial.println(m);
            return;
          }
        }
        //Ver se tem alguma cadastro com linha zerada "000000000000\0" no SD
        if(m==686){
          Serial.println("m=686");
          for(b=0;b<686;b+=14){ 
            if (desativado.substring(0,12) == (cartaogravado.substring(b,b+12))){
              flag=true;
              break;
            }
          }
        }
        //Se tiver linha zerada ele cadastra por cima dessa linha    
        if(flag){
          arquivo=SD.open("cadas.txt",FILE_WRITE);
          Serial.println(b);
          arquivo.seek(b);
          arquivo.println(Leite.substring(1,13));
          Serial.print("Cartao salvo com sucesso1!: ");
          Serial.println(Leite.substring(1,13));
          //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
          arquivo.close();
          Serial.println("Yuri ok");
          break;
        }
        // Se nao tiver, ele cadastra na linha seguinte
        else {
          //novatoInativo();
          
          arquivo=SD.open("cadas.txt",FILE_WRITE);
          arquivo.println(Leite.substring(1,13));
          Serial.print("Cartao salvo com sucesso2!: ");
          Serial.println(Leite.substring(1,13));
          //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
          arquivo.close();
          break;
        }
      } //Fecha if -----------------------------------------------------------------
      //Menu();
    }//Fecha If RFID available*/
  }//Fecha While flag
}//Fecha Funcao Cadastro------------------------------------------------------

void novatoInativo(){
  flag2=true;
  Serial.println("Olá, você é novato ou foi desativado por tempo inativo!");
  Serial.println("Deseja se cadastrar? Entao digite: ");
  Serial.println("S para sim ou N para nao");
  delay(10);
  while(flag2){
    delay(10);
    if (Serial.available()){
        switch (Serial.read()) {
        case 's': nomeCadas();
        return;
        break;
        case 'S': nomeCadas();
        return;
        break;
        case 'n': Serial.println("Fale com a administração!");
        return;
        break;
        case 'N': Serial.println("Fale com a administração!");
        return;
        break;
        default: Serial.println("Funcao invalida");
      }//Fecha Switch funcaolida-------------------------------------------------
    }//Fecha While Serial--------------------------------------------------------
    Passatag();
  }//Fecha While HIGH------------------------------------------------------------
      
    
  //}  
  /*arquivo=SD.open("cadas.txt",FILE_WRITE);
          arquivo.println(Leite.substring(1,13));
          Serial.print("Cartao salvo com sucesso2!: ");
          Serial.println(Leite.substring(1,13));
          //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
          arquivo.close();
          break;*/
}
String Nome="";
void nomeCadas(){
  Serial.println("Digite seu primeiro nome + dia(DD) + mes(MM) + ano(AAAA). Exemplo: Yuri22122014");
  Serial.println("Confirme os dados digitados antes de da enter!");
  /*if(Serial.available()){
    for(int n=0;n<=49;n++){
      nome[n]= Serial.read();                         //Valolido é char
      delay(10);
      Serial.println(nome);
    }    
  }*/
  arquivo=SD.open("cadas.txt",FILE_WRITE);
          arquivo.println(Leite.substring(1,13));
          Serial.print("Cartao salvo com sucesso2!: ");
          Serial.println(Leite.substring(1,13));
          //Temos que fechar o arquivo o mais cedo possivel para liberar o ponteiro do arquivo     
          arquivo.close();
          //break;
}

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
  flag2=true; 
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
  //Fecha if HIGH-------------------------------------------------------------
  while(flag2){
    delay(10);
    while (Serial.available()){
      switch (Serial.read()) {
        case '1': Cadastro();
        flag2=false;
        return;
        break;
        case '2': ExcluirArq();
        flag2=false;
        return;
        break;
        case '3': Ativos();
        flag2=false;
        return;
        break;
        case '4': Desabilitar();
        flag2=false;
        return;
        break;
        default: Serial.println("Funcao invalida");
        return;
      }//Fecha Switch funcaolida-------------------------------------------------
    }//Fecha While Serial--------------------------------------------------------
  }//Fecha While HIGH------------------------------------------------------------
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
    //Menu();
    //Cargas();
  }//Fecha if -----------------------------------------------------------------
  else{
    Serial.println("Acesso Negado");
    Serial.println("Fale com a Administracao");
    //Menu();
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
    if (digitalRead(botao)==HIGH) {
      Menu();
    }  
     EthernetClient client = server.available();   // Verifica se tem alguém conectado
    if (client){
      boolean currentLineIsBlank = true;       // A requisição HTTP termina com uma linha em branco Indica o fim da linha
      String valPag;                           //Varialvel que vai receber a concat de c
      while (client.connected()){
        if (client.available()){              //Esperando dados
          char c = client.read();              //Variável para armazenar os caracteres que forem recebidos
          valPag.concat(c);                    // Pega os valor após o IP do navegador ex: 192.168.1.2/0001        
          //Compara o que foi recebido
          if(valPag.endsWith("interno")){      //Acesso interno da rede
            estadoip = 1;
          }
          if(valPag.endsWith("externo")){      //Acesso externo da rede
            estadoip = 2;
          }
          if(valPag.endsWith("0001")){         //Se o que for pego após o IP for igual a 0001
            Estado = !Estado;  //Inverte o estado do segundo butao "Luz Garangem"
          }
          if (c == '\n' && currentLineIsBlank){
            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: text/html");
            client.println();
            client.print("<HTML> ");
            //client.print("<center><h2 style='color: red; font-size:30px; text-align:center;'> ATEN&Ccedil&AtildeO! </h2>");
            //client.print("<center><h4> Pessoal que acender a luz, por favor apague, se perceberem que a luz est&aacute apagando &eacute pq sou eu que apago!</h4>");
            //client.println("<center> <a href='http://www.yurilima.com.br\'> <img src=http://yurilima.com.br/images/captura%20de%20tela%202014-09-30%20163404.jpg width 750 height=350></a>");
            client.println("<H1><center><style='font-size:15'>by  Yuri Lima  &  Isaac Cavalcante</H1></center>");
            client.print("<BR><BR><BR>");

            client.print("<BR>");
            //Primeiro BOTAO 
            estadoip==1?
            client.print(" <center> <button onclick=\"window.location.href='http://192.168.25.177/interno/0001'\">\0</button> > Codigo: 0001 >"):
            client.print(" <center> <button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0001'\">\0</button> > Codigo: 0001 > ");
            if(Estado){
              client.print("<B><span style=\"color: #000000;\">");  
              client.print(Carga[0]);
              delay(10);
              //digitalWrite(luzG,HIGH);
              client.print("</span></B></left>");
              client.print("<B><span style=\"color: #00ff00;\">");
              client.print(" - ON");     
              client.print("</span></B></left>");
            }         
            else{
              client.print("<B><span style=\"color: #000000;\">");
              client.print(Carga[0]);
              delay(10);
              //digitalWrite(luzG,LOW);
              client.print("</span></B></left>");
              client.print("<B><span style=\"color: #ff0000;\">");
              client.print(" - OFF");
              client.print("</span></B></left>");
            }  
            client.print("<BR>");
            if (estadoip==1){
              client.print(" <meta http-equiv=\"refresh\" content=\"4; url=http://192.168.25.177/interno \"> ");
            }
            if (estadoip==2)  {    
              client.print(" <meta http-equiv=\"refresh\" content=\"4; url=http://arduinoyuri.dyndns.org/externo \"> ");
            } 
            client.println("</HTML>");
            break;
          }//Fecha if CurrentLineIsBlank 
        }//Fecha if Seial.available
      }//Fecha While (client.connected())
      delay(3);// Espera um tempo para o navegador receber os dados
      client.stop(); // Fecha a conexão      
    }//Fecha if(client)     
  }//Fecha Inicio_ok
}//Fecha loop-------------------------------------------------------------------
