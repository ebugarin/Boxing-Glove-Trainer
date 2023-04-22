// Pulse oximeter documentation: https://learn.sparkfun.com/tutorials/sparkfun-pulse-oximeter-and-heart-rate-monitor-hookup-guide#reference-tables-and-sensor-settings
#include <SparkFun_Bio_Sensor_Hub_Library.h>
#include <Wire.h>

// No other Address options.
#define DEF_ADDR 0x55
#include "SevSeg.h"
#include <TimerOne.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>

Adafruit_MPU6050 mpu;
SevSeg sevseg;
int palm; // Palm FSR val

// Reset pin, MFIO pin
const int resPin = 4;
const int mfioPin = 5;

// Takes address, reset pin, and MFIO pin.
SparkFun_Bio_Sensor_Hub bioHub(resPin, mfioPin); 

bioData body;  

void setup(){

  // Timer1.initialize(500); 
  // Timer1.attachInterrupt( readPulse ); 
  Serial.begin(115200);
  pinMode(A4, INPUT); // Palm


  Wire.begin();
  int result = bioHub.begin();
  if (!result){}
    //Serial.println("Sensor started!");
  else
    Serial.println("Could not communicate with the sensor!!!");

  //Serial.println("Configuring Sensor...."); 
  int error = bioHub.configBpm(MODE_ONE); // Configuring just the BPM settings. 
  if(!error){
    //Serial.println("Sensor configured.");
  }
  else {
    Serial.println("Error configuring sensor.");
    Serial.print("Error: "); 
    Serial.println(error); 
  }
  // Try to initialize!
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  //Serial.println("MPU6050 Found!");

  //setupt motion detection
  // mpu.setHighPassFilter(MPU6050_HIGHPASS_0_63_HZ);
  // mpu.setMotionDetectionThreshold(1);
  // mpu.setMotionDetectionDuration(20);
  // mpu.setInterruptPinLatch(true);	// Keep it latched.  Will turn off when reinitialized.
  // mpu.setInterruptPinPolarity(true);
  // mpu.setMotionInterrupt(true);

  mpu.setAccelerometerRange(MPU6050_RANGE_16_G);
  // Serial.print("Accelerometer range set to: ");
  // switch (mpu.getAccelerometerRange()) {
  // case MPU6050_RANGE_2_G:
  //   Serial.println("+-2G");
  //   break;
  // case MPU6050_RANGE_4_G:
  //   Serial.println("+-4G");
  //   break;
  // case MPU6050_RANGE_8_G:
  //   Serial.println("+-8G");
  //   break;
  // case MPU6050_RANGE_16_G:
  //   Serial.println("+-16G");
  //   break;
  // }
  mpu.setGyroRange(MPU6050_RANGE_500_DEG);
  // Serial.print("Gyro range set to: ");
  // switch (mpu.getGyroRange()) {
  // case MPU6050_RANGE_250_DEG:
  //   Serial.println("+- 250 deg/s");
  //   break;
  // case MPU6050_RANGE_500_DEG:
  //   Serial.println("+- 500 deg/s");
  //   break;
  // case MPU6050_RANGE_1000_DEG:
  //   Serial.println("+- 1000 deg/s");
  //   break;
  // case MPU6050_RANGE_2000_DEG:
  //   Serial.println("+- 2000 deg/s");
  //   break;
  // }

  mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
  //Serial.print("Filter bandwidth set to: ");
  // switch (mpu.getFilterBandwidth()) {
  // case MPU6050_BAND_260_HZ:
  //   Serial.println("260 Hz");
  //   break;
  // case MPU6050_BAND_184_HZ:
  //   Serial.println("184 Hz");
  //   break;
  // case MPU6050_BAND_94_HZ:
  //   Serial.println("94 Hz");
  //   break;
  // case MPU6050_BAND_44_HZ:
  //   Serial.println("44 Hz");
  //   break;
  // case MPU6050_BAND_21_HZ:
  //   Serial.println("21 Hz");
  //   break;
  // case MPU6050_BAND_10_HZ:
  //   Serial.println("10 Hz");
  //   break;
  // case MPU6050_BAND_5_HZ:
  //   Serial.println("5 Hz");
  //   break;
  // }

  // Data lags a bit behind the sensor, if you're finger is on the sensor when
  // it's being configured this delay will give some time for the data to catch
  // up. 
  delay(100); 

}

void loop(){
  // [0] = FSR, [1] = X acceleration, [2] =  Y acceleration, [3] =  Z acceleration, [4] = Gyro X, [5] = Gyro Y, [6] = Gyro Z, [7] = Heart Rate, [8] = status
    //original analog read is always reading 713 so using map(<value>, <original_min>, <original_max>, <new_min>, <new_max>);
    palm = map(analogRead(A4), 712, 950, 0,1000); // [0] = FSR

    Serial.print(palm);
    Serial.print(",");


    //if(mpu.getMotionInterruptStatus()) {
    /* Get new sensor events with the readings */
    sensors_event_t a, g, temp;
    mpu.getEvent(&a, &g, &temp);

    Serial.print(a.acceleration.x); // [1] = X acceleration
    Serial.print(",");

    Serial.print(a.acceleration.y); // [2] =  Y acceleration
    Serial.print(",");

    Serial.print(a.acceleration.z); // [3] =  Z acceleration
    Serial.print(",");
    // if(abs(a.acceleration.x) + abs(a.acceleration.y) >= 15) {

    //   Serial.println("");

    //   Serial.println("SIDEWAYS");
    //       Serial.println("");



          
    // }

    // if(a.acceleration.z < 8 && abs(a.acceleration.x) >= 20) {
    //       Serial.println("");

    //   Serial.println("STRAIGHT");
    //       Serial.println("");

    // }
    
    // if(a.acceleration.z  >= 17) {
    //       Serial.println("");

    //   Serial.println("UPPER");
    //       Serial.println("");

    // }

    Serial.print(g.gyro.x); // [4] = Gyro X
    Serial.print(",");

    Serial.print(g.gyro.y); // [5] = Gyro Y
    Serial.print(",");

    Serial.print(g.gyro.z); // [6] = Gyro Z
    Serial.print(",");
  //}


    // Information from the readBpm function will be saved to our "body"
    // variable.  
    body = bioHub.readBpm();

    Serial.print(body.heartRate); // [7] = Heart Rate
    Serial.print(",");

    Serial.print(body.status); // [8] = status
    Serial.print(",");
    
    /* reference table for body.status
    Status Number	Description
    0	No Object Detected
    1	Object Detected
    2	Object Other Than Finger Detected
    3	Finger Detected */

    // Serial.print(body.confidence); 
    // Serial.print(",");

    // Serial.print(body.oxygen); 
    // Serial.print(",");

  
    // Serial.print(body.extStatus); 
    // Serial.print(",");

    /* reference table for body.exStatus
    Status Number	Description
    0	Success
    1	Not Ready
    -1	Object Detected
    -2	Excessive Sensor Device Motion
    -3	No object detected
    -4	Pressing too hard
    -5	Object other than finger detected
    -6	Excessive finger motion */


    Serial.println("");
    
    delay(150); // Slowing it down, we don't need to break our necks here.
}
