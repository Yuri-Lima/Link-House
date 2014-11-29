

int h=0,m=0,s;
int Minutos;
int Horas=0;

void setup() {

  pinMode(13, OUTPUT);
  Serial.begin(9600);
}


void loop() {
  
  if(m==60){
     m=0;
   }//Fecha if minutos
  if(h==24){
     h=0;
   }//Fecha if horas
  
  for(s=0;s<=60;s++){
    delay(1000);
    Serial.print("Segundos: ");
    Serial.println(s);
      if(s==60){
         m++;
         Serial.print("Minutos: ");
         Serial.println(m);
         if(m==60){
           h++;
           Serial.print("Horas: ");
           Serial.println(h);
         }//Fecha if m==60
      }//Fecha if s==60
    }//Fecha For 
}//Fecha loop



     
    
      
       
     
   

  
  
  

