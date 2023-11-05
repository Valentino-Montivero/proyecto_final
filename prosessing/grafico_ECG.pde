int i=0;
float Sumador = 0;

void grafica(){
  
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
 
}


//En esta funcion vamos cambiando la posicion del punto con un sumador, luego sera con las señales del puerto serial.
void suma_de_funcion(int _i){
  Sumador++;
  fin.x =(int) map(Sumador,0,200,0,width);//la funcion map sirve para extrapolar la posicion a una mas comoda en la pantalla.
  fin.y = (height/4)-_i;
}

void tramo_de_linea(){//esta funcion sirve para crear una linea recta entre el punto anterior y el sigiente.
 line(beggin.x,beggin.y,fin.x,fin.y); 
}

void igualar_terminos(){ // ahora igualo los terminos del anterior con el siguiente, asi desplazo el punto de atras y el nuevo lo reubico en le inicio.
  beggin.x = fin.x;
  beggin.y = fin.y;
}

//esta funcion hace que una vez llegado al final, la grafica se reinicie.
void rewind(){
 background(0);
  beggin = new pont();
  fin = new pont();
  strokeWeight(1);
  stroke(255);
  line(0,height/2,width,height/2);
  stroke(255,100);
  line(0,height/2+height*3/8,width,height/2+height*3/8);
  stroke(255,100);
  line(0,height/2-height*3/8,width,height/2-height*3/8);
}

/*
Aqui esta todas las funciones de procesamiento de la imagen con respecto a la grafica que se puede observar en la PC
*/
