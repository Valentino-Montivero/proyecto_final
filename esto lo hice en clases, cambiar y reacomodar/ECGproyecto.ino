#include <Adafruit_GFX.h>
#include <Adafruit_SH110X.h>
#include "PPM.h"
Adafruit_SH1106G display = Adafruit_SH1106G(128, 64, &Wire, -1);

byte a;
#define boton1 7
#define boton2 8
#define led 2
int i=0;
bool b = true, f = true; 
PPM ppm;

void setup() {
  Serial.begin(19200);
  //delay(250);
  pinMode(boton1,INPUT_PULLUP);
  pinMode(boton2,INPUT_PULLUP);
  pinMode(led,OUTPUT);
  display.begin(0x3C, true);
  display.display();
  display.clearDisplay();
  delay(200);
  display.setTextSize(2);
  display.setTextColor(SH110X_WHITE);
  display.setCursor(45, 10);
  display.println("PPS        -");
  display.display();
}

void loop() {
  /*i = analogRead(0);
  a = map(i,0,1024,0,255);
  Serial.write(a);*/
  
  i = analogRead(A0);
  Serial.println(i);
  if(i>550 && b){
    digitalWrite(led,HIGH);
    tone(10,455);
    ppm.Inicio();
    if(f){
        display.setTextSize(2);
        display.setTextColor(SH110X_WHITE);
        display.setCursor(45, 10);
        display.println("PPS");
        display.setTextSize(2);
        display.setTextColor(SH110X_WHITE);
        display.setCursor(45, 20);
        display.println(ppm.GetDelta());
        display.display();
    }
  }
  
  
}
