import processing.serial.*;
Serial Arduino;
pont beggin, fin; //Declaro un objeto del tipo pont para crear los puntos inicion y fin.

PImage logo,ECG;

void setup(){
  fullScreen();
  background(#79F1E5);
  beggin = new pont(); //Les añado memoria dinamica para poder usar el objeto.
  fin = new pont();
  /*stroke(255);
  line(0,height/2,width,height/2);
  stroke(255,100);
  line(0,height/2+height*3/8,width,height/2+height*3/8);
  stroke(255,100);
  line(0,height/2-height*3/8,width,height/2-height*3/8);
  printArray(Serial.list());*/
 // Arduino = new Serial(this,Serial.list()[1],19200);
  //println(Arduino);
  
  logo = loadImage("data/logo-hospital.png");
  ECG = loadImage("data/ECG-linea.png");
  ECG.resize(200,200);
  logo.resize(200,200);
  image(ECG,width/2-50,height/2-120);
  image(logo,width/2-900,height/2+300);
  textSize(30);
  text("By Valentino_Montivero.",width/2+600,height/2+500);
}

void draw(){ 
  
  fill(#50B2A9);
  rect(width/2-340,height/2-490,600,100,28);
  fill(255);
  textSize(100);
  text("ECG-Arduino",width/2-300,height/2-400);
  
  fill(#5097B2);
  rect(width/2-530,height/2-90,470,100,28);
  fill(255);
  text("Mirar-ECG",width/2-500,height/2);
  
  fill(#5097B2);
  rect(width/2-530,height/2+100,590,100,28);
  fill(255);
  text("Grabaciones",width/2-500,height/2+190);
}
