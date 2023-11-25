#include <Adafruit_GFX.h>
#include <Adafruit_SH110X.h>
#include "PPM.h"
Adafruit_SH1106G display = Adafruit_SH1106G(128, 64, &Wire, -1);

/* Importamos las librerias para usar la pantlla oled "SH110X, y para generar graficas en la misma "GFX.h"
tambien incluimos a la clase PPM que genere en otra ventana, y por ultimo inicializo la clase de la oled.
*/

byte a;
#define boton 4
#define led 2
int pico = 0;
bool delta = true, oled = false, grafico = false; 
PPM ppm;

/*genero una variable tipo byte para mandar los archivos a la pc de la forma mas repida/liviana posible
luego defino donde estara el boton para entrar el ECG y donde saldra el led para revisar los PPM
tambien declaro un entero pico para almacenar el pico de la grafica lo mas presisamente posible
asi poder medir los PPM, luego tengo 3 bool para saber cuando paso por un pico "delta", cuando tengo el 
dato temporal de dos picos para calcular por pantalla "oled" y cuando debo tomar datos del sensor o no
"grafico"
y declaro un objeto tipo PPM la cual es una clase que se encarga de calcular y almacenar dico valor
*/

void setup() {
  Serial.begin(9600);
  delay(250);
  pinMode(boton,INPUT_PULLUP);
  pinMode(led,OUTPUT);
  display.begin(0x3C, true);
  display.display();
  display.clearDisplay();
  delay(200);
  display.setTextSize(2);
  display.setTextColor(SH110X_WHITE);
  display.setCursor(45, 10);
  display.println("PPM        -");
  display.display();
  /* Inicio el monitor serial a 9600 de velocidad, espero un poco para que tenga una coneccion lo mas segura podible
  luego declaro tanto el boton como el led, tambien inicializo la pantalla oled y muesto un mensaje por pantalla.
  */
}

void loop() {

  if(grafico){ //si puedo graficar entonces leo los datos por A0 y los extrapolo y luego los mando en formato de byte
    pico = analogRead(A1);
    pico = map(pico,0,1024,200,1000);
    a = map(analogRead(A0),400,800,0,225);
    Serial.write(a);
  }
  /* observar que extrapolo los datos, esto es debido a que la funcion Serial.write() manda datos en forma de byte,
  y el funcion analogRead() lee datos muestrados desde un ADC que entrega valores de 0-1024, y como los bytes van
  de 0-255 es necesario extrapolarlos para no envier datos que no controlemos o bien hacer un desborde de memoria 
  en la funcion Serial.write()
  */

  if(analogRead(A0)>pico && grafico){

    if(delta){
      digitalWrite(led,HIGH);
      tone(3,455,200);
      ppm.Inicio();
      delta = !delta;
      oled = false;
    }else{
      digitalWrite(led,LOW);
      ppm.Final();
      delta = !delta;
      oled = true;     
    }

    if(oled){
      display.clearDisplay();
      display.display();
      display.setTextSize(2);
      display.setTextColor(SH110X_WHITE);
      display.setCursor(45, 10);
      display.println("PPM");
      display.setTextSize(2);
      display.setTextColor(SH110X_WHITE);
      display.setCursor(45, 40);
      display.println(ppm.GetPpm());
      display.display();
    }
  }
  /* Este if se fija si puedo graficar y si estou en un pico de la funcion, si las dos son ciertas
  entonces el primer if de adentro se encarga en saver si es el primer pico que leo o el segundo
  par ahcer un delta de tiempo y calcular los PPM mediante atributos de la clase PPM,
  y el ultimo if se encarga de mostrar por la pantlla oled los datos solo si estan listos para ser mostrados.
  */

  if(!grafico){ //se encarga de empezar a graficar en proseccion y a enviar datos desde arduino
    if(!digitalRead(boton)){
        Serial.write(1);
    }
    delay(100);
  }

  if(Serial.available()>0){
    int valorLeido = Serial.read();
    if(valorLeido == 1){
      grafico = !grafico;
    }
    if(valorLeido == 0){
      display.clearDisplay();
      display.display();
      display.setTextSize(2);
      display.setTextColor(SH110X_WHITE);
      display.setCursor(45, 10);
      display.println("PPM        -");
      display.display();
      grafico = !grafico;
      digitalWrite(led,LOW);
    }
  }
  /*Este if se encarga de leer si existe algun dato en el puerto serie, si es el caso lo lee y revisa que dato es.
  el procesing envia un dato cuando entramos a leer archivos o cuando entramso a graficar, el dato que manda es 1
  y se encarga de inabilitar los botones cuando grafico asi no se mandan mas datos inecesarios.
  y el otro dato es 0 este es cuando salgo de los graficos, lo que hago es inabilitar el sensor y recetear tanto 
  la pantalla como el led, asi no se mandan datos inecesarios mientras transcurre el programa en si menu principal.
  */

  delay(20); //este delay sirve para practicamente todo, deja tiempo de leer datos seriales, y de mandarlos tambien.
}
