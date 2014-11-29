

static unsigned long h=0,m=0,s;
char S,M,H;
void setup() {

  
  Serial.begin(9600);
}


void loop() {
  
  if(m==60)m=0;
  if(h==24)h=0;
for(s=0;s<=60;s++){
    delay(5);
      if(s==60){
         m++;
         if(m==60){
           h++;
         }//Fecha if m==60
      }//Fecha if s==60
Serial.print(h,DEC);   
Serial.print(":"); 
Serial.print(m,DEC); 
Serial.print(":");
Serial.println(s,DEC);

 }//Fecha For 
  
    
 
}//Fecha loop



     
    
      
       
     
   

  
  
  

