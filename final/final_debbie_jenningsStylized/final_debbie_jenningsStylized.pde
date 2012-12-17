import processing.serial.*;

Serial myPort;
int button;
int val;
float colorVal;
float strokeW;
float superVal;
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

  //img = loadImage("Polaroid_Frame_72.png");
  //img2 = loadImage("Film_Frame_72.png");
  //newImage(1);

  //initialize screen size variables
  x_offset = 0;
  picWidth = width;
  y_offset = 0;
  picHeight = height;
}

void draw()
{ 
  etch();
  buttonSwitch();
  println("yo holms, your super value is:" + superVal);
}

void buttonSwitch() {
  if (button != 1) {   
    //background(255);
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
      fill(0, 102, 153);
      text("word", 15, 60);
      colorVal = 255;
      background(0, 0, 200);
    }

    if (superVal > 100) superVal = 0;
  }
}

void etch() {
  strokeWeight(strokeW);
  stroke(colorVal, colorVal, colorVal);
  //rect(xpos, ypos, 2, 2);
  xpos = round(xpos);
  ypos = round(ypos);
  x = xpos;
  y = ypos;
  point(x, y);
}

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

