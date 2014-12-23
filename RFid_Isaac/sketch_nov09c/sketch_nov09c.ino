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
String opcaoEscolhida = "";
String idRcebidoCadastro = "";
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
  arquivo = SD.open("cadastro.txt", FILE_WRITE);
  arquivo.close();
}

void loop(){
  escolherOpcao();
}

void escolherOpcao(){
  char opcaoMomentanea = customKeypad.getKey();
  if(opcaoMomentanea != NO_KEY){
    if(isdigit(opcaoMomentanea)){
      Serial.print(opcaoMomentanea);
    }
    if(opcaoMomentanea == '*'){
      escolherAcao();
      opcaoEscolhida = "";
    }else if(opcaoMomentanea == '#'){
      opcaoEscolhida = "";
    }else{
      opcaoEscolhida+=opcaoMomentanea;
    }
  }
}

void escolherAcao(){
  Serial.println();
  if(opcaoEscolhida.equals("10")){
    Serial.println("Passe o cartao para cadastro");
    if(existeUsuario(true)){
      Serial.println("Usuario ja cadastrado");
    }else{
      cadastro();
    }
  }
  
  if(opcaoEscolhida.equals("20")){
    Serial.println("Passe o cartao para ter acesso");
    if(existeUsuario(false)){
      Serial.println("Portao aberto");
    }else{
      Serial.println("Cadastro nao encontrado");
    }
  }
  
  if(opcaoEscolhida.equals("30")){
    delecao();
  }
}

void cadastro(){
  char opcaoMomentanea = ' ';
  String confirmacao = "";
  
  arquivo = SD.open("cadastro.txt", FILE_WRITE);
  
  if (arquivo){
    Serial.print("ID do cartao ");
    Serial.println(idRcebidoCadastro);
    Serial.println("Deseja realmente guardar esse ID?");
    Serial.println("Digite o codigo de cadastro e aperte 'ent' para confirmacao ou 'canc' para cancelar");
    
    while(opcaoMomentanea != '*'){
      opcaoMomentanea = customKeypad.getKey();
      if(opcaoMomentanea != NO_KEY){
        if(isdigit(opcaoMomentanea)){
          Serial.print(opcaoMomentanea);
        }
        if(opcaoMomentanea=='#'){
          confirmacao = "";
        }else if(opcaoMomentanea != '*'){
          confirmacao+=opcaoMomentanea;
        }
      }
    }
    
    Serial.println();
    if(confirmacao.equals("10")){
      arquivo.print(idRcebidoCadastro); //Decidi gravar sem println, pois quando é necessário ler os dados gravados na hora do acesso acontecia incompatibilidades no tamanho das strings que comportavam o valor do cartão lido e da linha no arquivo que guardava os usuários (tamanhos diferentes)
      arquivo.print(" ");//sendo assim esse último espaço é necessário para identificar um registro de outro na hora do acesso
      Serial.println("Gravado com sucesso.");
    }else{
      Serial.println("Gravacao cancelada.");
    }
    arquivo.close();
  }else{
    Serial.println("Ocorreu um erro ao ler o dispositivo de cadastro");
  }
}

boolean existeUsuario(boolean confirmacaoCadastro){
  String idRecebido = "";
  String idLido = "";
  char caracterTemporario;
  short contadorEspacos=0;
  
  esperandoRFID();
  idRecebido = lendoRFID();
  if(confirmacaoCadastro){
    idRcebidoCadastro = idRecebido;
  }
  
  arquivo = SD.open("cadastro.txt");
  if (arquivo){
    while (arquivo.available()){
      caracterTemporario = arquivo.read();
      if(caracterTemporario==' '){
        contadorEspacos++;
      }
      if(contadorEspacos==4){
        Serial.print("ID lido:");
        Serial.println(idLido.substring(0,idLido.length()));
        Serial.println(idLido.length());
        Serial.print("ID recebido:");
        Serial.println(idRecebido.substring(0,idRecebido.length()));
        Serial.println(idRecebido.length());
        if(idLido.substring(0,idLido.length()).equals(idRecebido.substring(0,idLido.length()))){
          arquivo.close();
          return true;
        }
        idLido = "";
        contadorEspacos=0;
      }else{
        idLido+=caracterTemporario;
      }
    }
  }else{
    Serial.println("Erro ao ler arquivo de cadastro");
  }
  arquivo.close();
  return false;
  
}

void delecao(){
  Serial.println("Passe o cartão que será deletado");
  
}

void esperandoRFID(){
  for (byte i = 0; i < 6; i++){
    key.keyByte[i] = 0xFF;
  }
  while( ! mfrc522.PICC_IsNewCardPresent());
  while( ! mfrc522.PICC_ReadCardSerial());
}

String lendoRFID(){
  String idCartao = "";
  int contador=0;
  for (byte i = 0; i < mfrc522.uid.size; i++){
    idCartao += mfrc522.uid.uidByte[i];
    if(i<mfrc522.uid.size-1){
      idCartao += " ";
    }
  }
  Serial.println();
  return idCartao;
}
