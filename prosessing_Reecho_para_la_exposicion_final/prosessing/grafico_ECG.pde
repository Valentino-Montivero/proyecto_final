int Lectura=0;
float deslizador = 0;
PImage back;

void grafica(){
  
  back = loadImage("data/flecha-atras.png");
  back.resize(80,80);
  image(back,0,0);
  //aqui cargo la imagen para la flecha para atras
  if(mousePressed){
    if((dist(mouseX,mouseY,40,40)) <= 40){
      grafico = false;
      background(#79F1E5);
      imagen();
      beggin.recet(); 
      fin.recet();
      Arduino.write(0);
      return;
    }
  }
  /*aca reviso si aprete el boton de la flecha, si lo toque, le aviso al arduino, cambia el estado del bool grafico
  limpio la pantalla y cargo el menu principal nuevamente
  */
  
  fill(200);
  rect(width-100,10,60,50);
  
  if(!file.getRec()){
    fill(0);
  }else{
    fill(#FF0000);
  }
  textSize(30);
  text("REC.",width-100,50);
  /* aca creo el rectangulo el texto para el boton de grabar, y dependiendo del estado del bool rec pongo el texto
  en negro o bien en rojo
  */
  
  stroke(#13FF00);
  strokeWeight(3); // le damos color y grosor a la linea del ECG

  if(Arduino.available()>0){ //reviso si el puerto serial tiene algo para leer, si es asi lo leo y lo mando a la variable "Lectura"
    Lectura = (int)Arduino.read();
    Lectura =(int) map(Lectura,0,255,-height*3/4,height*3/4); // estrapolamos los datos a la pantalla para la grafica
  }
  
  suma_de_funcion(Lectura);
  tramo_de_linea();
  igualar_terminos();
  /* estas funciones se encargan de la grafica, la suma de funciones se encarga de el punto fin se mueva una cantidad pre-establecida
  en el eje x que se mueve equisdistante medianto toda la grafica, y le damos un alto igual al valor medido por el puerto serial.
  la funcoin tramo de linea se encarga de generar una linea desde el punto en el 0.0 beggin hasta el punto fin, asi se crea un 
  pequeño tramo de recta de la cual esta conformada la grafica general.
  y la funcion igualar terminos se encarga de darle a biggin la misma posicion que fin, y luego vuelvo a mover a fin y crear la linea
  asi en bucle generamos una gran grfico con solo dos puntos los cuales se desplazan.
  */
  
  if(fin.x==width){
    if(file.getRec()){
      file.guardar(); 
    }
    deslizador = 0;
    rewind();
  } 
 /*este if revisa si ya hemos llegado al final de la pantalla, en caso afirmativo me fijo si estoy grabando, si es correcto entonves guardo un frame.
 luego independiente de si grabo o no receteo el deslizador para empezar desde el principio de la pantlla nuevamente y receteo la pantalla con
 la funcion rewind(),
 */
}


//En esta funcion vamos cambiando la posicion del punto con un sumador, luego sera con las señales del puerto serial.
void suma_de_funcion(int _i){
  deslizador++;
  fin.x =(int) map(deslizador,0,200,0,width);//la funcion map sirve para extrapolar la posicion a una mas comoda en la pantalla.
  fin.y = (height/4)-_i;
}

void tramo_de_linea(){//esta funcion sirve para crear una linea recta entre el punto anterior y el sigiente.
 line(beggin.x,beggin.y,fin.x,fin.y); 
}

void igualar_terminos(){ // ahora igualo los terminos del anterior con el siguiente, asi desplazo el punto de atras y el nuevo lo reubico en le inicio.
  beggin.x = fin.x;
  beggin.y = fin.y;
}

/*esta funcion hace que una vez llegado al final, la grafica se reinicie lña pantalla asi borro todo lo ya visto, devuelvo los puntos a su lugar y vuelvo a generar las
lineas y las imagenes.
*/
void rewind(){
 background(0);
 image(back,0,0);
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
