/* Zarina Barsh "Ariel"  Following comments will include all references all the way at the bottom
Instructions up top*/
/** Instructions: push button to strobe the background.
2 touch sensors, to fly the aerialist around the canvas**/

import processing.serial.*;
import processing.sound.*; 
Serial myPort;
SoundFile file;

  PImage ariel;
  int bgcolor = 0;
  int[] serialInArray = new int[3];    
  int serialCount = 0;                 
  int xpos, ypos;                
  boolean firstContact = false;        

  
void setup() {
  size(1080,1920);
 // surface.setResizable(true);
  colorMode(HSB, 255);
  ariel = loadImage("GraphicElements.png");
  //surface.setSize(ariel.width, ariel.height);

xpos = width / 2;
ypos = height / 2;
    
    
  println("Available serial ports: ");
  println(Serial.list());
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);

  file = new SoundFile(this, "M32 Bass 4 128bpm.wav");   
  file.loop();

}

void draw() {

background(bgcolor);
image(ariel, xpos, ypos, 80, 80);

}

/*******/
void serialEvent(Serial myPort) {
    int inByte = myPort.read();
    if (firstContact == false) {
      if (inByte == 'A') {
        myPort.clear();          
        firstContact = true;    
        myPort.write('A');     
      }
    }

    else {
      serialInArray[serialCount] = inByte;
      serialCount++;
      if (serialCount > 2 ) {

        xpos = serialInArray[0];
        ypos = serialInArray[1];
        bgcolor = serialInArray[2];
        
        println(xpos + "\t" + ypos + "\t" + bgcolor);
        myPort.write('A');
        serialCount = 0;
      }

    }

  }
  
 /** references: "Arduino Project Book" - Tweak the logo ch.14
 "https://www.arduino.cc/en/Tutorial/BuiltInExamples/SerialCallResponse'" Handshake of multiple sensors
 "https://github.com/entertainmenttechnology/Corn-MTEC2280-Spring2021/tree/main/week7/demo2_sounds2Looping" sound loop**/
 
