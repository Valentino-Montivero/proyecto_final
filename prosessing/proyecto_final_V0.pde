import processing.serial.*;
Serial Arduino;
pont beggin, fin; //Declaro un objeto del tipo pont para crear los puntos inicion y fin.
Frame file;
String usser = "";
boolean grafico = false, archivo = false, usuario = true;
PImage logo,ECG;//definimos las imagenes que deceamos usar en el menu.

void setup(){
  size(1600,900);
  background(#79F1E5);
  beggin = new pont(); //Les añado memoria dinamica para poder usar el objeto.
  fin = new pont();
  file = new Frame();
  printArray(Serial.list());
  Arduino = new Serial(this,Serial.list()[1],9600);
  print(Arduino);
  frameRate(60);
}

void draw(){ 
  
  if(file.foldOk() && archivo){
    delay(1000);
    archivo = !archivo;
    file.FoldChange();
    background(#79F1E5);
    imagen();
  }
  
  if(!file.foldOk() && archivo){
    if(keyPressed){
      archivo = !archivo;
      file.FoldChange();
      background(#79F1E5);
      imagen();
    }
  }
  
  if(usuario){
    background(#79F1E5);
    fill(0);
    textSize(50);
    text("Ingrese el nombre de usuario:",width/3,height/2);
  }
  
  if(!grafico && !archivo && !usuario){
    imagen();
    
    fill(30);
    textSize(50);
    text("usuaruio:"+usser,width/2-200,height/2-200);
    
    fill(#50B2A9);
    rect(width/3.2,height/28,600,100,28);
    fill(255);
    textSize(100);
    text("ECG-Arduino",width/3,height/8);
    
    fill(#5097B2);
    rect(width/2-530,height/2-90,470,100,28);
    fill(255);
    text("Mirar-ECG",width/2-500,height/2);
    
    fill(#5097B2);
    rect(width/2-530,height/2+100,590,100,28);
    fill(255);
    text("Grabaciones",width/2-500,height/2+190);
    
    fill(#5097B2);
    circle(width/2-700,height/2-350,100);
    fill(#40788D);
    circle(width/2-720,height/2-350,10);
    circle(width/2-700,height/2-350,10);
    circle(width/2-680,height/2-350,10);
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
 if((mouseX>width/2-530) && (mouseX<width/2-60) && (mouseY>height/2-90) && (mouseY<height/2+10) && !grafico && !usuario){
    background(0);
    Arduino.clear();
    grafico = true;
  }
  
  if((mouseX>width/2-530) && (mouseX<width/2+60) && (mouseY>height/2+100) && (mouseY<height/2+200) && !archivo && !usuario){
      archivo = true;
  }
  
  if((mouseX>width-100) && (mouseX<width-40) && (mouseY>10) && (mouseY<60) && grafico){
    file.Rec();
  }
  
  if((dist(width/2-700,height/2-350,mouseX,mouseY))<=100 && !grafico){
    usuario = !usuario;
    usser = "";
  }
}

void imagen(){ //esta funcion carga las imagenes y texto del menu principal.
  fill(255);
  logo = loadImage("data/logo-hospital.png");
  ECG = loadImage("data/ECG-linea.png");
  ECG.resize(200,200);
  logo.resize(200,200);
  image(ECG,width/2,height/2-120);
  image(logo,width/2-800,height/2+250);
  textSize(30);
  text("By Valentino_Montivero.",width/2+450,height/2+420);
}

void keyPressed(){
  char aux;
  
  if(usuario){
    aux = key;
    if(aux == '\n'){
      background(#79F1E5);
      usuario = !usuario;
    }else{
      usser = usser + aux;
    }
  }
}
