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

  println(superVal);
}

void buttonSwitch() {
  if (button != 1) {   
    //background(255);
    superVal = random(100);
    superVal = round(superVal);
    if (superVal > 50) {
      colorVal = random(254);
      strokeW = random(5, 100);
    } 
    if (superVal < 50) {
      colorVal = random(254);
      strokeW = random(5, 100);
    } 
    if (superVal < 2) {
      colorVal = 255;
      background(0, 0, 200);
    } else { background(255);}
    if (superVal < 2) {
    }

    if (superVal > 100) superVal = 0;
  }
}

void etch() {
  strokeWeight(2);
  stroke(colorVal, 0, 0);
  //rect(xpos, ypos, 2, 2);
  xpos = round(xpos);
  ypos = round(ypos);
  x = xpos;
  y = ypos;
  point(x, y);
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

    xpos = (xpos*(picWidth / 255.0)) + x_offset;
    ypos = (ypos*(picHeight / 255.0)) + y_offset;

    //newImage(picNum);

    //println("x position: " + xpos);
    //println("y position: " + ypos);
    //println("BUTTON YO! : " + button);
  }
}

