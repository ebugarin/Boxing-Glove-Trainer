import processing.serial.*;
import org.gicentre.utils.stat.*;

Serial myPort;

String tab = "menu";

int FSR;

float accel_x;
float accel_y;
float accel_z;

float gyro_x;
float gyro_y;
float gyro_z;

int HR;
int status;

PFont font;

String portname = "/dev/cu.usbmodem123456781";
//String portname = "com3";

void setup() {
  //String portName = Serial.list()[0];
  //println(portName);
  
  myPort = new Serial(this, portname, 115200);
  myPort.bufferUntil('\n');
  
  size(1024, 1024); // has to be same size of the images
  font = createFont("Helvetica_Roman.ttf", 128);
  
}

void draw() {
  if (tab == "menu")
    menu_draw();
  else if (tab == "force")
    force_draw();
  else if (tab == "cardio")
    cardio_draw();
  else if (tab == "speed")
    speed();

}

void serialEvent(Serial myPort) {
  String tempVal = myPort.readStringUntil('\n');
  String res[] = tempVal.split(",");
  // [0] = FSR, [1] = X acceleration, [2] =  Y acceleration, [3] =  Z acceleration, [4] = Gyro X, [5] = Gyro Y, [6] = Gyro Z, [7] = Heart Rate, [8] = status

  
  if (res[0] != null) {
    FSR = int(res[0]);
    
    accel_x = int(res[1]);
    accel_y = int(res[2]);
    accel_z = int(res[3]);
    
    gyro_x = int(res[4]);
    gyro_y = int(res[5]);
    gyro_z = int(res[6]);
    
    HR = int(res[7]);
    status = int(res[8]);

    print(FSR + ", \t");
    print(accel_x + ", " + accel_y + ", " + accel_z + "  \t");
    print(gyro_x + ", " + gyro_y + ", " + gyro_z + ", \t");
    print(HR + ", " + status + "\n");
    
    /* reference table for body.status
    Status Number  Description
    0  No Object Detected
    1  Object Detected
    2  Object Other Than Finger Detected
    3  Finger Detected */

  }  
}
