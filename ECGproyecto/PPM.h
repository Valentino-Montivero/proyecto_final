class PPM{
private:
  float begined;
  float finish;
  float tiempo;
public:
  PPM();
  ~PPM(){};

  void Inicio();
  void Final();
  float GetPpm();
};

PPM::PPM(){
  begined = 0;
  finish = 0;
  tiempo = 0;
}

void PPM::Inicio(){
  begined = millis();
}

void PPM::Final(){
  finish = millis();
}

float PPM::GetPpm(){
  tiempo = finish - begined;
  tiempo = (1200/tiempo);
  return tiempo;
}
//metamos todos los posibles datos y funciones que calculemso en este punto, asi queda mejor el programa, tambien
//mandemos datos a la oled desde aca, y asi ya podriamos comunicarnos de forma continuia con la placa y la pc.
