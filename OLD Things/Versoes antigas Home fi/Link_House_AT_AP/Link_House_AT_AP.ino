/*
  Automação Residencial
  Project: Homefi_AX
  Author: Yuri Lima & Reginaldo Barros
  Date: 27/10/2015 - 22:50
  "GVT-Yuri Lima"
  48291110
*/

#ifdef ESP8266
extern "C" {
#include "user_interface.h"
}
#endif

//OBS Modulo com duas GPIOS protocolo diferenciado Pinagem diferente
//=======================================================
//Bibliotecas
//#include <avr / io.h>
#include <String.h>//Funções com parametros variaveis
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <EEPROM.h>
#include "DHT.h"
//=======================================================
//DEBUG
#define DEBUG 1
#define TEMP //O modulo ta sendo usado para: TEMP=Temperatura ou KEY=Interruptor
//=======================================================
//Protocolo de Comunicação
#define T_ACTION req.charAt(0) //Tipo de Ação
int8_t status = WL_IDLE_STATUS;
String ssid_Novo = "";
String pswd_Novo = "";
//=======================================================
//Objeto da classe
WiFiServer server(8082);//Porta de Comunicação
//=======================================================
#define CARGA1     4
#define CARGA2     5
#define CARGA3     12
#define CARGA4     13
#define INT        14
#define CARGA6     16
#define TEMPERATURA 10000
#define INTERRUPTOR 500
//=======================================================
//Temperatura
DHT dht(CARGA6, DHT11);
int8_t h, t;
//=======================================================
//Estrutura de dados
struct VAR {
  //Millis
  uint64_t previousMillis;
  const uint64_t interval;
  uint64_t currentMillis;
  //Interrupções(ISR)
  volatile uint8_t flag: 1;//disponivel apenas 1 bit de 1 byte
    volatile int8_t MANUAL;
  };
  struct VAR M = {0, INTERRUPTOR, 0, 0, INT}; //inicializando
VAR M2 = {0, TEMPERATURA, 0};//inicializando
//=======================================================
//Prototipo das funções
#if DEBUG
void printWifiStatus();
#endif
void ManualChange();
char ssid[25] = "GVT-Yuri Lima";
char pswd[25] = "4829111029";
char *s = ssid, *p = pswd;; //Apontando para meu vetor ssid
//=======================================================
//Protocolo
String MAC;
//==================================================================================

void setup() {
  //char *p;
  //p = (char*) calloc(4, sizeof(char));
  pinMode(M.MANUAL, INPUT);
  pinMode(CARGA3, OUTPUT);
  attachInterrupt(digitalPinToInterrupt (M.MANUAL), ManualChange, CHANGE);
#if DEBUG
  Serial.begin(115200);
#endif
  EEPROM.begin(60);
  /*
    EEPROM.write(0, p[0]);
    EEPROM.write(1, p[1]);
    EEPROM.write(2, p[2]);
    Serial.println(char(EEPROM.read(0)));
    Serial.println(char(EEPROM.read(1)));
    Serial.println(char(EEPROM.read(2)));
  */
  /*bool T = false;
    int8_t EE = EEPROM.read(2);
    if (EE != ssid[0]) {
    for (int8_t i = 2; i < EEPROM.read(0); i++) {
      if (EEPROM.read(i) != 255) ssid_Novo[i] = EEPROM.read(i);
      T = true;
    }
    }
    if (T) {
    for (int8_t j = EEPROM.read(0); j <= EEPROM.read(0) + EEPROM.read(1); j++) {
      if (EEPROM.read(j) != 255) pswd_Novo[j] = EEPROM.read(j);
    }
    }*/
  /*
    int8_t Tam_Ssid = sizeof(ssid);
    for (int8_t i = 2; i < Tam_Ssid; i++) {
    EEPROM.write(i, ssid[i]);
    }
    int8_t Tam_Pswd = sizeof(pswd);
    for (int8_t j = Tam_Ssid; j <= Tam_Ssid + Tam_Pswd; j++) {
    EEPROM.write(j, pswd[j]);
    }*/
  //Serial.println("");
  //Serial.print("ssid_Novo: ");
  //Serial.println(ssid);
  //Serial.print("ssid_Novo: ");
  //Serial.println(pswd);
  WiFi.begin(ssid, pswd);
  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
    Serial.print(F("."));
  }
  //===========================================================================================================
  Serial.println("");
  // Start the server
  server.begin(); //Server iniciado
  // Print the IP address
  MAC = WiFi.macAddress();
#if DEBUG
  WiFi.printDiag(Serial);
  Serial.print(F("IP_MOD_ESP: "));
  Serial.println(WiFi.localIP());
  Serial.print(F("IP AP: "));
  Serial.println(WiFi.softAPIP());
  Serial.print(F("MAC_MOD_ESP: "));
  Serial.println(MAC);
  Serial.print(F("Nome do modulo - hostname: "));
  Serial.println(wifi_station_get_hostname());
  system_get_sdk_version();
  printWifiStatus();
#endif
  dht.begin();
}

void loop() {

  //==============================================================
  //Precisa ter um intervalo minimo de 1,5segundos para uma boa leitura
  //if(M2.previousMillis==sizeof
  M2.currentMillis = millis();
  if (M2.currentMillis < M2.previousMillis)M2.previousMillis = 0;
  if ( M2.currentMillis - M2.previousMillis >= M2.interval) {
    // save the last time you read the sensor
    M2.previousMillis = M2.currentMillis;
    h = dht.readHumidity();
    t = dht.readTemperature();
  }
  //===========================================================================================================
  M.currentMillis = millis();
  if (M.currentMillis < M.previousMillis)M.previousMillis = 0;
  if ( M.currentMillis - M.previousMillis >= M.interval) {
    // save the last time you read the sensor
    M.previousMillis = M.currentMillis;
    if (!M.flag)   {
      digitalWrite(CARGA3, !digitalRead(CARGA3));
      M.flag = 1;
    }
  }
  // Check if a client has connected
  //===========================================================================================================
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  // Wait until the client sends some data
#if DEBUG
  Serial.println(F("Nova Requisicao"));
#endif
  //===========================================================================================================
  while (!client.available()) {
    delay(1);
  }
  //===========================================================================================================
  // Read os dados de protocolo enviado
  String req = client.readStringUntil('\r');
#if DEBUG
  Serial.print(F("Protocolo: "));
  Serial.println(req);
#endif
  client.flush();//Limpa buffer
  client.println(F("HTTP/1.1 200 OK"));
    client.println(F("Content-Type: text/html"));
    client.println();
    client.println(F("<HTML>"));
    client.println(F("<head>"));
    client.println(F("<title> Link House </title>"));//Titulo da aba
    client.println(F("</head>"));
    client.println(F("<body>"));
    client.println(F("<h2>Configurar Rede Wifi</h2>"));
    client.println(F("<form method='get'>"));
    client.println(F("Nome da rede: <input type='text' name='ssid'>"));
    client.println(F("<br>"));
    client.println(F("Senha da rede: <input type='password' name='pswd'>"));
    client.println(F("<br>"));
    client.println(F("<input type='submit' value='Salvar'>"));
    client.println(F("</form>"));
    client.println(F("</body>"));
    client.println(F("</HTML>"));
    delay(1);
  //===========================================================================================================
  if (T_ACTION == 0x24) {
#if DEBUG
    Serial.println(F("Acionamento de Carga."));
#endif
    if (req.charAt(1) == 0x31)digitalWrite(CARGA3, !digitalRead(CARGA3));
  }
  //===========================================================================================================
  if (T_ACTION == 0x2A) {
#if DEBUG
    Serial.println(F("Retorno de Status."));
    Serial.println(req);
#endif
    req = "";
    //==========================================================================================================================================================================================================
#ifdef TEMP
    req = req + '{' + "'" + "id" + "'" + ":" + "'" + MAC  + "'" + ',' + "'" + "status" + "'" + ":" + "'" + t + h + "'" + ',' + "'" + "sinal" + "'" + ":" + WiFi.RSSI() + '}' ;
#else if KEY
    req = req + '{' + "'" + "id" + "'" + ":" + "'" + MAC  + "'" + ',' + "'" + "status" + "'" + ":" + "'" + digitalRead(CARGA3) + "#####" + "'" + ',' + "'" + "sinal" + "'" + ":"  + WiFi.RSSI() + '}' ;
#endif
    //==========================================================================================================================================================================================================
#if DEBUG
    Serial.println(req);
#endif
    client.println(req);
  }
  //===========================================================================================================
  if (T_ACTION == 0x26) {
#if DEBUG
    Serial.println(F("Mudanca de SSID e PSWD"));
#endif
    //Tratamento de Request
    int flag1 = 1, flag2 = 1, TAM = req.length();
    for (int i = 0; i < TAM; i++) {
      if (req.charAt(i) == 0x3D) {//'='
        for (int j = i + 1; j < TAM; j++) {
          if (req.charAt(j) != 0x26 && flag1 == 1) {//'&'
            if (req.charAt(j) != 0x2B) {//'+'
              ssid_Novo = ssid_Novo + char(req.charAt(j));
            }
            else {
              ssid_Novo = ssid_Novo + char(0x20);
            }
          }
          else if (flag2 == 1) {
            flag1 = 0;
            if (req.charAt(j) == 0x3D) {
              for (int m = j + 1; m < TAM; m++) {
                if (req.charAt(m) != 0x20) {
                  pswd_Novo = pswd_Novo + char(req.charAt(m));
                }
                else {
                  i = j = m = TAM;
                }
              }
            }
          }
        }
      }
    }
    int8_t Tam_Ssid = ssid_Novo.length();
    EEPROM.write(0, Tam_Ssid);
    for (int8_t i = 2; i < Tam_Ssid; i++) {
      EEPROM.write(i, ssid_Novo[i]);
    }
    int8_t Tam_Pswd = pswd_Novo.length();
    EEPROM.write(1, Tam_Pswd);
    for (int8_t j = Tam_Ssid; j <= Tam_Ssid + Tam_Pswd; j++) {
      EEPROM.write(j, pswd_Novo[j]);
    }
  }
  //===========================================================================================================
#if DEBUG
  Serial.println(F("Client disonnected"));
  Serial.println("");
#endif
}
/*void AcessoWifi(int *ssid, int pos) {
  Serial.print(ssid[2]);
  //ssid[25] = "GVT-Yuri Lima";//Usuario da internet
  //pswd[25] = "48291110";//Senha do Wifi

  }*/
#if DEBUG
void printWifiStatus() {
  // print the SSID of the network you're attached to:
  Serial.print(F("Nome da rede - SSID: "));
  Serial.println(WiFi.SSID());

  // print your WiFi shield's IP address:
  IPAddress ip = WiFi.localIP();
  Serial.print(F("Endereco de IP: "));
  Serial.println(ip);

  // print the received signal strength:
  long rssi = WiFi.RSSI();
  Serial.print(F("Intensidade do Sinal (RSSI):"));
  Serial.print(rssi);
  Serial.println(F(" dBm"));
}
#endif
void ManualChange() {
  M.flag = 0;
}


