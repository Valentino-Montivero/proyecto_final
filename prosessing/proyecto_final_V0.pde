import processing.serial.*;
Serial Arduino;
pont beggin, fin; //Declaro un objeto del tipo pont para crear los puntos inicion y fin.
Frame file;
boolean grafico = false, archivo = false;
PImage logo,ECG;//definimos las imagenes que deceamos usar en el menu.

void setup(){
  fullScreen();
  background(#79F1E5);
  beggin = new pont(); //Les añado memoria dinamica para poder usar el objeto.
  fin = new pont();
  file = new Frame();
  printArray(Serial.list());
  Arduino = new Serial(this,Serial.list()[1],19200);
  print(Arduino);
  frameRate(60);
  imagen();
}

void draw(){ 

  
  if(!grafico && !archivo){
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
  
  if(grafico){
    stroke(255);
    line(0,height/2,width,height/2);
    stroke(255,100);
    line(0,height/2+height*3/8,width,height/2+height*3/8);
    stroke(255,100);
    line(0,height/2-height*3/8,width,height/2-height*3/8);
    grafica();
  }
  
  if(archivo){
    file.OpenFile();
  }
  
}

void mousePressed(){
  if((mouseX>width/2-530) && (mouseX<width/2-60) && (mouseY>height/2-90) && (mouseY<height/2+10) && !grafico){
    background(0);
    grafico = true;
  }
  
  if((mouseX>width/2-530) && (mouseX<width/2+60) && (mouseY>height/2+100) && (mouseY<height/2+200) && !archivo){
      archivo = true;
  }
  
  if((mouseX>width-100) && (mouseX<width-40) && (mouseY>10) && (mouseY<60) && grafico){
    file.Rec();
  }
}

void imagen(){ //esta funcion carga las imagenes y texto del menu principal.
  logo = loadImage("data/logo-hospital.png");
  ECG = loadImage("data/ECG-linea.png");
  ECG.resize(200,200);
  logo.resize(200,200);
  image(ECG,width/2-50,height/2-120);
  image(logo,width/2-900,height/2+300);
  textSize(30);
  text("By Valentino_Montivero.",width/2+600,height/2+500);
}
