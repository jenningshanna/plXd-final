/* 
Etch and Sketch with potentiometers
Background options for screen display to change up experience
 */

const int x_pot = A0;
const int y_pot = A1;

boolean lastButton = LOW;
boolean currentButton = LOW;

int x_val;
int y_val;
int previous_x, previous_y;

boolean buttonPin = 12;
int buttonState;
int previousState;
int buttonCounter = 1;
int numPics = 3; //max number of pic

//Tilt Switch
int tilt_s1 = 2;
int tilt_s2 = 3;

void setup(){
  
  Serial.begin(9600);
  
  pinMode(buttonPin, INPUT_PULLUP);
  
}

void loop(){
  
  ////READ IN X POT
  x_val = 0;//initalize value variable
  //for(int i = 0; i < 3; i++)
  //{
    x_val += analogRead(x_pot);
  //}
  //x_val = x_val / 3;
  Serial.print(x_val / 4); // the sensor val
  Serial.print(',');
  
  //READ IN Y POT 
  y_val = 0;//reinitalize val variable
  for(int i = 0; i < 3; i++)
  {
    y_val += analogRead(y_pot);
  }
  y_val = y_val / 3;
  Serial.print(y_val / 4); 
  Serial.print(',');

//READ IN BUTTON 1

  currentButton = debounce(lastButton == LOW);
  
  if (lastButton == LOW && currentButton == HIGH)
   {
     lastButton = currentButton;
   }


//read button pin (0 if pressed, 1 if not pressed)(remember we are using pullup resistor)
  
  Serial.print(currentButton);
//  if(buttonState == 0 && previousState == 1)//if we are now 'ON' and were just 'OFF'
//  {
//    buttonCounter++; //increment button counter
//    if(buttonCounter > numPics)// check to see if we have not incremented past the max number of pics
//    {
//     buttonCounter = 1; //reset to button counter if we have maxed out number of pics
//    }
//    Serial.print(buttonCounter); //print the button counter to the serial string
//    previousState = 0; //make previous buttonstate = to current button state
//  }
//  else Serial.print(0);//if we haven't pressed the button, send a 0 to the serial string
  
  Serial.print(',');//add a comma

  if(buttonState == 1 && previousState == 0)//reset button state when we release the button
  {
    previousState = 1;
  }
  
  Serial.print('\n');//denote the end of the serial string

  delay(30);
}

boolean debounce(boolean last)
{
  boolean current = digitalRead(buttonPin);
  if (last != current)
  {
    delay(5);
    current = digitalRead(buttonPin);
  }
  return current;
}

