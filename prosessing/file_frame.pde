class Frame{
  
private
  PImage frame;
  int CantidadFrame;
  boolean fold =true,rec = false;
public

  Frame(){
    frame = null;
    CantidadFrame = 1;
  }
  
  void guardar(){
    saveFrame("data/FrameECG/ECG-" + CantidadFrame + ".tif");
    CantidadFrame++;
    
    if(CantidadFrame>4){
      CantidadFrame = 1;
      rec = !rec;
    }
  }
  
  void OpenFile(){
    if((frame = loadImage("data/FrameECG/ECG-" + CantidadFrame + ".tif")) != null){
      if(CantidadFrame > 1){
         delay(1000);
      }
       image(frame,0,0);
       CantidadFrame++;
     }else{
       if(CantidadFrame == 1){
         background(0);
         fill(#FF3600);
         textSize(50);
         text("ERROR EN LECTURA",width/2,height/2);
         return;
       } else{
         CantidadFrame = 1;
       }
       fold = false;
     }
  }
  
  void Rec(){
    rec = !rec;
  }
  
  boolean recOk(){
    return rec;
  }
  
  boolean foldOk(){
   return fold; 
  }
  void FoldChange(){
    fold = !fold;
  }
};
