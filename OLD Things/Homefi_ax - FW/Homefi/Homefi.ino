/*
  Automação Residencial
  Project: Homefi_AX
  Author: Yuri Lima & Reginaldo Barros
  Date: 27/10/2015 - 22:50
  Date: 30/04/2016
  "GVT-Yuri Lima"
  48291110
*/

#ifdef ESP8266// Pedir uma variavel existente dentro da lib.
extern "C" {
#include "user_interface.h"
}
#endif

//==================================================================================================
//Bibliotecas
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
//#include <ESP8266WebServer.h>
//#include <ESP8266mDNS.h>
//#include <EEPROM.h>
#include "DHT.h"
//=======================================================
#define CARGA1     0x04// uso geral
#define CARGA2     0x05// uso geral
#define CARGA3     0xC// Pino 12 de acionamento de carga
#define CARGA4     0xD// uso geral 13
#define INT        0xE//Pino da chave 14
#define CARGA6     0x10// Pino da temperatura 16
#define TEMPERATURA 10000// A cada 10 segundos é aferido nova temperatura
#define INTERRUPTOR 250// Gap de 500ms p/ detecção de acionamento da chave 
#define REQ_TEMP req = req + '{' + "'" + "id" + "'" + ":" + "'" + WiFi.macAddress()  + "'" + ',' + "'" + "status" + "'" + ":" + "'" + t + h + "'" + ',' + "'" + "sinal" + "'" + ":" + WiFi.RSSI() + '}' ;
#define REQ_KEY req = req + '{' + "'" + "id" + "'" + ":" + "'" + WiFi.macAddress()  + "'" + ',' + "'" + "status" + "'" + ":" + "'" + digitalRead(CARGA3) + "#####" + "'" + ',' + "'" + "sinal" + "'" + ":"  + WiFi.RSSI() + '}' ;
#define WIFI_ON 150
//=======================================================
//DEBUG
#define DEBUG 0x01// Acionar debug(Serial.begin)
#define KEY // O modulo ta sendo usado para: TEMP=Temperatura ou KEY=Interruptor
//=======================================================
//Protocolo de Comunicação
#define T_ACTION req.charAt(0x00) // Tipo de Ação no protocolo
//===================================================================================================
char ssid[15] = ""; //Limitação de 15 caracteres para o usuario(obs)aprimorar para alocação dinamica
char pswd[15] = ""; //Limitação de 15 caracteres para o usuario(obs)aprimorar para alocação dinamica
String N_ssid, N_pswd;//Recepção de dados para compor acesso wifi do roteador
char *ssidpswd[] = {"AX-2", "48291110"};//Nome e senha da refe wifi do modulo
//=======================================================
//Estrutura de dados
struct VAR {
  //Millis
  uint64_t previousMillis;
  const uint64_t interval;
  uint64_t currentMillis;
  //Interrupções(ISR)
  volatile uint8_t flag: 1;//disponibilidade de apenas 1 bit de 1 byte
    volatile int8_t MANUAL;
  }  M = {0, INTERRUPTOR, 0, 0, INT}, M2 = {0, TEMPERATURA, 0}, M3 = {0, 1000, 0};// inicialização de algumas
//=======================================================
//Objeto da classe
WiFiServer server(80);
//=======================================================
//Temperatura
DHT dht(CARGA6, DHT11);//ok
//=======================================================
//Prototipo das funções
void ManualChange();
void connecT(char*, char*);
void setupWiFi();
void req_Tratamento(String);
String Connect_AP();
//==================================================================================

void setup() {
#if DEBUG
  Serial.begin(115200);
#endif
  pinMode(M.MANUAL, INPUT);
  pinMode(CARGA3, OUTPUT);
  analogWrite(CARGA3, 0);
  attachInterrupt(digitalPinToInterrupt (M.MANUAL), ManualChange, CHANGE);
  dht.begin();//ok
  setupWiFi();
  server.begin();
  WiFi.begin();
  //================================================================
  //Verifica se os dados da rede wifi é o mesmo e tenta conectar se não entra em modo AP
  static uint8_t count = 0; //
  do {
    if (count == 200) break;
    delay(100);
    Serial.print(F("."));
    count++;
  }
  while (WiFi.status() != WL_CONNECTED);
  if (WiFi.status() == WL_CONNECTED) {
    for (uint8_t i = 0; i <= 5; i++) {
      digitalWrite(CARGA3, !digitalRead(CARGA3));
      delay(WIFI_ON);
    }
  }

#if DEBUG
  WiFi.printDiag(Serial);
  Serial.print(F("IP_MOD_ESP: "));
  Serial.println(WiFi.localIP());
  Serial.print(F("MAC_MOD_ESP: "));
  Serial.println(WiFi.macAddress());
  Serial.print(F("IP AP: "));
  Serial.println(WiFi.softAPIP());
  Serial.print(F("MAC_MOD_ESP_AP: "));
  Serial.println(WiFi.softAPmacAddress());
  Serial.print(F("Nome do modulo - hostname: "));
  Serial.println(wifi_station_get_hostname());
  Serial.print(F("Intensidade do Sinal (RSSI):"));
  Serial.print(WiFi.RSSI());
  Serial.println(F(" dBm"));
  Serial.print(F("Modulo:"));
  Serial.print(ssidpswd[0]);
#endif
  M2.flag = 0;
}

void loop() {
  static int x = 0;
  //==============================================================
  //Precisa ter um intervalo minimo de 2segundos para uma boa leitura
  static int8_t h, t;
  /*M2.currentMillis = millis();
    if (M2.currentMillis < M2.previousMillis)M2.previousMillis = 0x00;
    if ( M2.currentMillis - M2.previousMillis >= M2.interval) {
    // save the last time you read the sensor
    M2.previousMillis = M2.currentMillis;
    //h = dht.readHumidity();
    //t = dht.readTemperature();
    //Serial.print("Temperatura: ");
    //Serial.println(t);
    }*/

  //===========================================================================================================
  M.currentMillis = millis();
  if (M.currentMillis < M.previousMillis)M.previousMillis = 0;
  if ( M.currentMillis - M.previousMillis >= M.interval) {
    // save the last time you read the sensor
    M.previousMillis = M.currentMillis;
    if (M.flag) {
      int i, b;
      analogWriteRange (1023);
      analogWriteFreq (200);
      analogWrite(CARGA3, 255);
      Serial.println("Entrou");
      /*digitalWrite(CARGA3, !digitalRead(CARGA3));
        Send_Crypto_Manual(digitalRead(CARGA3)); */
      M.flag = 0;
    }
  }
  Serial.println("Saiu");
  analogWrite(CARGA3, 600);
  delay(10);

  // Verifica se algum dado esta conectado
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
  // Read os dados de protocolo enviado
  String  req = client.readStringUntil('\r');
#if DEBUG
  Serial.print(F("Protocolo: "));
  Serial.println(req);
#endif
  client.flush();//Limpa buffer
  //===========================================================================================================
  if (wifi_station_get_connect_status() != 5){
    client.print(Connect_AP());
    req_Tratamento(req);
    if (N_ssid.length() != 0 && N_pswd.length() != 0) connecT(ssid, pswd);
    N_ssid = N_pswd = "";
  }

  //===========================================================================================================
  if (T_ACTION == 0x24) {// $
#if DEBUG
    Serial.println(F("Acionamento de Carga."));
#endif
    if (req.charAt(1) == 0x31)digitalWrite(CARGA3, !digitalRead(CARGA3));
  }

  //===========================================================================================================
  if (T_ACTION == 0x2A) {// *
#if DEBUG
    Serial.println(F("Retorno de Status."));
    Serial.println(req);
#endif
    req = "";
    //==========================================================================================================================================================================================================
#ifdef TEMP
    REQ_TEMP
#else if KEY
    REQ_KEY
#endif
    //==========================================================================================================================================================================================================
#if DEBUG
    Serial.println(req);
#endif
    client.println(req);
  }

  //===========================================================================================================
}
//Fim Loop
//=====================================================================
void req_Tratamento(String req) {
  // Match the request
  uint8_t flag1 = 1, flag2 = 1, b = 0, c = 0, TAM = req.length();
  for (int i = 0; i < TAM; i++) {
    if (req.charAt(i) == 0x3D) { //'='
      for (int j = i + 1; j < TAM; j++) {
        if (req.charAt(j) != 0x26 && flag1 == 1) { //'&'
          if (req.charAt(j) != 0x2B) {//'+'
            N_ssid += char(req.charAt(j));
          }
          else {
            N_ssid += char(0x20) ;//Space
          }
        }
        else if (flag2 == 1) {
          //N_ssid += '\0';
          flag1 = 0;
          if (req.charAt(j) == 0x3D) {//'='
            for (int m = j + 1; m < TAM; m++) {
              if (req.charAt(m) != 0x20) {
                N_pswd += char(req.charAt(m));
              }
              else {
                //N_pswd += '\0';
                i = j = m = TAM;
              }
            }
          }
        }
      }
    }
  }
  memmove(&ssid, &N_ssid[0], sizeof(N_ssid) + 1);
  memmove(&pswd, &N_pswd[0], sizeof(N_pswd) + 1);
  //Se realmente o usuario digitou node de rede e senha ela chama pra conectar ou reconectar
}

void connecT(char *ssid, char *pswd) {
  WiFi.disconnect();
  delay(5);
  //Serial.println("WiFi2");
  uint8_t count = 0;
  Serial.println(ssid);
  Serial.println(pswd);
  WiFi.begin(ssid, pswd);
  do {
    if (count == 150) break;
    delay(100);
    Serial.print(F("."));
    count++;
  }
  while (WiFi.status() != WL_CONNECTED);//Enquanto nao estiver conectado ele tenta 150 vezes.
  count = 0;
  if (WiFi.status() == WL_CONNECTED) {
    for (uint8_t i = 0; i <= 3; i++) {
      digitalWrite(CARGA3, !digitalRead(CARGA3));
      delay(WIFI_ON);
    }
  }
}
//=====================================================================
void setupWiFi() {
  Serial.println("WiFi");
  WiFi.mode(WIFI_AP_STA);
  IPAddress Ip(192, 168, 25, 62);//alocado no roteador
  IPAddress NMask(255, 255, 255, 0);
  WiFi.softAPConfig(Ip, Ip, NMask);
  WiFi.softAP(ssidpswd[0]);
}
//=====================================================================
void ManualChange() {
  M.flag = 0x01;
}
String Connect_AP() {
  // Prepare the response. Start with the common header:
  String S = "HTTP/1.1 200 OK\r\n";
  S += "Content-Type: text/html\r\n\r\n";
  S += "<!DOCTYPE HTML>\r\n<html>\r\n";
  S += "<h2>Configurar Rede Wifi</h2>";
  S += "<h3>Rede e senha Wifi com no maximo 15 caracteres</h3>\r\n";
  S += "<h3>Senha Wifi sem usar caracteres especias</h3>\r\n";
  S += "<form method='get'>";
  S += "Nome da rede: <input type='text' name='ssid'>";
  S += "Senha da rede: <input type='password' name='pswd'>";
  S += "<br>";
  S += "<input type='submit' value='Salvar'>";
  S += "</form>\n";
  S += "</html>\n";
  return S;
  //client.print(S);
  delay(1);
#if DEBUG
  Serial.println(F("Client disonnected"));
#endif
}

/*void reconnecT() {
  static uint8_t count = 0;
  WiFi.disconnect();
  delay(5);
  WiFi.begin(ssid, pswd);
  do {
    if (count == 150) break;
    delay(100);
    Serial.print(F("."));
    count++;
  }
  while (WiFi.status() != WL_CONNECTED);
  count = 0;
  }*/

