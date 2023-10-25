pont beggin, fin;
float Sumador = 0;

void setup(){
  //size(400,400);
  fullScreen();
  background(100);
  beggin = new pont();
  fin = new pont();
  stroke(255);
  line(0,height/2,width,height/2);
  stroke(255,50);
  line(0,height/2+height/4,width,height/2+height/4);
  stroke(255,50);
  line(0,height/2-height/4,width,height/2-height/4);
}

void draw(){ // este es el loop
  stroke(#13FF00);
  
  int i =(int) map(random(50),0,50,-height/4,height/4);
  
  suma_de_funcion(i);
  tramo_de_linea();
  igualar_terminos();
  
  if(fin.x==width){
    background(100);
    Sumador =0;
    setup2();
  }
  
  delay(50);
}

class pont{
public
  pont(){
    x = 0;
    y = height/2;
  }
  int x ;
  int y ;
}

void suma_de_funcion(int _i){
  Sumador += 2;
  fin.x =(int) map(Sumador,0,200,0,width);
  fin.y = (height/2)+_i;
}

void tramo_de_linea(){
 line(beggin.x,beggin.y,fin.x,fin.y); 
}

void igualar_terminos(){
  beggin.x = fin.x;
  beggin.y = fin.y;
}

void setup2(){
  size(400,400);
  background(100);
  beggin = new pont();
  fin = new pont();
  stroke(255);
  line(0,height/2,width,height/2);
  stroke(255,50);
  line(0,height/2+height/4,width,height/2+height/4);
  stroke(255,50);
  line(0,height/2-height/4,width,height/2-height/4);
}
/*nota: El programa se crashea al ponerlo en pantalla grande:
dos soluciones, la primera es solo hacerlo compatible con pantalla grande y ya, la segunda es toquetear hasta hacerlo andar en la pantalla que quiera. El error que sucede es que se sale de pantalla el dibujo y luego no recetea.
*/
