import processing.serial.*;

Serial myPort;
int button;
int val;
float colorVal;
float strokeW;
float superVal;

float angle;
float radiusCircle = 500;
float yposRadius = 0;

float xpos = 0;
float ypos = 0;
float x, y;

PImage img, img2;

int picNum = 1;

int x_offset;
int picWidth;
int y_offset;
int picHeight;


void setup() 
{
  size(500, 600);
  smooth();

  //println (Serial.list());
  myPort = new Serial(this, Serial.list()[4], 9600);
  myPort.buffer(50);
  background(255); 
  xpos = -50; //move "cursor" off the screen until user turns knobs
  ypos = -50;

  //initialize screen size variables
  x_offset = 0;
  picWidth = width;
  y_offset = 0;
  picHeight = height;
}

void draw()
{ 
  //waves();
  //etch();
  //buttonSwitch();
  if (button != 1) {   
    background(255);
    superVal = 3;
    superVal = random(100);
    superVal = round(superVal);
    if (superVal < 10 && superVal > 2) {
      colorVal = random(254);
      strokeW = random(5, 100);
    } 
    if (superVal < 20 && superVal > 10) {
      colorVal = random(254);
      strokeW = random(5, 100);
    } 
    if (superVal <= 30 && superVal >= 20) {
      colorVal = 0;
      strokeW = 7;
    }
    if (superVal < 40 && superVal > 30) {
      colorVal = 100;
      strokeW = 10;
    }
    if (superVal < 50 && superVal > 40) {
      colorVal = 50;
      strokeW = 13;
    }
    if (superVal < 60 && superVal > 50) {
      colorVal = 75;
      strokeW = 15;
    }
    if (superVal < 70 && superVal > 60) {
      colorVal = 150;
      strokeW = 18;
    }
    if (superVal < 80 && superVal > 70) {
      colorVal = 16;
      strokeW = 21;
    }
    if (superVal < 90 && superVal > 80) {
      colorVal = 200;
      strokeW = 24;
    }
    if (superVal < 100 && superVal > 90) {
      colorVal = 230;
      strokeW = 36;
    }
    if (superVal < 2) {
      fill(255, 0, 0);
      text("system faliure", 15, 60);
      colorVal = 255;
      background(0, 0, 200);
    }

    if (superVal > 100) superVal = 0;
  }

  if (superVal > 33 && superVal < 65) etch();
  if (superVal > 66 && superVal < 100) stars();
  if (superVal > 0 && superVal < 32) wheels();

  println("yo holms, your super value is:" + superVal);
}

void buttonSwitch() {
}

void etch() {
  strokeWeight(strokeW);
  //stroke(colorVal, colorVal, colorVal);
  stroke(random(0, colorVal), random(colorVal), random(colorVal));
  //rect(xpos, ypos, 2, 2);
  xpos = round(xpos);
  ypos = round(ypos);
  x = xpos;
  y = ypos;
  point(x, y);
}

void wheels() {
  stroke(random(0, 255), random(255), random(255));
  //stroke(255);
  strokeWeight(5);
  translate(width/2, height/2);
  for (angle = 0; angle < 3*PI; angle += .1) {
    x = cos(angle + xpos) * radiusCircle;
    y = sin(angle + ypos) * radiusCircle;
    point(x, y);
  }
}

void stars() {
  // Draw a circle with points
  //background(0);
  stroke(random(0, 255), random(255), random(255));
  //stroke(255);
  strokeWeight(1.5);
  translate(width/2, height/2);
  yposRadius = map(ypos, 0, 255, 0.0, 600.0);
  //xpos = map(xpos, 0, 255, 0., 4.);
  //poteValue = map(poteValue, 0, 255, 0, 4);
  blendMode(SCREEN);

  for (float angle = 0; angle < 2*PI; angle += .1) {
    x = cos(angle + (xpos * 10)) * yposRadius;
    y = sin(angle) * yposRadius;
    point(x, y);
  }
}

//void waves() {
//  background(200);
//  float a = 0.0;
//  for (int i = 0; i < 25; i++) {
//    fill(random(200, 250), random(200, 250), random(200, 250));
//    line(i*16, (height/2), i*16, (height/2)+cos(a)*120.0);
//    a = a + 283; // 283, 47, 95, 23, 190, 307, 73, 45, 25
//  }
//}

void serialEvent( Serial serial) {

  String s = myPort.readStringUntil( '\n' );
  if ( s == null ) {
  } 
  else {
    s = trim(s);
    String stringArray[] = split(s, ',');
    xpos = int(stringArray[0]);
    ypos = int(stringArray[1]);
    button = int(stringArray[2]);

    xpos = (xpos*(picWidth / 255.0)) + x_offset;
    ypos = (ypos*(picHeight / 255.0)) + y_offset;

    //newImage(picNum);

    //println("x position: " + xpos);
    //println("y position: " + ypos);
    //println("BUTTON YO! : " + button);
  }
}

