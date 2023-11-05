class pont{
public
  pont(){
    x = 0;
    y = height/2;
  }
  void recet(){
    x = 0;
    y = height/2;
  }
  int x ;
  int y ;
};
/*esta funcion es una clase que crea un punto ubicado en la parte de la izquierda de la pantalla justo a la mitad de la misma,
este punto tendra distintas posiciones dependiendo de como modifiquemos sus cordenadas x e y, esta clase se usa para poder discretizar y 
extrapolar la funcion de forma eficiente.
*/
