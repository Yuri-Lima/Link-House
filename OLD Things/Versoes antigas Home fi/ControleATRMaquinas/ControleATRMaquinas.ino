//Autor: Yuri Lima Empresa: Robot One
//Loja http://www.robotone.com.br/
//-------------------------------------------------
#include <SD.h>
#include <SPI.h>
#include <Wire.h>
#include <EEPROM.h>
#include <DS1307.h>
#include <Ethernet.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
//================================================
//RTC
#define DS1307_ADDRESS 0x68// Modulo RTC no endereco 0x68
#define timeERRO 20//Limita o tempo para zerar tudo!
byte lastHoras = 0;//Guarda a ultima leitura da hora
byte horaZero = 23;//Horario para a variavel contAgua ZERAR
byte zero = 0x00;//Serve para recpção de dados no CI do RTC

String setData="692015";
String Senha, DataRTC;
boolean flagSenha = false;
boolean flagEE = false; //Zera EEPRON quando TRUE
char* BancoSenha[] = {"C5A530", "68DC66", "582893", "7341DD", "7783C5", "767B09", "D77448", "848DD0", "22CC26", "83DBAD", "A01C3B", "5B6A91",
                      "54CCA1", "621995", "1D42BD", "A3CD13", "3298BA", "61D89A", "A5B5A2", "C75B1D", "0DA206", "19730A", "D427B6", "637638",
                      "918D56", "4223D4", "159600", "C17016", "86302A", "28A97D", "AA6836", "1C2864", "02C2A2", "151CC1", "38550C", "82022D"
                     };
                     
void setup() {
  Serial.begin(9600);
  for (int i = 7; i <= 10; i++)pinMode(i, INPUT_PULLUP); //Linhas
  for (int j = 3; j <= 6; j++)pinMode(j, OUTPUT); //Colunas
  if (flagEE) for (int i = 0; i < 255; i++) EEPROM.write(i, 0);//Apaga toda EEPRON de 0 a 254
}
void loop() {
  //Inicio RTC
  //==========================================================================================================
  //----------------------------------------------------------------------------------------------------------
  // Le os valores (data e hora) do modulo DS1307
  int segundos, minutos, horas, diadasemana, diadomes, mes, ano;
  WIRE(&segundos, &minutos, &horas, &diadasemana, &diadomes, &mes, &ano);
  Data.concat(diadomes);Data.concat(mes);Data.concat(ano);
  Serial.println(Data);
  //=============================================================================
  //-----------------------------------------------------------------------------
  //Leitura Teclado
  for (int Col = 6; Col >= 3; Col--) {
    for (int i = 3; i <= 6; i++)digitalWrite(i, HIGH);
    digitalWrite(Col, LOW);
    if (digitalRead(10) == LOW) {
      LinhasColunas(1, 7 - Col);
    }
    if (digitalRead(9) == LOW) {
      LinhasColunas(2, 7 - Col);
    }
    if (digitalRead(8) == LOW) {
      LinhasColunas(3, 7 - Col);
    }
    if (digitalRead(7) == LOW) {
      LinhasColunas(4, 7 - Col);
    }
    delay(10);
  }
  while (flagSenha == true) {
    for (int i = EEPROM.read(0); i <= (sizeof(BancoSenha) / 2) ; i++) {
      if (Senha.equals(BancoSenha[i])) {
        EEPROM.write(0, i);
        Acesso(1);
      }
      else if (i == (sizeof(BancoSenha) / 2)) {
        Acesso(0);
      }
    }
  }
}
void LinhasColunas(byte L, byte C) {
  //Linha 1
  if (L == 1 && C == 1) {
    Senha.concat(1); Serial.print("1");
  }
  if (L == 1 && C == 2) {
    Senha.concat(2); Serial.print("2");
  }
  if (L == 1 && C == 3) {
    Senha.concat(3); Serial.print("3");
  }
  if (L == 1 && C == 4) {
    Senha.concat("A"); Serial.print("A");
  }
  //Linha 2
  if (L == 2 && C == 1) {
    Senha.concat(4); Serial.print("4");
  }
  if (L == 2 && C == 2) {
    Senha.concat(5); Serial.print("5");
  }
  if (L == 2 && C == 3) {
    Senha.concat(6); Serial.print("6");
  }
  if (L == 2 && C == 4) {
    Senha.concat("B"); Serial.print("B");
  }
  //Linha 3
  if (L == 3 && C == 1) {
    Senha.concat(7); Serial.print("7");
  }
  if (L == 3 && C == 2) {
    Senha.concat(8); Serial.print("8");
  }
  if (L == 3 && C == 3) {
    Senha.concat(9); Serial.print("9");
  }
  if (L == 3 && C == 4) {
    Senha.concat("C"); Serial.print("C");
  }
  //Linha 4
  if (L == 4 && C == 1) {
    Senha.concat("*"); Serial.print("*");
  }
  if (L == 4 && C == 2) {
    Senha.concat(0); Serial.print("0");
  }
  if (L == 4 && C == 3) {
    flagSenha = true; Serial.print("#");
  }
  if (L == 4 && C == 4) {
    Senha.concat("D"); Serial.print("D");
  }
}
int Acesso(int acesso) {
  acesso == 1 ? acesso = 1 : acesso = 0;
  return acesso;
}


//==========================================================================================================
void SelecionaDataeHora() { //Seta a data e a hora do DS1307
  byte segundos = 00; //Valores de 0 a 59
  byte minutos = 31; //Valores de 0 a 59
  byte horas = 9; //Valores de 0 a 23
  byte diadasemana = 4; //Valores de 0 a 6 - 0=Domingo, 1 = Segunda, etc.
  byte diadomes = 3; //Valores de 1 a 31
  byte mes = 9; //Valores de 1 a 12
  byte ano = 15; //Valores de 0 a 99
  Wire.beginTransmission(DS1307_ADDRESS);
  Wire.write(zero); //Stop no CI para que o mesmo possa receber os dados
  //As linhas abaixo escrevem no CI os valores de
  //data e hora que foram colocados nas variaveis acima
  Wire.write(ConverteParaBCD(segundos));
  Wire.write(ConverteParaBCD(minutos));
  Wire.write(ConverteParaBCD(horas));
  Wire.write(ConverteParaBCD(diadasemana));
  Wire.write(ConverteParaBCD(diadomes));
  Wire.write(ConverteParaBCD(mes));
  Wire.write(ConverteParaBCD(ano));
  Wire.write(zero);
  Wire.endTransmission();
}
//==========================================================================================================
//Conversão
//==========================================================================================================
byte ConverteParaBCD(byte val) {
  //Converte o número de decimal para BCD
  return ( (val / 10 * 16) + (val % 10) );
}
//==========================================================================================================
//Conversão
//==========================================================================================================
byte ConverteparaDecimal(byte val) {
  //Converte de BCD para decimal
  return ( (val / 16 * 10) + (val % 16) );
}

void WIRE(int* segundos, int* minutos, int* horas, int* diadasemana, int* diadomes, int* mes, int* ano) {
  Wire.beginTransmission(DS1307_ADDRESS);
  Wire.write(zero);
  Wire.endTransmission();
  Wire.requestFrom(DS1307_ADDRESS, 7);
  *segundos = ConverteparaDecimal(Wire.read());
  *minutos = ConverteparaDecimal(Wire.read());
  *horas = ConverteparaDecimal(Wire.read() & 0b111111);
  *diadasemana = ConverteparaDecimal(Wire.read());
  *diadomes = ConverteparaDecimal(Wire.read());
  *mes = ConverteparaDecimal(Wire.read());
  *ano = ConverteparaDecimal(Wire.read());
}
