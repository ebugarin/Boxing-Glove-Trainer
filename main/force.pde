float[] forces = {0.0, 0.0, 0.0}; // Array to store the top 3 high scores
float curForce = 0.0;
void force_draw() {
  delay(100);
  PImage img;
  img = loadImage("img2.png");
  background(img);
  textSize(32);  // Set the text size to 32
  textAlign(CENTER, CENTER);  // Set the text alignment to center
  fill(173, 216, 230);  // Set the text color to blue
  curForce = abs(accel_x) + abs(accel_y) * (abs(gyro_x) + abs(gyro_y) + abs(gyro_z));
  text("Force: " + curForce , width/2, height/2);  // Display the data in the center of the screen  
  
      // Check if the current score is higher than any of the top 3 high scores
    if (curForce > forces[0]) {
      forces[2] = forces[1];
      forces[1] = forces[0];
      forces[0] = curForce;
    } else if (curForce > forces[1]) {
      forces[2] = forces[1];
      forces[1] = curForce;
    } else if (curForce > forces[2]) {
      forces[2] = curForce;
    }
    
    // Display the top 3 high scores
    textSize(20);
    text("High Scores:", width/2, height/2 + 100);
    text("1. " + forces[0], width/2, height/2 + 120);
    text("2. " + forces[1], width/2, height/2 + 140);
    text("3. " + forces[2], width/2, height/2 + 160);

}
