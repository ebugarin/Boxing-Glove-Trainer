#include <Wire.h>
#include <Adafruit_MPU6050.h>

Adafruit_MPU6050 mpu;

void setup() {
  Wire.begin();
  Serial.begin(115200);

  // initialize MPU6050
  while (!mpu.begin()) {
    Serial.println("Failed to find MPU6050");
    delay(1000);
  }
  mpu.setAccelerometerRange(MPU6050_RANGE_2_G);
  mpu.setGyroRange(MPU6050_RANGE_250_DEG);
  mpu.setFilterBandwidth(MPU6050_BAND_44_HZ);

  // allow time for sensor to stabilize
  delay(1000);
}

void loop() {
  // read sensor data
  sensors_event_t accelEvent, gyroEvent, t;
  mpu.getEvent(&accelEvent, &gyroEvent, &t);

  // compute pitch and roll angles from accelerometer data
  float pitch = atan2(-accelEvent.acceleration.x, sqrt(accelEvent.acceleration.y * accelEvent.acceleration.y + accelEvent.acceleration.z * accelEvent.acceleration.z)) * RAD_TO_DEG;
  float roll = atan2(accelEvent.acceleration.y, accelEvent.acceleration.z) * RAD_TO_DEG;
  Serial.println(pitch);

  // determine direction of movement
  if (pitch > 30) {
    Serial.println("Sensor moved up");
  } else if (pitch < -30) {
    Serial.println("Sensor moved down");
  } else if (roll > 30) {
    Serial.println("Sensor moved right");
  } else if (roll < -30) {
    Serial.println("Sensor moved left");
  }

  // wait for next measurement
  delay(100);
}
