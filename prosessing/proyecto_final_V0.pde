import processing.serial.*;
Serial Arduino;   
pont beggin, fin; 
Frame file;
String usser = "";
boolean grafico = false, archivo = false, usuario = true;
PImage logo,ECG;

/* importamos la libreria de comunicacion serial y creamos un objeto de la libreria para comunicarnos con arduino
tambien creamos un objeto tipo "pont" que es una clase propia, estos objetos son los puntos que recorreran toda la pantalla
graficando el ECG
creo un objeto tipo "frame", esta clase que tambien es propia se encarga de manejar los archivos guardados, por lo tanto se encarga de 
guardarlos.
creo un string llamado usser que se encarga de guardar el nombre del usuario, y lo dejo vacio.
luego creo 3 bandras de tipo bool, la bandera "grafico" se usa para saber si mi programa esta en el modo de graficar el ECG
la bandera "archivo" es para saber si estoy leyendo un archivo, y la "usuario" es para saber si estoy ingresando un nuevo usuario,
y por ultimo creo dos archivos de imagen para traer las imagenes de la pantalla principal.
*/

void setup(){
  size(1600,900);
  background(#79F1E5);
  beggin = new pont();
  fin = new pont();
  file = new Frame();
  printArray(Serial.list());
  Arduino = new Serial(this,Serial.list()[1],9600);
  print(Arduino);
  Arduino.clear();
  frameRate(60);
}

/*generamos una ventana de 1600x900 y de lamos color, luego le agregamos memoria dinamica a cada objeto creado
depsues imprimimos las listas de los puertos serial que tiene libre la pc. y iniciamos el puerto
tambien limpiamos cualquier basura que pueda tener y bloqueamos los fps a 60. 
*/

void draw(){ 
  
  if(usuario){ // Este if sirve para ingresar los usuarios, o binen, cambiarlos. 
    background(#79F1E5);
    fill(0);
    textSize(50);
    text("Ingrese el nombre de usuario:",width/3,height/2);
  }
  
  if(!grafico && !archivo && !usuario){ // este if sirve para entrar al menu principal de la app
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
    
    if(Arduino.available()>0){ // aqui se leen datos del arduino para poder ingresar al ECG mediante un boton del mismo.
      if(Arduino.read() == 1){
        background(0);
        Arduino.clear();
        grafico = true;
        Arduino.write(1);
      }
    }
  }
  
  if(grafico){ // este if sirve para saber si estamos dentro de la graficas de los ECGs.
    stroke(255);
    line(0,height/2,width,height/2);
    stroke(255,100);
    line(0,height/2+height*3/8,width,height/2+height*3/8);
    stroke(255,100);
    line(0,height/2-height*3/8,width,height/2-height*3/8);
    grafica();
  }
  
  if(archivo){ // este if sirve para empezar a leer un archivo de los guardados.
    file.OpenFile();
  }
  
    if(file.getFold() && archivo){ //este if se utiliza para saver si llegamos a la ultima imagen de la galeria de los ECGs
    delay(1000);
    archivo = !archivo;
    file.FoldChange();
    background(#79F1E5);
    imagen();
  }
  
  if(!file.getFold() && archivo){//este if se utiliza cuando al habrir un archivo de ECG sale un error, cuando tocamos cualquier tecla volvemos al menu principal.
    if(keyPressed){
      archivo = !archivo;
      file.FoldChange();
      background(#79F1E5);
      imagen();
    }
  }
  
}

void mousePressed(){
 if((mouseX>width/2-530) && (mouseX<width/2-60) && (mouseY>height/2-90) && (mouseY<height/2+10) && !grafico && !usuario){ 
    background(0);
    Arduino.clear();
    grafico = true;
    Arduino.write(1);
  }
  
  /* este boton es el de graficar ECG, una vez lo apretamos actualizamos la pantalla y cambiamos el bool de "grafico"
  por lo tanto no entramos al menu principal pero si al de graficos, y empezamos a usar la funcion grafica.
  tambien le mandamos a arduino una señal para desactivar el boton asi no enviamos datos falsos.
  */
  
  if((mouseX>width/2-530) && (mouseX<width/2+60) && (mouseY>height/2+100) && (mouseY<height/2+200) && !archivo && !usuario){
     archivo = true;
  }
  
  /* este boton es el de leer archivos, cuando lo apretamos busca si existe algun archivo que posea el nombre del usuario
  en caso de no haberlo solamente sale una imagen de error y se puede apretar cualquier boton para volver
  */
  
  if((mouseX>width-100) && (mouseX<width-40) && (mouseY>10) && (mouseY<60) && grafico){
    file.Rec();
  }
  
  /* este boton aparece en la grafica de los ECG, es el boton de grabar, una vez apretado entra en el atributo Rec del objeto file
  el cual guarda cuatro frames en alta calidad del ECG.
  */
  
  if((dist(width/2-700,height/2-350,mouseX,mouseY))<=100 && !grafico){
    usuario = !usuario;
    usser = "";
  }
  
  /* este boton es el de usuario, se encarga de cambiar los usuarioscuando se decee, para ello cambia el estado del bool usuario
  y luego bacia el string usser, asi lo podemos llenar nuevamente sin ningun problema.
  */
}

void imagen(){ 
  fill(255);
  logo = loadImage("data/logo-hospital.png");
  ECG = loadImage("data/ECG-linea.png");
  ECG.resize(200,200);
  logo.resize(200,200);
  image(ECG,width/2,height/2-120);
  image(logo,width/2-800,height/2+250);
  textSize(30);
  text("By Valentino_Montivero.",width/2+450,height/2+420);
  
  /* Esta es la funcion "imagen" se encarga de cargar las fotos del menu principal, vemos que lo primero que hacemos es colocar un color
  blanco puro, luego cargamos las dos imagenes que son "logo" y "ECG" tambien le hacemos un reescalado y las colocamos en pantalla.
  por ultimo ubicamos un texto con el nombre del creador del programa.
  */
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
  
  /*usamos esta funcion para cargar letra por letra son cargar la misma letra en bucle, ya que al declarar la funcion "keyPressed" 
  de forma apartada esta se ejecuta aparte y no vuelve al loop hasta que se termine de ejecutar, asi podemos cargar letra tras letra 
  sin la necesidad de colocar retrsadores y calcular tiempos complejos.
  */
}
