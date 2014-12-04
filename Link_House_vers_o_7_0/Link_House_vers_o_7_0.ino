#include <Ethernet.h>
#include <SPI.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

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

char* Carga[] = {"Luz da Garagem","Luz do Jardim","Luz da Sala","Luz da Cozinha","Luz do Quarto 01","Luz do Quarto 02",
"Porta da Rua","Porta da Garagem","Senso de Presenca","Sensor de Gases"}; 

boolean arrayEstado[9];
boolean A0_estado=true;

int estadoip=0x00;
int PINOUT[]= {31,32,33,34,35,36,37,38};     
float sensorP = 39,sensorG = 40,Sensor=A0,temp;

void setup()
{
	for(int C=0; C<=9;C++){
	Carga[9];
}  

	for(int estado=0; estado<=9;estado++){
	arrayEstado[estado]=false;
}

  for (int p=31; p<=38;p++){
    pinMode(PINOUT[p],OUTPUT);
}
 

  pinMode(Sensor,INPUT); //Define o pino 6 como saída
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
               
        
         if(valPag.endsWith("1110")) //Se o que for pego após o IP for igual a 1110
        {
          COD = COD ^ B1110; //Executa a lógica XOR entre a variável atual de COD e o valor B1110
          A0_estado = !A0_estado;  //Inverte o estado do terceiro acionamento  
        }
        
        if(valPag.endsWith("0001")) //Se o que for pego após o IP for igual a 0001
        {
          COD = COD ^ B0001; //Executa a lógica XOR entre a variável atual de COD e o valor B0010
          arrayEstado[0] = !arrayEstado[0];  //Inverte o estado do terceiro acionamento  
        }
        
        else if(valPag.endsWith("0010")) //Senão se o que for pego após o IP for igual a 0010
        {
          COD = COD ^ B0010; //Executa a lógica XOR entre a variável atual de COD e o valor B0010
          arrayEstado[1] = !arrayEstado[1];  //Inverte o estado do terceiro acionamento  
        }
        
        else if(valPag.endsWith("0100")) //Senão se o que for pego após o IP for igual a 0100
        {
          COD = COD ^ B0100; //Executa a lógica XOR entre a variável atual de COD e o valor B0100
          arrayEstado[2] = !arrayEstado[2];  //Inverte o estado do terceiro acionamento      
        }
        
        else if(valPag.endsWith("0110")) //Senão se o que for pego após o IP for igual a 0110
        {
          COD = COD ^ B0110; //Executa a lógica XOR entre a variável atual de COD e o valor B0110
          arrayEstado[3] = !arrayEstado[3];  //Inverte o estado do terceiro acionamento      
        }
        
        else if(valPag.endsWith("0111")) //Senão se o que for pego após o IP for igual a 0111
        {
          COD = COD ^ B0111; //Executa a lógica XOR entre a variável atual de COD e o valor B0111
          arrayEstado[4] = !arrayEstado[4];  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("0101")) //Senão se o que for pego após o IP for igual a 0101
        {
          COD = COD ^ B0101; //Executa a lógica XOR entre a variável atual de COD e o valor B0101
          arrayEstado[5] = !arrayEstado[5];  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("0011")) //Senão se o que for pego após o IP for igual a 0011
        {
          COD = COD ^ B0011; //Executa a lógica XOR entre a variável atual de COD e o valor B0011
          arrayEstado[6] = !arrayEstado[6];  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("0000")) //Senão se o que for pego após o IP for igual a 0000
        {
          COD = COD ^ B0000; //Executa a lógica XOR entre a variável atual de COD e o valor B0000
          arrayEstado[7] = !arrayEstado[7];  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("1001")) //Senão se o que for pego após o IP for igual a 1001
        {
          COD = COD ^ B1001; //Executa a lógica XOR entre a variável atual de COD e o valor B1001
          arrayEstado[8] = !arrayEstado[8];  //Inverte o estado do terceiro acionamento      
        }
        else if(valPag.endsWith("1011")) //Senão se o que for pego após o IP for igual a 1011
        {
          COD = COD ^ B1011; //Executa a lógica XOR entre a variável atual de COD e o valor B1011
          arrayEstado[9] = !arrayEstado[9];  //Inverte o estado do terceiro acionamento      
        }
        //=========================================================================================================================
        if (c == '\n' && currentLineIsBlank)
        { 
          //Inicia página HTML
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println();
          client.print("<HTML> ");
          client.print("<center><h2 style='color: red; font-size:30px; text-align:center;'> ATEN&Ccedil&AtildeO! </h2>");
          client.print("<center><h4> Pessoal que acender a luz, por favor apague, se perceberem que a luz est&aacute apagando &eacute pq sou eu que apago!</h4>");
          client.println("<center> <a href='http://www.yurilima.com.br\'> <img src=http://yurilima.com.br/images/captura%20de%20tela%202014-09-30%20163404.jpg width 750 height=350></a>");
          client.println("<p style='font-size:15'>by  Yuri Lima  &  Isaac Cavalcante");
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
          client.print(" <center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/1110' \">\0</button> > Codigo: 1110 > ") 
          :       
          
          client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/1110'\">\0</button> > Codigo: 1110 > ");
          
                    
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
          client.print(" <center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0001'\">\0</button> > Codigo: 0001 > "):
          client.print(" <center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0001'\">\0</button> > Codigo: 0001 > ");
                    
          if(arrayEstado[0])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[0]);
            delay(10);
            //digitalWrite(luzG,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[0]);
            delay(10);
            //digitalWrite(luzG,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
          //Segundo BOTAO Luz Jardim
          client.print("<BR>");
          estadoip==1?
          client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0010'\">\0</button> > Codigo: 0010 > "):
          client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0010'\">\0</button> > Codigo: 0010 > ");
         
          if(arrayEstado[1])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[1]);
            delay(10);
            //digitalWrite(luzJ,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[1]);
            delay(10);
            //digitalWrite(luzJ,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
 //Terceiro BOTAO
           client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0100'\">\0</button> > Codigo: 0100 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0100'\">\0</button> > Codigo: 0100 > ");
                    
          if(arrayEstado[2])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[2]);
            delay(10);
            //digitalWrite(luzS,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[2]);
            delay(10);
            //digitalWrite(luzS,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
 //Quarto BOTAO
          client.print("<BR>");
          estadoip==1?
          client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0110'\">\0</button> > Codigo: 0110 > "):
          client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0110'\">\0</button> > Codigo: 0110 > ");
                    
          if(arrayEstado[3])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[3]);
            delay(10);
            //digitalWrite(luzC,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[3]);
            delay(10);
            //digitalWrite(luzC,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
       //=========================================================================================================================
 //Quinto BOTAO
           client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0111'\">\0</button> > Codigo: 0111 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0111'\">\0</button> > Codigo: 0111 > ");
          
          if(arrayEstado[4])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[4]);
            delay(10);
            //digitalWrite(luzQ1,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[4]);
            delay(10);
            //digitalWrite(luzQ1,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================   
       //Sexto BOTAO
       client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0101'\">\0</button> > Codigo: 0101 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0101'\">\0</button> > Codigo: 0101 > ");
          
           if(arrayEstado[5])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[5]);
            delay(10);
            //digitalWrite(luzQ2,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[5]);
            delay(10);
            //digitalWrite(luzQ2,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
          //=========================================================================================================================
          
          //Setimo BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0011'\">\0</button> > Codigo: 0011 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0011'\">\0</button> > Codigo: 0011 > ");
          
          if(arrayEstado[6])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[6]);
            delay(10);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
            
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[6]);
            delay(10);
            //digitalWrite(portaR,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
          
          //Oitavo BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/0000'\">\0</button> > Codigo: 0000 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/0000'\">\0</button> > Codigo: 0000 > ");
          
          if(arrayEstado[7])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[7]);
            delay(10);
            //digitalWrite(portaG,HIGH);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[7]);
            delay(10);
            //digitalWrite(portaG,LOW);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
          //=========================================================================================================================
          
          //Nono BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/1001'\">\0</button> > Codigo: 1001 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/1001'\">\0</button> > Codigo: 1001 > ");
          
          if(arrayEstado[8])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[8]);
            delay(10);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></left>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[8]);
            delay(10);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></left>");
          }
          //=========================================================================================================================
          
          //Decimo BOTAO
          client.print("<BR>");
           estadoip==1?
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://192.168.25.177/interno/1011'\">\0</button> > Codigo: 1011 > "):
           client.print("<center> <style='font-size:20px; 'button onclick=\"window.location.href='http://arduinoyuri.dyndns.org/externo/01011'\">\0</button> > Codigo: 1011 > ");
          
          if(arrayEstado[9])
          {           
            client.print("<B><span style=\"color: #000000;\">");  
            client.print(Carga[9]);
            delay(10);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #00ff00;\">");
            client.print(" - ON");     
            client.print("</span></B></center>");
          }         
          else
          {
            client.print("<B><span style=\"color: #000000;\">");
            client.print(Carga[9]);
            delay(10);
            client.print("</span></B></left>");
            client.print("<B><span style=\"color: #ff0000;\">");
            client.print(" - OFF");
            client.print("</span></B></center>");
          }
          //=========================================================================================================================
         
          client.print("<BR>");
          /*
          if (estadoip==1){
            client.print(" <meta http-equiv=\"refresh\" content=\"4; url=http://192.168.25.177/interno \"> ");
          }
          if (estadoip==2)  {    
            client.print(" <meta http-equiv=\"refresh\" content=\"4; url=http://arduinoyuri.dyndns.org/externo \"> ");
          } */
          
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
