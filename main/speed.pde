int counter = 0;
float timer = 30.0;
int[] highScores = {0, 0, 0}; // Array to store the top 3 high scores
    // if(a.acceleration.z  >= 17) {
    //       Serial.println("");

    //   Serial.println("UPPER");
    //       Serial.println("");

    // }
void draw_FSR2() {
  
  // Check if FSR is greater than 100
  if (FSR > 100) {
    circleColor = color(0, 255, 0); // Change color to green
  } else {
    circleColor = color(255, 0, 0); // initial color is red
  }
  text("Grip", width/2-440, height/2-280);  // Display the data in the center of the screen
  // Draw the circle
  fill(circleColor);
  ellipse(circleX, circleY, circleSize, circleSize);
}
void speed() {
  PImage img;
  img = loadImage("DALL·E 2023-04-16 22.51.16 - A boxing glove throwing a forceful punch.png");
  background(img);
  textAlign(CENTER);
  textSize(32);
  fill(0);
  
  if (timer > 0) {
    timer -= 1.0/frameRate;
  } else {
    // Timer has reached 0, clear the screen and display "Time's up"
    PImage img2;
    img2 = loadImage("trophy.png");
    background(img2);
    textAlign(CENTER);
    textSize(32);
    fill(255, 0, 0); // Red color for the text
    text("Time's up! -  Press 'r' to train again", width/2, height/2);
    noLoop(); // Stop the animation
    
        // Check if the current score is higher than any of the top 3 high scores
    if (counter > highScores[0]) {
      highScores[2] = highScores[1];
      highScores[1] = highScores[0];
      highScores[0] = counter;
    } else if (counter > highScores[1]) {
      highScores[2] = highScores[1];
      highScores[1] = counter;
    } else if (counter > highScores[2]) {
      highScores[2] = counter;
    }
    
    // Display the top 3 high scores
    textSize(20);
    text("High Scores:", width/2, height/2 + 100);
    text("1. " + highScores[0], width/2, height/2 + 120);
    text("2. " + highScores[1], width/2, height/2 + 140);
    text("3. " + highScores[2], width/2, height/2 + 160);
  }
  
  if(FSR > 100 ) { // proper grip
    if (abs(accel_x) + abs(accel_y) >= 15) {
      counter++;
      delay(100);
    }
  }
  draw_FSR2();
  text("Time: " + nf(timer, 0, 1), width/2, height/2 - 50);
  text("Counter: " + counter, width/2, height/2 + 50);
}

void speed_draw() {
  counter = 0;
  timer = 30.0;
  accel_x = 0.0;
  accel_y = 0.0;
  loop();
}
