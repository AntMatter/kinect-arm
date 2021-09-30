#include <Wire.h>
#include <Servo.h>

String x = "";


int servoPin = 10;
int servoPin2 = 11;

int shoulderi = 0;
int elbowi = 0;
Servo shoulder, elbow;  

void setup() {
  shoulder.attach(servoPin);
  elbow.attach(servoPin2);
   shoulder.write(90);
  elbow.write(90);
  delay(100);
  // Start the I2C Bus as Slave on address 9
  Wire.begin(9); 
  // Attach a function to trigger when something is received.
  Wire.onReceive(receiveEvent);



  
}
void receiveEvent(int bytes) {
 // x = Wire.read();    // read one character from the I2C
  shoulderi = (Wire.parseInt());
  elbowi = (Wire.parseInt());
  
}
void loop() {
  
  Wire.onReceive(receiveEvent);
  shoulder.write(shoulderi);
  elbow.write(elbowi);
  delay(100);
  
  
  
}
