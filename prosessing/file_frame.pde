class Frame{
  
private
  PImage frame;
  int CantidadFrame;
  boolean fold =false,rec = false;
public

  Frame(){ //constructor
    frame = null;
    CantidadFrame = 1;
  }
  
  void guardar(){ //se encarga de guardar el archivo en su carpeta correspondiente hasta la cuarta imagen y reinicia cambiando el bool rec.
    saveFrame("data/FrameECG/ECG-" + usser + "/" + CantidadFrame +".tif");
    CantidadFrame++;
    
    if(CantidadFrame>4){
      CantidadFrame = 1;
      rec = !rec;
    }
  }
  
  void OpenFile(){ //sirve para habrir un archivo y asegurarme que este bien leido, caso contrario muestro un mensaje de error son cambiar el bool rec y no reinicio.
    if((frame = loadImage("data/FrameECG/ECG-" + usser + "/" + CantidadFrame +".tif")) != null){
      if(CantidadFrame > 1){
         delay(1000);
      }
       image(frame,0,0);
       CantidadFrame++;
     }else{
       if(CantidadFrame == 1){
         CantidadFrame = 1;
         background(0);
         fill(#FF3600);
         textSize(50);
         text("ERROR EN LECTURA",width/2-250,height/2);
         return;
       } else{
         CantidadFrame = 1;
         fold = true;
       }
     }
  }
  
  void Rec(){ // cambiamos el bool rec para empezar a grabar
    rec = !rec;
  }
  
  boolean getRec(){
    return rec;
  }
  
  boolean getFold(){
   return fold; 
  }
  void FoldChange(){
    fold = !fold;
  }
};

/* Esta es la clase Frame creada para la manipulacion de archivos y la lectura de los mismos, tambien controlamos los bool como fold y rec para saber si estamos 
grabando o bien estamos tratando de leer un archivo
*/
