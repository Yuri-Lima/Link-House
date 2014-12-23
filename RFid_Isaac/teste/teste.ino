#include <SD.h>
#include <SPI.h>
#include <MFRC522.h>
#include <Keypad.h>

/*----------------------Configurção RFID------------------------*/
#define SS_PIN 10
#define RST_PIN 9
/*----------------------Configurção RFID------------------------*/

/*----------------------Configurção do teclado------------------------*/
const byte ROWS = 4; //four rows
const byte COLS = 4; //four columns
String opcao_escolhida="";
//define the cymbols on the buttons of the keypads
char hexaKeys[ROWS][COLS] = {
  {'*','0','#'},
  {'3','2','1'},
  {'6','5','4'},
  {'9','8','7'}
};
byte rowPins[ROWS] = {0, 8, 2, 3}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {5, 6, 7}; //connect to the column pinouts of the keypad
/*----------------------Configurção do teclado------------------------*/

/*----------------------Instancias de RFID e arquivo para SD card e objeto para teclado------------------------*/
Keypad customKeypad = Keypad(makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS); 
MFRC522 mfrc522(SS_PIN, RST_PIN);
MFRC522::MIFARE_Key key;
File arquivo;
/*----------------------Instancias de RFID e arquivo para SD card e objeto para teclado------------------------*/

void setup(){
  
  Serial.begin(9600);
  SPI.begin();                // Inicia protocolo SPI
  mfrc522.PCD_Init();        // Inicia a biblioteca para a leitura dos cartões
  while (!Serial){
    ; // Esperandoporta seria. Necessáro apenas para o Leonado
  }


  Serial.print("Iniciando o SD card...");
   pinMode(10, OUTPUT);
   
  if (!SD.begin(4)) {
    Serial.println("Inicializacao falhou!");
    return;
  }
  Serial.println("Inicializacao concluida.");
}

void loop(){
  escolherOpcao();
}

void escolherOpcao(){
  char opcao_momentanea = customKeypad.getKey();
  if(opcao_momentanea != NO_KEY){
    if(isdigit(opcao_momentanea)){
      Serial.print(opcao_momentanea);
    }
    if(opcao_momentanea == '*'){
      escolherAcao();
      opcao_escolhida = "";
    }else if(opcao_momentanea == '#'){
      opcao_escolhida = "";
    }else{
      opcao_escolhida+=opcao_momentanea;
    }
  }
}

void escolherAcao(){
  Serial.println();
  if(opcao_escolhida.equals("10")){
    cadastro();
  }
  
  if(opcao_escolhida.equals("20")){
    acesso();
  }
  
  if(opcao_escolhida.equals("30")){
    //delecao();
  }
}

void cadastro(){
  String id_cartao = "";

  Serial.println("Passe o cartao para cadastro");
  
  esperandoRFID();
  
  arquivo = SD.open("cadastro.txt", FILE_WRITE);
  
  if (arquivo){
    Serial.print("ID do no cartao");
    id_cartao = lendoRFID();
    Serial.println(id_cartao);
    Serial.println("Deseja realmente guardar esse ID?");
    Serial.println("Digite o codigo de cadastro e aperte 'ent' para confirmacao ou 'canc' para cancelar");
    
    Serial.println();
    if(confirmacao("10")){
      arquivo.println(id_cartao);
      Serial.println("Gravado com sucesso.");
    }else{
      Serial.println("Gravacao cancelada.");
    }
    arquivo.close();
  }else{
    Serial.println("Ocorreu um erro ao ler o dispositivo de cadastro");
  }
}

void acesso(){
  String id_recebido = "";
  String id_lido = "";
  boolean abertura_concedida = false;
  char caracter_temporario;
  Serial.println("Passe o cartao para ter acesso");
  
  esperandoRFID();
  id_recebido = lendoRFID();
  
  arquivo = SD.open("cadastro.txt");
  if (arquivo){
    while (arquivo.available()){
      caracter_temporario = arquivo.read();
      if(caracter_temporario=='\n'){
        Serial.print("ID lido:");
        Serial.println(id_lido.substring(0,id_lido.length()));
        Serial.println(id_lido.length());
        Serial.print("ID recebido:");
        Serial.println(id_recebido.substring(0,id_recebido.length()));
        Serial.println(id_recebido.length());
        if(id_lido.substring(0,id_lido.length()-1).equals(id_recebido.substring(0,id_lido.length()))){ //TODO decubrir por que id_lido tem tamanho 12 e id_recebido
          //abertura do portao
          abertura_concedida = true;
          Serial.println("Portao aberto");
          break;
        }
        id_lido = "";
      }else{
        id_lido+=caracter_temporario;
      }
    }
    arquivo.close();
    if(!(abertura_concedida)){
      Serial.println("Cadastro nao encontrado");
    }
  } else {
    Serial.println("Erro ao ler arquivo de cadastro");
  }
  
}

/*void delecao(){
  char opcao_momentanea;
  String id_cartao="";
  Serial.println("Aperte 1 para para digitar o código ou 2 para passar o cartao");
  opcao_momentanea = customKeypad.getKey();
  while(opcao_momentanea == NO_KEY);
  if(isdigit(opcao_momentanea)){
      Serial.print(opcao_momentanea);
    }
    if(opcao_momentanea == '1'){
      Serial.println("Apos o final de cada bloco aperte 'ent'");
      for(int iteracoes=0;iteracoes<4;iteracoes++){
        while(opcao_momentanea != '*'){
          opcao_momentanea = customKeypad.getKey();
          if(isDigit(opcao_momentanea) and (opcao_momentanea!=NO_KEY)){
            id_cartao+=opcao_momentanea;
          }
        }
        if(iteracoes<=2){
          id_cartao+=" ";
        }
      }
    }else if(opcao_momentanea == '2'){
      esperandoRFID();
      id_cartao = lendoRFID();
    }else{
      Serial.print("Opcao invalida");
    }
    Serial.println("Deseja mesmo apagar esse registro:");
    Serial.println(id_cartao);
    Serial.print("Digiteo codigo de delecao para confirmar");
    
    if(confirmacao("30")){
      //iniciar processso de deleção
    }
}*/


void esperandoRFID(){
  for (byte i = 0; i < 6; i++){
    key.keyByte[i] = 0xFF;
  }
  while( ! mfrc522.PICC_IsNewCardPresent());
  while( ! mfrc522.PICC_ReadCardSerial());
}

String lendoRFID(){
  String id_cartao;
  for (byte i = 0; i < mfrc522.uid.size; i++){
    id_cartao += mfrc522.uid.uidByte[i];
    if(i<mfrc522.uid.size-1){
      id_cartao += " ";
    }
  }
  Serial.println();
  return id_cartao;
}

boolean confirmacao(String codigo){
  char opcao_momentanea;
  String confirmacao="";
  while(opcao_momentanea != '*'){
    opcao_momentanea = customKeypad.getKey();
    if(opcao_momentanea != NO_KEY and (isdigit(opcao_momentanea))){
      Serial.print(opcao_momentanea);
      if(opcao_momentanea=='#'){
        Serial.println("Digite novamente o código de confirmação");
        confirmacao = "";
      }else if(opcao_momentanea != '*'){
        confirmacao+=opcao_momentanea;
      }
    }
  }
  
  if(confirmacao.equals(codigo)){
    return true;
  }else{
    return false;
  }
}
