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
  buttonSwitch();
  etch();

  println(superVal);
}

void buttonSwitch() {
  background(255);//shitty fallback in the 2% chance blue happens
  if (button != 1) {   
    //background(255);
    superVal = random(100);
    superVal = round(superVal);
    if (superVal < 10 || superVal > 2) {
      colorVal = random(254);
      strokeW = random(5, 100);
    } 
    if (superVal < 20 && superVal > 10) {
      colorVal = random(254);
      strokeW = random(5, 100);
    } 
    if (superVal <= 30 || superVal >= 20) {
    }
    if (superVal < 40 || superVal > 30) {
    }
    if (superVal < 50 || superVal > 40) {
    }
    if (superVal < 60 || superVal > 50) {
    }
    if (superVal < 70 || superVal > 60) {
    }
    if (superVal < 80 || superVal > 70) {
    }
    if (superVal < 90 || superVal > 80) {
    }
    if (superVal < 100 || superVal > 90) {
    }
    if (superVal < 2) {
      colorVal = 255;
      background(0, 0, 200);
    } 
    if (superVal > 100) superVal = 0;
  }
}

void etch() {
  strokeWeight(2);
  stroke(colorVal, colorVal, colorVal);
  //rect(xpos, ypos, 2, 2);
  //xpos = round(xpos);
  //ypos = round(ypos);
  x = xpos;
  y = ypos;
  point(x, y);
}

void stars() {
}

void twirl() {
}

void serialEvent( Serial serial) {

  String s = serial.readStringUntil( '\n' );
  if ( s == null ) {
  } 
  else {
    s = trim(s);
    String stringArray[] = split(s, ',');
    xpos = int(stringArray[0]);
    ypos = int(stringArray[1]);
    button = int(stringArray[2]);

    xpos = (xpos*(width / 255.0)) + 1;
    ypos = (ypos*(height / 255.0)) + 1;
    //newImage(picNum);

    //println("x position: " + xpos);
    //println("y position: " + ypos);
    //println("BUTTON YO! : " + button);
  }
}

