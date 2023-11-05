class Frame{
  
private
  PImage frame;
  int CantidadFrame;
  boolean bandera =true;
public

  Frame(){
    frame = null;
    CantidadFrame = 1;
  }
  
  void guardar(){
    while(CantidadFrame <= 200){
      saveFrame("data/FrameECG/ECG-" + CantidadFrame + ".tif");
    }
    
    CantidadFrame = 1;
  }
  
  void OpenFile(){
    
    while(bandera){
      if((frame = loadImage("data/FrameECG/ECG-" + CantidadFrame + ".tif")) != null){
        image(frame,0,0);
        CantidadFrame++;
      }else{
        background(0);
        fill(#FF3600);
        textSize(50);
        text("ERROR EN LECTURA",width/2,height/2);
        delay(1000);
        bandera = false;
      }
      if(CantidadFrame <= 200){
        bandera = false;
      }
    }
    frame = null;
    CantidadFrame = 1;
  }
};
