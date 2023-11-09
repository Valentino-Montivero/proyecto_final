byte a;
#define boton1 7
#define boton2 8
#define led 2
int i=0;
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
      tiempo = millis();
      b = !b;
    }else{
      tiempo = millis()-tiempo;
      b = !b;
      Serial.print("PPM:");
      tiempo = 600 / tiempo;
      Serial.println(tiempo);
    }
  }else{
    digitalWrite(led,LOW);
    noTone(10);
  }

  delay(10);
}
