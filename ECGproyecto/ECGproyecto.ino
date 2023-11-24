#include <Adafruit_GFX.h>
#include <Adafruit_SH110X.h>
#include "PPM.h"
Adafruit_SH1106G display = Adafruit_SH1106G(128, 64, &Wire, -1);

byte a;
#define boton1 7
#define boton2 8
#define led 2
int pico = 0;
bool b = true, f = false; 
PPM ppm;

void setup() {
  Serial.begin(9600);
  delay(250);
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

  pico = analogRead(A1);
  pico = map(pico,0,1024,200,1000);
  a = map(analogRead(A0),400,800,0,225);
  Serial.write(a);

  if(analogRead(A0)>pico){

    if(b){
      digitalWrite(led,HIGH);
      tone(3,455,200);
      ppm.Inicio();
      b = !b;
      f = false;
    }else{
      digitalWrite(led,LOW);
      ppm.Final();
      b = !b;
      f = true;     
    }

    if(f){
      display.clearDisplay();
      display.display();
      display.setTextSize(2);
      display.setTextColor(SH110X_WHITE);
      display.setCursor(45, 10);
      display.println("PPS");
      display.setTextSize(2);
      display.setTextColor(SH110X_WHITE);
      display.setCursor(45, 40);
      display.println(ppm.GetPpm());
      display.display();
    }

    //while(analogRead(A0)>pico);
  }

  delay(20);
}
