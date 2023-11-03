pont beggin, fin; //Declaro un objeto del tipo pont para crear los puntos inicion y fin.
float Sumador = 0;
import processing.serial.*;
Serial Arduino;
int i=0;

void setup(){
  fullScreen();
  background(0);
  beggin = new pont(); //Les añado memoria dinamica para poder usar el objeto.
  fin = new pont();
  stroke(255);
  line(0,height/2,width,height/2);
  stroke(255,100);
  line(0,height/2+height*3/8,width,height/2+height*3/8);
  stroke(255,100);
  line(0,height/2-height*3/8,width,height/2-height*3/8);
  printArray(Serial.list());
  Arduino = new Serial(this,Serial.list()[1],19200);
  println(Arduino);
}

void draw(){ 
  
  stroke(#13FF00);
  strokeWeight(3);

  if(Arduino.available()>0){
    i = (int)Arduino.read();
    i =(int) map(i,0,255,-height*3/4,height*3/4);
  }
  
  suma_de_funcion(i);
  strokeWeight(3);
  tramo_de_linea();
  igualar_terminos();
  
  if(fin.x==width){
    Sumador =0;
    rewind();
  }
  
  delay(50);
}
