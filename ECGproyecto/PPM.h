class PPM{
private:
  float begined;//dato temporal del primer pico
  float finish;//dato temporal del segundo pico
  float tiempo;//intervalo temporal
public:
  PPM();
  ~PPM(){};

  void Inicio();
  void Final();
  float GetPpm();
};

PPM::PPM(){ //cosntructor
  begined = 0;
  finish = 0;
  tiempo = 0;
}

void PPM::Inicio(){ // inicializamos a begined con el dato temporal del primer pico
  begined = millis();
}

void PPM::Final(){ // inicializamos a finish con el dato temporal del segundo pico
  finish = millis();
}

float PPM::GetPpm(){ // inicializamos la variable tiempo con el delta de tiempo y luego calculamos los PPM
  tiempo = finish - begined;
  tiempo = (60000/tiempo) * 0.0343; // el valor 0.0343 es un valor de correccion, ya que los PPM aparecian desfasados
  return tiempo; // entrgamos el dato tiempo ya como PPMs.
}
/*Esta clase se encarga de calcular la diferencia temporal entre cada pico cardiaco
luego calcular su equivalente en PPM, guardar y entregar dichos datos.
*/
