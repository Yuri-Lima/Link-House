/*
Automação Residencial
Project: Link House
Author: Yuri Lima & Reginaldo Barros
Date: 27/10/2015 - 22:50
*/
//OBS Modulo com duas GPIOS protocolo diferenciado Pinagem diferente
//"$1#1#######"
#include <ESP8266WiFi.h>
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
#define W_CHARGE pc_Request.charAt(i)//Qual Carga?
#define ON_C  digitalWrite(i==1?i-1:i,HIGH);//Ligar Carga
#define OFF_C digitalWrite(i==1?i-1:i,LOW);//Desligar Carga
#define N_ACTION Serial.print("#");//Sem ação
#define F_COMU '\r'//Fim de Comunicação
//Acesso Wifi
const char* ssid = "GVT-Yuri Lima";//Usuario da internet
const char* password = "48291110";//Senha do Wifi
//=======================================================
//Objeto da classe
WiFiServer server(8080);//Porta de Comunicação
//=======================================================
//Variaveis

void setup() {
#if DEBUG
  Serial.begin(115200);
#endif
  pinMode(0, OUTPUT);
  pinMode(2, OUTPUT);
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
  if (T_ACTION == '$') {
#if DEBUG
    Serial.println(F("Acionamento de Carga."));
#endif
    for (int i = 1; i <= pc_Request.length(); i++) {
      if (W_CHARGE == '1')ON_C
        else if (W_CHARGE == '0')OFF_C
          //else if (W_CHARGE == '#')N_ACTION
          }
  }
  if (T_ACTION == '*') {
#if DEBUG
    Serial.println(F("Retorno de Status."));
#endif
    pc_Request = pc_Request + digitalRead(0);
    pc_Request = pc_Request + digitalRead(2);
    pc_Request = pc_Request + "#######";
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
  delay(1);
#if DEBUG
  Serial.println(F("Client disonnected"));
  Serial.println("");
#endif
}/*
String Status(String pc_Request) {

  pc_Request = pc_Request + char(digitalRead(QT_gpio[0]));
  /*pc_Request.setCharAt(2, digitalRead(QT_gpio[1]));
  pc_Request.setCharAt(3, '#');
  pc_Request.setCharAt(4, '#');
  pc_Request.setCharAt(5, '#');
  pc_Request.setCharAt(6, '#');
  pc_Request.setCharAt(7, '#');
  pc_Request.setCharAt(8, '#');
  pc_Request.setCharAt(9, '#');
  return pc_Request  ;
}*/
