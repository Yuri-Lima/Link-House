#include <ESP8266WiFi.h>
#include "ESP8266WiFiMesh.h"

String manageRequest(String request);

unsigned int request_i = 0;
unsigned int response_i = 0;

/* Create the mesh node object */
ESP8266WiFiMesh mesh_node = ESP8266WiFiMesh(ESP.getChipId(), manageRequest);

/**
   Callback for when other nodes send you data

   @request The string received from another node in the mesh
   @returns The string to send back to the other node
*/
String manageRequest(String request)
{
  /* Print out received message */
  Serial.print("Recebido: ");
  Serial.println(request);

  /* return a string to send back */
  char response[60];
  sprintf(response, "Resposta numero: #%d do no_mesh %d .", response_i++, ESP.getChipId());//Recebi uma requisição de outr no na rede!
  return response;
}

void setup()
{
  Serial.begin(115200);
  delay(10);

  Serial.println();
  Serial.println();
  Serial.println("Configurando Rede Mesh...");

  /* Initialise the mesh node */
  mesh_node.begin();
}

void loop()
{
  /* Accept any incoming connections */
  mesh_node.acceptRequest();

  /* Scan for other nodes and send them a message */
  char request[60];
  sprintf(request, "Requisicao numero #%d do no_mesh %d .", request_i++, ESP.getChipId());//Envia uma requisição para outro no na rede!
  mesh_node.attemptScan(request);
  delay(100);
}
