

static unsigned long h=0,m=0,s;
char S,M,H;
int botao=2;
int leitura=0;

void setup() {
Serial.begin(9600);
pinMode(butao,INPUT_PULLUP);
delay(1000);
Serial.println("Aperte um botao para comecar a contagem!");
}


void loop() {
  leitura=digitalRead(butao);
  delay(5);
if(leitura==HIGH){
  if(m==60)m=0;
  if(h==24)h=0;
for(s=0;s<=60;s++){
    delay(1000);//contador a cada segundou
      if(s==60){
         m++;
         if(m==60){
           h++;
         }//Fecha if m==60
      }//Fecha if s==60
if(h<10){ 
  Serial.print("0");  
  Serial.print(h,DEC);   
  Serial.print(":"); 
}  else{
      Serial.print(h,DEC);   
      Serial.print(":");
}
if(m<10){
  Serial.print("0");
  Serial.print(m,DEC); 
  Serial.print(":");
}  else{
      Serial.print(m,DEC); 
      Serial.print(":");
}
if(s<10){
  Serial.print("0");
  Serial.println(s,DEC);
}  else{
      Serial.println(s,DEC);
}

   }//Fecha For 

 

}//Fecha loop



     
    
      
       
     
   

  
  
  

