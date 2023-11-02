

void setup() {
  Serial.begin(9600);

}

void loop() {
  int i=0,a;
  for(i=0;i<1024;i++){
    a = map(i,0,1024,0,255);
    Serial.write(a);
    delay(50);
  }
}
