#include <ESP8266WiFi.h>
#include "WiFiMesh.h"
String manageRequest(String);
/* Create the mesh node object */
WiFiMesh mesh_node = WiFiMesh(ESP.getChipId(), manageRequest);

/**
   Callback for when other nodes send you data

   @request The string received from another node in the mesh
   @returns The string to send back to the other node
*/
String manageRequest(String request)
{
  /* Print out received message */
  Serial.print("received: ");
  Serial.println(request);

  /* return a string to send back */
  return String("TESTE_2.");
}

void setup()
{
  Serial.begin(115200);
  delay(10);

  Serial.println();
  Serial.println();
  Serial.println("Configurando no mesh..._2");

  /* Initialise the mesh node */
  mesh_node.begin();
}

void loop()
{
  /* Accept any incoming connections */
  mesh_node.acceptRequest();

  /* Scan for other nodes and send them a message */
  mesh_node.attemptScan("TESTE_2.");
  delay(1000);
}
