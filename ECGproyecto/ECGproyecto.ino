byte a;
#define boton1 7
#define boton2 8
#define led 2
int i=0; float time = 0,dato;
bool b = true;

void setup() {
  Serial.begin(19200);
  pinMode(boton1,INPUT_PULLUP);
  pinMode(boton2,INPUT_PULLUP);
  pinMode(led,OUTPUT);
}

void loop() {
  /*i = analogRead(0);
  a = map(i,0,1024,0,255);
  Serial.write(a);*/
  i = analogRead(A0);
  if(i>560){
    digitalWrite(led,HIGH);
    tone(10,455);
    if(b){
      time = millis();
      b = !b;
    }else{
      time = millis()-time;
      b = !b;
      Serial.print("PPS:");
      dato = 1 / time;
      dato = int(dato * 60);
      Serial.println(dato);
    }
  }else{
    digitalWrite(led,LOW);
    noTone(10);
  }

  
  delay(10);
}
