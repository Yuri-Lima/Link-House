#include <ESP8266WiFi.h>

//////////////////////
// WiFi Definitions //
//////////////////////
// "GVT-Yuri Lima"
// 48291110
char *ssidpswd[] = {"Yuri", "48291129"};
WiFiServer server(8082);
String N_ssid, N_pswd;
void setupWiFi2(char*, char*);
void setupWiFi();


void setup() {
  delay(1000);
  Serial.begin(115200);
  setupWiFi();
  server.begin();
  Serial.println(WiFi.softAPIP());
}

void loop() {
  // Check if a client has connected
  WiFiClient client = server.available();
  if (!client) {
    return;
  }
  while (!client.available()) {
    delay(1);
  }
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

  /*
    // Match the request
    int8_t flag1 = 1, flag2 = 1, b = 0, c = 0, TAM = req.length();
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
    client.flush();
    static char ssid[50];//Limitação de 20 caracteres para o usuario
    static char pswd[25];//Limitação de 20 caracteres para o usuario
    memmove(&ssid, &N_ssid[0], sizeof(N_ssid) + 1);
    memmove(&pswd, &N_pswd[0], sizeof(N_pswd) + 1);
    N_ssid = N_pswd = "";
    setupWiFi2(ssid, pswd);
  */
  //client.flush();
  Serial.println(req);
  Serial.println(F("Client disonnected"));

}
void setupWiFi2(char *ssid, char *pswd) {
  Serial.println(ssid);
  Serial.println(pswd);
  //WiFi.begin(ssid, pswd);
}
void setupWiFi() {
  WiFi.mode(WIFI_AP_STA);
  WiFi.softAP(ssidpswd[0], ssidpswd[1]);
}
























