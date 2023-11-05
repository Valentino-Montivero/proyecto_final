byte a;
int i=0;

void setup() {
  Serial.begin(19200);
}

void loop() {
  i = analogRead(0);
  a = map(i,0,1024,0,255);
  Serial.write(a);
  delay(50);
}
