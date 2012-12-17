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

void  wheels() {
    stroke(random(0, colorVal), random(colorVal), random(colorVal));
    //stroke(255);
    strokeWeight(strokeW);
    translate(width/2, height/2);
    for (float angle = 0; angle < 2*PI; angle += .1) {
      x = cos(angle + xpos) * radiusCircle;
      y = sin(angle + ypos) * radiusCircle;
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

