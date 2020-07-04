/*
Automação Residencial
Project: Link House
Author: Yuri Lima & Reginaldo Barros
Date: 27/10/2015 - 22:50
*/
//OBS Modulo com duas GPIOS protocolo diferenciado Pinagem diferente
//"$1#1#######"
#include <ESP8266WiFi.h>

#include "DHT.h"
#define DHTPIN 12
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
unsigned long previousMillis = 0;        // will store last temp was read
const long interval = 5000;              // interval at which to read sensor
//=======================================================
//Quantidade de GPIO do Modulo
#define Q_GPIO 2 //Defina aqui quantos pinos tem o modulo
const int QT_gpio[Q_GPIO] = {0, 2}; //Defina aqui os pinos da GPIO do menor para o maior
//=======================================================
//DEBUG
#define DEBUG 1
//=======================================================
//Protocolo de Comunicação
#define T_ACTION pc_Request.charAt(0) //Tipo de Ação?
#define F_COMU '\r'//Fim de Comunicação
//Acesso Wifi
const char* ssid = "GVT-Yuri Lima";//Usuario da internet
const char* password = "48291110";//Senha do Wifi
//=======================================================
//Objeto da classe
WiFiServer server(8082);//Porta de Comunicação
//=======================================================
//Variaveis

void setup() {
#if DEBUG
  Serial.begin(115200);
#endif
  pinMode(16, INPUT_PULLUP);
  dht.begin();
  // Connect to WiFi network
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
#if DEBUG
    Serial.print(F("."));
#endif
  }
#if DEBUG
  Serial.println("");
#endif
  // Start the server
  server.begin(); //Server iniciado
  // Print the IP address
#if DEBUG
  Serial.print(F("IP_MOD_ESP: "));
  Serial.println(WiFi.localIP());
#endif
}

void loop() {
  // Check if a client has connected
  WiFiClient client = server.available();
  Serial.println(client);
  if (!client) {
    return;
  }
  // Wait until the client sends some data
#if DEBUG
  Serial.println(F("New Request"));
#endif
  while (!client.available()) {
    delay(1);
  }
  // Read os dados de protocolo enviado
  String pc_Request = client.readStringUntil(F_COMU);
#if DEBUG
  Serial.print(F("Protocolo: "));
  Serial.println(pc_Request);
#endif
  client.flush();//Limpa buffer

  if (T_ACTION == '*') {
#if DEBUG
    Serial.println(F("Retorno de Status."));
#endif
    pc_Request = '@';
    pc_Request = pc_Request + int(dht.readHumidity());
    pc_Request = pc_Request + int(dht.readTemperature());
#if DEBUG
    Serial.println(pc_Request);
#endif
    client.println(pc_Request);
  }
  if (T_ACTION == '&') {
#if DEBUG
    Serial.println(F("Teste de Comunicacao."));
    client.println('&');
#endif
  }
#if DEBUG
  Serial.println(F("Client disonnected"));
  Serial.println("");
#endif
}
