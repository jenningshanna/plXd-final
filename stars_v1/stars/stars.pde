import processing.serial.*;
Serial myPort;

int poteValue = 0;
int pote2Value = 0;
int xpos = 0;
float ypos = 0.;
float lightValue = 0;
float yposRadius = 0;

float x, y;

//float radiusCircle = lightValue;

void setup() {  
  size(400, 400);
  background(0);
  smooth();

  int portId = 4;
  //println (Serial.list());
  String portName = Serial.list()[portId];  //find the serial port, to port 4

  myPort = new Serial(this, portName, 9600);  //create serial object that processing can refer to
  myPort.buffer(130);
}

//Draw a circle using ellipse
//ellipseMode(RADIUS);
//stroke(palette[1]);
//noFill();
//ellipse(0, 0, radiusCircle, radiusCircle);

void draw() {
  // Draw a circle with points
  background(0);
  stroke(random(0, 255), random(255), random(255));
  //stroke(255);
  strokeWeight(2);
  translate(width/2, height/2);
  yposRadius = map(ypos, 0, 255, 0.0, 300.0);
  //xpos = map(xpos, 0, 255, 0., 4.);
  //poteValue = map(poteValue, 0, 255, 0, 4);
  blendMode(SCREEN);

  for (float angle = 0; angle < 2*PI; angle += .1) {
    x = cos(angle + (xpos * 10)) * yposRadius;
    y = sin(angle) * yposRadius;
    point(x, y);
  }
}

void serialEvent( Serial myport) {

  String s = myPort.readStringUntil( '\n' );
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
    lightValue = float(stringArray[2]);

    println("Potentiometer: " + xpos);
    println("Potentiometer-2: " + ypos);
    println("Light Meter" + yposRadius);
  }
}

