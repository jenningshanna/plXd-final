import processing.serial.*;

Serial myPort;
int val;     
float xpos = 0;
float ypos = 0;

PImage img, img2;

int picNum = 1;

int x_offset;
int picWidth;
int y_offset;
int picHeight;


void setup() 
{
  size(1000, 775);
  smooth();

   //println (Serial.list());
   myPort = new Serial(this, Serial.list()[0], 9600);
   background(255); 
   xpos = -50;
   ypos = -50;
   
     img = loadImage("Polaroid_Frame.jpg");
     img2 = loadImage("Film_Frame.jpg");
     newImage(1);
     
     //init our screen size variables
  x_offset = 0;
  picWidth = width;
  y_offset = 0;
  picHeight = height;
  
}

void draw()
{
    
     fill(255,0,0);
     stroke(255,0,0);
     rect(xpos, ypos, 20,20);
    



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
      picNum = int(stringArray[2]);

      
      
      xpos = (xpos*(picWidth / 255.0)) + x_offset;
      
      ypos = (ypos*(picHeight / 255.0)) + y_offset;
      
     newImage(picNum);
      
      println("x position: " + xpos);
      println("y position: " + ypos);
      println("picNumber: " + picNum);
  }
}



void newImage(int whichImage)
{
  switch(whichImage)
 { 
   
     case 1: background(0,0,255);
    x_offset = 0;
    picWidth = width;
    y_offset = 0;
    picHeight = height;
      break;
      
    case 2: image(img, 0, 0, width, height);
    //x_offset = ?;
    //picWidth = ?;
    //y_offset = ?;
    //picHeight = ?;
     break;
    
    case 3: image(img2, 0, 0, width, height);
     //x_offset = ?;
    //picWidth = ?;
    //y_offset = ?;
    //picHeight = ?;
      break;
    
  

 }
}

