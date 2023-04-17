void force_draw() {
  PImage img;
  img = loadImage("img2.png");
  background(img);
  textSize(32);  // Set the text size to 32
  textAlign(CENTER, CENTER);  // Set the text alignment to center
  fill(173, 216, 230);  // Set the text color to blue
  text("Force: " + accel_x, width/2, height/2);  // Display the data in the center of the screen  
}
