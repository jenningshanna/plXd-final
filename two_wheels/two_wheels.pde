import processing.serial.*;
Serial myPort;

int poteValue, pote2Value = 0;
int lightValue = 0;
int xpos = 0;
int ypos = 0;

float x, y;
float radiusCircle = 200;

void setup() {  
  size(400, 400);
  background(0);
  smooth();
  
  int portId = 4;
  //println (Serial.list());
  String portName = Serial.list()[portId];  //find the serial port, to port 4

  myPort = new Serial(this, portName, 9600);  //create serial object that processing can refer to
}

//Draw a circle using ellipse
//ellipseMode(RADIUS);
//stroke(palette[1]);
//noFill();
//ellipse(0, 0, radiusCircle, radiusCircle);

void draw(){
// Draw a circle with points
stroke(random(0,255), random(255), random(255));
//stroke(255);
strokeWeight(1);
translate(width/2, height/2);
for (float angle = 0; angle < 2*PI; angle += .1) {
  x = cos(angle + xpos) * radiusCircle;
  y = sin(angle + ypos) * radiusCircle;
  point(x, y);
}
}

// Draw dots in a spiral
//float radiusSpiralDots = 10;
//stroke(palette[3]);
//strokeWeight(5);
//for(float angle = 0; angle < 8*PI; angle += .1){
//  radiusSpiralDots += 0.5;
//  x = cos(angle) * radiusSpiralDots;
//  y = sin(angle) * radiusSpiralDots;
////  point(x, y);
//}
//
//// Draw a spiral line
//float px = -999;
//float py = -999;
//float radiusSpiralLine = 10;
//stroke(palette[2]);
//strokeWeight(1);
//for(float angle = 0; angle < 8*PI; angle += .05){
//  radiusSpiralLine += 0.25;
//  x = cos(angle) * radiusSpiralLine;
//  y = sin(angle) * radiusSpiralLine;
//  if(px > -999){
//    line(x, y, px, py);
//  }
//  px = x;
//  py = y;
//}

  void serialEvent( Serial serial) {
  // char lec = '\n';
  // int lei = 10;
   String s = serial.readStringUntil( '\n' );
  // String s = serial.readString();
  if ( s == null ) {
    // no thanks
  } 
  else {
    s = trim(s);
    //println(s);
    String stringArray[] = split(s, ',');
      xpos = int(stringArray[0]);
      ypos = int(stringArray[1]);
      lightValue = int(stringArray[2]);
      
      println("Potentiometer: " + xpos);
      println("Potentiometer-2: " + ypos);
      println("Light Meter" + lightValue);
  }
  }
