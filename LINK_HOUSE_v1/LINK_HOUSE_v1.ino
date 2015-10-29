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
#define Q_GPIO 2
const int QT_gpio[Q_GPIO] = {0, 2}; //Defina aqui os pinos da GPIO do menor para o maior
//=======================================================
//DEBUG
#define DEBUG 0
//=======================================================
//Protocolo de Comunicação
#define T_ACTION pc_Request.charAt(0)
#define L_CARGA  pc_Request.charAt(i)
#define LIGAR_C    digitalWrite(i-1,1);
#define DESLIGAR_C digitalWrite(i-1,0);
#define F_COMU '\r'
//Acesso Wifi
const char* ssid = "GVT-Yuri Lima";
const char* password = "48291110";
//=======================================================
//Objeto da classe
WiFiServer server(8080);
//=======================================================
//Variaveis

void setup() {
#if DEBUG
  Serial.begin(115200);
#endif
  pinMode(QT_gpio[0], 1);
  pinMode(QT_gpio[2], 1);
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
      if (L_CARGA == '1')LIGAR_C
        else if (L_CARGA == '0')DESLIGAR_C
          else if (L_CARGA == '#')continue;
    }
  }
  if (T_ACTION == '*') {
#if DEBUG
    Serial.println(F("Retorno de Status."));
#endif
    client.println(Status(pc_Request));
  }
  if (T_ACTION == '&') {
#if DEBUG
    Serial.println(F("Teste de Comunicacao."));
#endif
    client.println(T_comu(pc_Request.charAt(0)));
  }
  // Return the response
  client.println(F("HTTP/1.1 200 OK"));
  client.println(F("Content-Type: text/plain"));
  client.println(""); //  do not forget this one
  client.println(F("Ok"));
  delay(1);
#if DEBUG
  Serial.println(F("Client disonnected"));
  Serial.println("");
#endif
}
String Status(String pc_Request) {
  pc_Request.setCharAt(1, digitalRead(QT_gpio[0]));
  pc_Request.setCharAt(2, digitalRead(QT_gpio[1]));
  pc_Request.setCharAt(3, '#');
  pc_Request.setCharAt(4, '#');
  pc_Request.setCharAt(5, '#');
  pc_Request.setCharAt(6, '#');
  pc_Request.setCharAt(7, '#');
  pc_Request.setCharAt(8, '#');
  pc_Request.setCharAt(9, '#');
  return pc_Request;
}
char T_comu(char pc_Request) {
  return pc_Request;

}
