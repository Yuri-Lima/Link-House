#include <Ethernet.h>
// the sensor communicates using SPI, so include the library:
#include <SPI.h>
#include <LiquidCrystal.h>
#define Amarelo 7 //Define LED_Amarelo como 5
#define Vermelho 8 //Define LED_Vermelho como 6


LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
float Sensor=A0;

// Atribuir um endereço MAC para o controlador de ethernet .
// Preencher o seu endereço aqui:

byte mac[] = { 
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
// assign an IP address for the controller:
IPAddress ip(192,168,25,177); 
IPAddress gateway(192,168,25,1);   	
IPAddress subnet(255, 255, 255, 0);
EthernetServer server(80);//Inicializa a biblioteca EthernetServer com os valore


byte COD = B11000;
String A0_carga = "Temperatura"; //Função do primeiro botão
String A1_carga = "Luz da Garagem"; //Função do primeiro botão
String A2_carga = "Luz do Jardim"; //Função do segundo botão
String A3_carga = "Luz da Sala"; //Função do primeiro botão
String A4_carga = "Luz da Cozinha"; //Função do segundo botão
String A5_carga = "Luz do Quarto 01"; //Função do segundo botão
String A6_carga = "Luz do Quarto 02"; //Função do segundo botão
String A7_carga = "Porta da Rua"; //Função do segundo botão
String A8_carga = "Porta da Garagem"; //Função do segundo botão
String A9_carga = "Senso de Presenca"; //Função do segundo botão
String A10_carga = "Sensor de Gases"; //Função do segundo botão
boolean A0_estado=true; //Variável para armazenar o estado do primeiro botão
boolean A1_estado=false; //Variável para armazenar o estado do primeiro botão
boolean A2_estado=false; //Variável para armazenar o estado do segundo botão
boolean A3_estado=false; //Variável para armazenar o estado do terceiro botão
boolean A4_estado=false; //Variável para armazenar o estado do segundo botão
boolean A5_estado=false; //Variável para armazenar o estado do terceiro botão
boolean A6_estado=false; //Variável para armazenar o estado do primeiro botão
boolean A7_estado=false; //Variável para armazenar o estado do segundo botão
boolean A8_estado=false; //Variável para armazenar o estado do terceiro botão
boolean A9_estado=false; //Variável para armazenar o estado do segundo botão
boolean A10_estado=false; //Variável para armazenar o estado do terceiro botão
int luzG = 31; //Função do primeiro botão
int luzJ= 32; //Função do segundo botão
int luzS = 33; //Função do primeiro botão
int luzC = 34; //Função do segundo botão
int luzQ1 = 35; //Função do segundo botão
int luzQ2 = 36; //Função do segundo botão
int portaR = 37; //Função do segundo botão
int portaG = 38; //Função do segundo botão
int sensorP = 39; //Função do segundo botão
int sensorG = 40; //Função do segundo botão
int temp; //Função do segundo botão
       
//long anteriorMillis = 0; //Variável para auxiliar no timer do BLINK do LED Amarelo      
//long intervalo = 1000; //Variável para armazenar a frequência do BLINK do LED Amarelo   
//int brilhoFade = 0;    // Variável para armazenar o valor do brilho do FADE do LED Vermelho
//int degrauFade = 5;    // Variável para armazenar o valor do degrau do FADE do LED Vermelho
int estadoip=0;



void setup()
{
  pinMode(Amarelo,OUTPUT); //Define o pino 5 como saída
  pinMode(Vermelho,OUTPUT); //Define o pino 6 como saída
  pinMode(Sensor,INPUT); //Define o pino 6 como saída
  pinMode(luzG,OUTPUT); //Função do primeiro botão
  pinMode(luzJ,OUTPUT); //Função do primeiro botão
  pinMode(luzS,OUTPUT); //Função do primeiro botão
  pinMode(luzC,OUTPUT); //Função do primeiro botão
  pinMode(luzQ1,OUTPUT); //Função do primeiro botão
  pinMode(luzQ2,OUTPUT); //Função do primeiro botão
  pinMode(portaR,OUTPUT); //Função do primeiro botão
  pinMode(portaG,OUTPUT); //Função do primeiro botão
  pinMode(sensorP,OUTPUT); //Função do primeiro botão
  pinMode(sensorG,OUTPUT); //Função do primeiro botão
  
  Ethernet.begin(mac, ip);// Inicializa o Server com o IP e Mac atribuido acima
  Serial.begin(9600);
  lcd.begin(16, 2);
}

void loop()
{
 // controle(); //Vai para a função que executa o acionamento dos botões
 
  
  EthernetClient client = server.available();// Verifica se tem alguém conectado
  if (client)
  {
    boolean currentLineIsBlank = true; // A requisição HTTP termina com uma linha em branco Indica o fim da linha
    String valPag;
    while (client.connected())
    {
      if (client.available())
      {
        char c = client.read(); //Variável para armazenar os caracteres que forem recebidos
        valPag.concat(c); // Pega os valor após o IP do navegador ex: 192.168.1.2/0001        
        //Compara o que foi recebido
        
        if(valPag.endsWith("interno")){
          estadoip = 1;
        }
        if(valPag.endsWith("externo")){
          estadoip = 2;
        }    
        if(valPag.endsWith("phone")){
          estadoip = 3;
        } 
       
        
         if(valPag.endsWith("1110")) //Se o que for pego após o IP for igual a 1110
        {
          COD = COD ^ B1110; //Executa a lógica XOR entre a variável atual de COD e o valor B1110
          A0_estado = !A0_estado;  //Inverte o estado do terceiro acionamento  
        }
        
        if(valPag.endsWith("0001")) //Se o que for pego após o IP for igual a 0001
        {
          COD = COD ^ B0001; //Executa a lógica XOR entre a variável atual de COD e o valor B0010
          A1_estado = !A1_estado;  //Inverte o estado do terceiro acionamento  
        }
        
        else if(valPag.endsWith("0010")) //Senão se o que for pego após o IP for igual a 0010
        {
          COD = COD ^ B0010; //Executa a lógica XOR entre a variável atual de COD e o valor B0010
          A2_estado = !A2_estado;  //Inverte o estado do terceiro acionamento  
        }
        
        else if(valPag.endsWith("0100")) //Senão se o que for pego após o IP for igual a 0100
        {
          COD = COD ^ B0100; //Executa a lógica XOR entre a variável atual de COD e o valor B0100
          A3_estado = !A3_estado;  //Inverte o estado do terceiro acionamento      
        }
        
        else if(valPag.endsWith("0110")) //Senão se o que for pego após o IP for igual a 0110
        {
          COD = COD ^ B0110; //Executa a lógica XOR entre a variável atual de COD e o valor B0110
          A4_estado = !A4_estado;  //Inverte o estado do terceiro acionamento      
        }
        
        else if(valPag.endsWith("0111")) //Senão se o que for pego após o IP for igual a 0111
        {
          COD = COD ^ B0111; //Executa a lógica XOR entre a variável atual de COD e o valor B0111
          A5_estado = !A5_estado;  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("0101")) //Senão se o que for pego após o IP for igual a 0101
        {
          COD = COD ^ B0101; //Executa a lógica XOR entre a variável atual de COD e o valor B0101
          A6_estado = !A6_estado;  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("0011")) //Senão se o que for pego após o IP for igual a 0011
        {
          COD = COD ^ B0011; //Executa a lógica XOR entre a variável atual de COD e o valor B0011
          A7_estado = !A7_estado;  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("0000")) //Senão se o que for pego após o IP for igual a 0000
        {
          COD = COD ^ B0000; //Executa a lógica XOR entre a variável atual de COD e o valor B0000
          A8_estado = !A8_estado;  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("1001")) //Senão se o que for pego após o IP for igual a 1001
        {
          COD = COD ^ B1001; //Executa a lógica XOR entre a variável atual de COD e o valor B1001
          A9_estado = !A9_estado;  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("1011")) //Senão se o que for pego após o IP for igual a 1011
        {
          COD = COD ^ B1011; //Executa a lógica XOR entre a variável atual de COD e o valor B1011
          A10_estado = !A10_estado;  //Inverte o estado do terceiro acionamento      
        }
        //=========================================================================================================================
        if (c == '\n' && currentLineIsBlank)
        { 
          //Inicia página HTML
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println();
          client.print("<HTML> ");
          client.print("<center> <font size=7> <font color=\"#FF0000\">ATEN&Ccedil&AtildeO! </font></font>");
          client.print("<center> Pessoal que acender a luz, por favor apague, se perceberem que a luz est&aacute apagando &eacute pq sou eu que apago!");
          client.println("<BR><center></B></I></U><a href=\"http://www.yurilima.com.br\"> <img src=http://yurilima.com.br/images/captura%20de%20tela%202014-09-30%20163404.jpg width 750 height=350></a></B></I></U></center>");
         //client.println("<BR><center></B></I></U> Yuri Lima - LinkHouse");
          //=========================================================================================================================
          //http://yurilima.com.br/images/logolink.jpg
          //http://yurilima.com.br/images/captura%20de%20tela%202014-09-30%20163404.jpg
          
          //Aviso de porta aberta ou fechada
          /* int porta = analogRead(Sensor);
           // Serial.println(porta);
            if(porta<800){
              client.print("<BR>");
              client.println("<BR><center></B></I></U><a href=\"http://www.yurilima.com.br\"> <img src=http://yurilima.com.br/images/porta-aberta.jpg ></a></B></I></U></center>");
              client.print("<center>Porta da Casa Aberta:  <font size=7>  <font color=\"#ff6600\">  ");
            }else{
              client.print("<BR>");
              client.println("<BR><left></B></I></U><a href=\"http://www.yurilima.com.br\"> <img src=http://yurilima.com.br/images/porta-fechada.jpg></a></B></I></U></center>");
              client.print("<center>Porta da Casa Fechada:  <font size=7>  <font color=\"#ff6600\">  ");
            }
          */
          //=========================================================================================================================
          //Temperatura
          client.print("<BR><BR><BR>");
          estadoip==1? //Operador Ternario
          client.print(" <center> <button onclick=\"window.location.href='http://192.168.25.177/interno/1110'\">\0</button> > Codigo: 1110 > ") :       
          client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/1110'\">\0</button> > Codigo: 1110 > ");
          
                    
         if(A0_estado)
         {      
            int temp = (5.0 * analogRead(Sensor) * 100.0) / 1024;
            client.print("<B><span style=\"color: #000000;\">"); 
            client.print(" A ");
            client.print(A0_carga);
            client.print(" atual &eacute: "); 
            client.print("<font size=4>");
            client.println(temp);
            client.print("<B><span style=\"color: #FF0000;\">"); 
            client.print("*C </font></font></center>"); 
            client.print("</span></B></center>");
            client.print("</span></B></center>");
              
          }         
          else
          {
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" Ver ");
            client.print(A0_carga);
            client.print(" atual. ");
            client.print("</span></B></center>");
           
            
          }          
                   
          // =========================================================================================================================
          client.print("<BR>");
                   
          //Primeiro BOTAO Luz Garangem
          estadoip==1?
          client.print(" <center> <button onclick=\"window.location.href='http://192.168.25.177/interno/0001'\">\0</button> > Codigo: 0001 > "):
          client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0001'\">\0</button> > Codigo: 0001 > ");
                    
          if(A1_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A1_carga);
            delay(10);
            digitalWrite(luzG,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A1_carga);
            delay(10);
            digitalWrite(luzG,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
          //Segundo BOTAO Luz Jardim
          client.print("<BR>");
          estadoip==1?
          client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0010'\">\0</button> > Codigo: 0010 > "):
          client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0010'\">\0</button> > Codigo: 0010 > ");
         
          if(A2_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A2_carga);
            delay(10);
            digitalWrite(luzJ,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A2_carga);
            delay(10);
            digitalWrite(luzJ,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
 //Terceiro BOTAO
           client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0100'\">\0</button> > Codigo: 0100 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0100'\">\0</button> > Codigo: 0100 > ");
                    
          if(A3_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A3_carga);
            delay(10);
            digitalWrite(luzS,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A3_carga);
            delay(10);
            digitalWrite(luzS,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
 //Quarto BOTAO
          client.print("<BR>");
          estadoip==1?
          client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0110'\">\0</button> > Codigo: 0110 > "):
          client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0110'\">\0</button> > Codigo: 0110 > ");
                    
          if(A4_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A4_carga);
            delay(10);
            digitalWrite(luzC,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A4_carga);
            delay(10);
            digitalWrite(luzC,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
       //=========================================================================================================================
 //Quinto BOTAO
           client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0111'\">\0</button> > Codigo: 0111 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0111'\">\0</button> > Codigo: 0111 > ");
          
          if(A5_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A5_carga);
            delay(10);
            digitalWrite(luzQ1,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A5_carga);
            delay(10);
            digitalWrite(luzQ1,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================   
       //Sexto BOTAO
       client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0101'\">\0</button> > Codigo: 0101 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0101'\">\0</button> > Codigo: 0101 > ");
          
           if(A6_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A6_carga);
            delay(10);
            digitalWrite(luzQ2,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A6_carga);
            delay(10);
            digitalWrite(luzQ2,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
          //=========================================================================================================================
          
          //Setimo BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0011'\">\0</button> > Codigo: 0011 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0011'\">\0</button> > Codigo: 0011 > ");
          
          if(A7_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A7_carga);
            delay(10);
            digitalWrite(portaR,A7_estado);
            delay(500);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
            A7_estado=false;
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A7_carga);
            delay(10);
            digitalWrite(portaR,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
          
          //Oitavo BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/0000'\">\0</button> > Codigo: 0000 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0000'\">\0</button> > Codigo: 0000 > ");
          
          if(A8_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A8_carga);
            delay(10);
            digitalWrite(portaG,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A8_carga);
            delay(10);
            digitalWrite(portaG,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
          //=========================================================================================================================
          
          //Nono BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/1001'\">\0</button> > Codigo: 1001 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/1001'\">\0</button> > Codigo: 1001 > ");
          
          if(A9_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A9_carga);
            delay(10);
            digitalWrite(sensorP,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A9_carga);
            delay(10);
            digitalWrite(sensorP,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
          
          //Decimo BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center><button onclick=\"window.location.href='http://192.168.25.177/interno/1011'\">\0</button> > Codigo: 1011 > "):
           client.print("<center><button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/01011'\">\0</button> > Codigo: 1011 > ");
          
          if(A10_estado)
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(A10_carga);
            delay(10);
            digitalWrite(sensorG,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(A10_carga);
            delay(10);
            digitalWrite(sensorG,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
          //=========================================================================================================================
         
          client.print("<BR>");
          
          estadoip==1?
            client.print(" <meta http-equiv=\"refresh\" content=\"4; url=http://192.168.25.177/interno \"> "):       
            client.print(" <meta http-equiv=\"refresh\" content=\"6; url=http://arduinoyuri.dyndns.org/externo \"> ");
          
          
          client.println("</HTML>");
          break;
        } //Fecha if (c == '\n' && currentLineIsBlank)
        
      } //Fecha if (client.available())
      
    } //Fecha While (client.connected())
    
    delay(3);// Espera um tempo para o navegador receber os dados
    client.stop(); // Fecha a conexão
    
  } //Fecha if(client)
  
} //Fecha loop

/*void controle()
{ //Abre função acionamento()
  //LED Amarelo - BLINK
  //Baseado no sketch BlinkWithoutDelay, disponível em File > Examples > Digital > BlinkWithouDelay
  if(A1_estado)
  {
    
    analogWrite(Amarelo, brilhoFade); //Altera o valor de PWM no pino 6
    brilhoFade = brilhoFade + degrauFade; //Soma na variável brilhoFade o valor do degrau
    if (brilhoFade == 0 || brilhoFade == 255) degrauFade = -degrauFade ; //Se o brilho Fade chega no máximo ou no mínimo...
                                                                         //Inverte o sentido de intensidade do Fade    
    delay(15); //Aguarda 15 milissegundos   
    
  }
  else digitalWrite(Amarelo,LOW);
  //=========================================================================================================================
  //LED Vermelho - FADE
  if(A2_estado)
  {
    
    analogWrite(Vermelho, brilhoFade); //Altera o valor de PWM no pino 6
    brilhoFade = brilhoFade + degrauFade; //Soma na variável brilhoFade o valor do degrau
    if (brilhoFade == 0 || brilhoFade == 255) degrauFade = -degrauFade ; //Se o brilho Fade chega no máximo ou no mínimo...
                                                                         //Inverte o sentido de intensidade do Fade    
    delay(15); //Aguarda 15 milissegundos   
    
  }
  else digitalWrite(Vermelho,LOW);
  //=========================================================================================================================
  //Lampada (ON/OFF)
  if(A3_estado){ 
   digitalWrite(Amarelo,HIGH);
   digitalWrite(Vermelho,HIGH);
  }else {
    digitalWrite(Amarelo,LOW);
    digitalWrite(Vermelho,LOW);
  //=========================================================================================================================  
  }
}*/
