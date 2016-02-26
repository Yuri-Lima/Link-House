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
#ifdef arduino
extern "C" {
#include "avr/io.h"
}
#endif
//OBS Modulo com duas GPIOS protocolo diferenciado Pinagem diferente
//"$1#1#######"
//=======================================================
//Bibliotecas
//#include <avr / io.h>
//#include <util/delay.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <DHT11.h>
//=======================================================
//DEBUG
#define DEBUG 1
//=======================================================
//Protocolo de Comunicação
#define T_ACTION pc_Request.charAt(0) //Tipo de Ação?
#define N_ACTION Serial.print("#");//Sem ação
//Acesso Wifi
//Usuario da internet Station
const char* ssid = "GVT-Yuri Lima";//Usuario da internet
const char* pswd = "48291110";//Senha do Wifi
//Usuario da internet Acess Point
//const char PSWD[] = "48291110";
//=======================================================
////Acesso wifi modulo ESP
//#define MY_SSID   "LinkHouse"
//#define MY_PASSWD "78945612"
//=======================================================
//Objeto da classe
WiFiServer server(8082);//Porta de Comunicação
//=======================================================
//Variaveis
#define CARGA 12
#define DHTPIN 16
//#define MANUAL 14
DHT11 dht11(DHTPIN);
unsigned long previousMillis = 0;
const long interval = 500;
unsigned long previousMillis2 = 0;
const long interval2 = 5000;//Temperatura
int status = WL_IDLE_STATUS;
int h, t;
volatile bool flag1, flag2;
volatile int MANUAL = 14;
String MAC; 
//=======================================================
//Prototipo das funções
#if DEBUG
void printWifiStatus();
#endif
void ManualChange();
//==================================================================================
void setup() {
  //DDRB=0b00000000;
  pinMode(MANUAL, INPUT);
  pinMode(CARGA, OUTPUT);
  attachInterrupt(digitalPinToInterrupt (MANUAL), ManualChange, CHANGE);
#if DEBUG
  Serial.begin(115200);
#endif
  //delay(10);
  //WiFi.mode(WIFI_AP_STA); //AP,STA,AP_STA,OFF Colocar em modo AP e Station
  // WiFi.softAP("LinkHouse", "78945612"); //na lib do Arduino eh diferente; WiFi.begin(S,P)
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
#if DEBUG
  WiFi.printDiag(Serial);
  //Serial.print(F("IP_MOD_ESP: "));
  //Serial.println(WiFi.localIP());
  Serial.print(F("IP AP: "));
  Serial.println(WiFi.softAPIP());
  Serial.print(F("MAC_MOD_ESP: "));
  MAC = WiFi.macAddress();
  Serial.println(MAC);
  Serial.print(F("Nome do modulo - hostname: "));
  Serial.println(wifi_station_get_hostname());
  printWifiStatus();
#endif
}

void loop() {
  //===========================================================================================================
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    // save the last time you read the sensor
    previousMillis = currentMillis;
    if (!flag1)   {
      digitalWrite(CARGA, !digitalRead(CARGA));
      flag1 = true;
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
  String pc_Request = client.readStringUntil('\r');
#if DEBUG
  Serial.print(F("Protocolo: "));
  Serial.println(pc_Request);
#endif
  client.flush();//Limpa buffer
  /*client.println(F("HTTP/1.1 200 OK"));
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
    delay(1);*/
  //===========================================================================================================
  if (T_ACTION == '$') {
#if DEBUG
    Serial.println(F("Acionamento de Carga."));
#endif
    if (pc_Request.charAt(2) == '1')digitalWrite(CARGA, !digitalRead(CARGA));
    else if (pc_Request.charAt(2) == '0') digitalWrite(CARGA, !digitalRead(CARGA));
  }
  //===========================================================================================================
  if (T_ACTION == '*') {

#if DEBUG
    Serial.println(F("Retorno de Status."));
#endif
    pc_Request = pc_Request + digitalRead(CARGA);
    pc_Request = pc_Request + "########";
    pc_Request = pc_Request + MAC;
    //pc_Request = '@';
    //pc_Request = pc_Request + t;
    //pc_Request = pc_Request + h;
#if DEBUG
    Serial.println(pc_Request);
#endif
    client.println(pc_Request);
  }
  //===========================================================================================================
  if (T_ACTION == '&') {
#if DEBUG
    Serial.println(F("Teste de Comunicacao."));
#endif
    client.println('&');
  }
  //===========================================================================================================
#if DEBUG
  Serial.println(F("Client disonnected"));
  Serial.println("");
#endif

}
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
  flag1 = false;
}

