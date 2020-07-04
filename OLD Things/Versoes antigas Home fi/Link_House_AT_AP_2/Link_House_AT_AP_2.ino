/*
  Automação Residencial
  Project: Homefi_AX
  Author: Yuri Lima & Reginaldo Barros
  Date: 27/10/2015 - 22:50
  "GVT-Yuri Lima"
  48291110
*/

#ifdef ESP8266// Pedir uma variavel existente dentro da lib.
extern "C" {
#include "user_interface.h"
}
#endif

//=======================================================
//Bibliotecas
#include <ESP8266WiFi.h>
//#include <WiFiClient.h>
//#include <ESP8266WebServer.h>
//#include <ESP8266mDNS.h>
//#include <EEPROM.h>
#include "DHT.h"
char ssid[15] = ""; //Limitação de 15 caracteres para o usuario(obs)aprimorar para alocação dinamica
char pswd[15] = ""; //Limitação de 15 caracteres para o usuario(obs)aprimorar para alocação dinamica
String N_ssid, N_pswd;// Recepção de dados para compor acesso wifi do roteador
char *ssidpswd[] = {"Lima", "48291110"};// Nome e senha da refe wifi do modulo
//=======================================================
//DEBUG
#define DEBUG 1// Acionar debug(Serial.begin)
#define TEMP // O modulo ta sendo usado para: TEMP=Temperatura ou KEY=Interruptor

//=======================================================
//Protocolo de Comunicação
#define T_ACTION req.charAt(0) // Tipo de Ação no protocolo

//=======================================================
//Objeto da classe
WiFiServer server(8082);//Porta de Comunicação default

//=======================================================
#define CARGA1     4// uso geral
#define CARGA2     5// uso geral
#define CARGA3     12// Pino de acionamento de carga
#define CARGA4     13// uso geral
#define INT        14//Pino da chave
#define CARGA6     16// Pino da temperatura
#define TEMPERATURA 10000// A cada 10 segundos é aferido nova temperatura
#define INTERRUPTOR 500// Gap de 500ms p/ detecção de acionamento da chave 
#define REQ_TEMP req = req + '{' + "'" + "id" + "'" + ":" + "'" + WiFi.macAddress()  + "'" + ',' + "'" + "status" + "'" + ":" + "'" + t + h + "'" + ',' + "'" + "sinal" + "'" + ":" + WiFi.RSSI() + '}' ;
#define REQ_KEY req = req + '{' + "'" + "id" + "'" + ":" + "'" + WiFi.macAddress()  + "'" + ',' + "'" + "status" + "'" + ":" + "'" + digitalRead(CARGA3) + "#####" + "'" + ',' + "'" + "sinal" + "'" + ":"  + WiFi.RSSI() + '}' ;
//=======================================================
//Temperatura
DHT dht(CARGA6, DHT11);
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
  }  M = {0, INTERRUPTOR, 0, 0, INT}, M2 = {0, TEMPERATURA, 0};// inicialização de algumas

//=======================================================
//Prototipo das funções
void ManualChange();
void setupWiFi2(char*, char*);
void setupWiFi();
void req_Tratamento(String);

//==================================================================================

void setup() {
  delay(100);//Apenas
  pinMode(M.MANUAL, INPUT);
  pinMode(CARGA3, OUTPUT);
  attachInterrupt(digitalPinToInterrupt (M.MANUAL), ManualChange, CHANGE);
#if DEBUG
  Serial.begin(115200);
#endif
  setupWiFi();
  server.begin();
  dht.begin();
  Serial.println(WiFi.softAPIP());
}

void loop() {

  //==============================================================
  //Precisa ter um intervalo minimo de 2segundos para uma boa leitura
  static int8_t h, t;
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
  if ( wifi_station_get_connect_status() != 5) { // se conexão via ip externo está ok
    //===========================================================================================================
    // Prepare the response. Start with the common header:
    client.println(F("HTTP/1.1 200 OK"));
    client.println(F("Content-Type: text/html"));
    client.println();
    client.println(F("<HTML>"));
    client.println(F("<head>"));
    client.println(F("<title> Link House </title>"));//Titulo da aba
    client.println(F("</head>"));
    client.println(F("<body>"));
    client.println(F("<h2>Configurar Rede Wifi</h2>"));
    client.println(F("<h3>Rede e senha Wifi com no maximo 15 caracteres</h3>"));
    client.println(F("<h3>Senha Wifi sem usar caracteres especias</h3>"));
    client.println(F("<form method='get'>"));
    client.println(F("Nome da rede: <input type='text' name='ssid'>"));
    client.println(F("   "));
    client.println(F("Senha da rede: <input type='password' name='pswd'>"));
    client.println(F("<br>"));
    client.println(F("<input type='submit' value='Salvar'>"));
    client.println(F("<br>"));
    client.println(F("</form>"));
    client.println(F("</body>"));
    client.println(F("</HTML>"));
    delay(1);
    req_Tratamento(req);
    if (N_ssid.length() != 0 && N_pswd.length() != 0) setupWiFi2(ssid, pswd);
    N_ssid = N_pswd = "";
  }




#if DEBUG
  Serial.println(F("Client disonnected"));
  Serial.println("");
#endif
}
//Fim Loop
//=====================================================================
void req_Tratamento(String req) {
  // Match the request
  int flag1 = 1, flag2 = 1, b = 0, c = 0, TAM = req.length();
  for (int i = 0; i < TAM; i++) {
    if (req.charAt(i) == 0x3D) {//'='
      for (int j = i + 1; j < TAM; j++) {
        if (req.charAt(j) != 0x26 && flag1 == 1) {//'&'
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

void setupWiFi2(char *ssid, char *pswd) {
  static uint8_t count = 0;
  Serial.println(ssid);
  Serial.println(pswd);
  WiFi.begin(ssid, pswd);
  do {
    if (count == 100) break;
    delay(50);
    Serial.print(F("."));
    count++;
  }
  while (WiFi.status() != WL_CONNECTED);
  count = 0;
  // Print the IP address

#if DEBUG
  WiFi.printDiag(Serial);
  Serial.print(F("IP_MOD_ESP: "));
  Serial.println(WiFi.localIP());
  Serial.print(F("IP AP: "));
  Serial.println(WiFi.softAPIP());
  Serial.print(F("MAC_MOD_ESP: "));
  Serial.println(WiFi.macAddress());
  Serial.print(F("Nome do modulo - hostname: "));
  Serial.println(wifi_station_get_hostname());
  Serial.print(F("Intensidade do Sinal (RSSI):"));
  Serial.print(WiFi.RSSI());
  Serial.println(F(" dBm"));
#endif
}
//=====================================================================
void setupWiFi() {
  WiFi.mode(WIFI_AP_STA);
  WiFi.softAP(ssidpswd[0], ssidpswd[1]);
}
//=====================================================================
void ManualChange() {
  M.flag = 0;
}

