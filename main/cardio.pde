float[] HRdata = new float[50];  // Array to store heart rate data
int graphWidth = 200;  // Width of the graph in pixels
int graphHeight = 100;  // Height of the graph in pixels
int circleSize = 20;
color circleColor = color(255, 0, 0); // initial color is red
int circleX = 100;
int circleY = 100;

void draw_FSR() {
  //background(255);
  
  // Check if FSR is greater than 100
  if (FSR > 100) {
    circleColor = color(0, 255, 0); // Change color to green
  } else {
    circleColor = color(255, 0, 0); // initial color is red
  }
  
  // Draw the circle
  fill(circleColor);
  ellipse(circleX, circleY, circleSize, circleSize);
}

void cardio_draw() {
  PImage img;
  img = loadImage("img3.png");
  background(img);
  //textSize(32);  // Set the text size to 32
  textAlign(CENTER, CENTER);  // Set the text alignment to center
  fill(255, 0, 0);  // Set the text color to red
  text(accel_x, width/2, height/2);  // Display the data in the center of the screen
  
  
  stroke(255, 0, 0);  // Set the color of the graph to red
  strokeWeight(2);  // Set the thickness of the graph line
  textSize(12);  // Set the font size for the axis labels

  updateHRdata(HR);  // Update the heart rate data with the new value
  draw_FSR();
  drawGraph();  // Draw the heart rate graph
}

void updateHRdata(float HRvalue) {
  // Shift the heart rate data to the left
  for (int i = 0; i < HRdata.length - 1; i++) {
    HRdata[i] = HRdata[i+1];
  }
  // Add the new heart rate value to the right side of the array
  HRdata[HRdata.length-1] = HRvalue;
}

void drawGraph() {
  // Draw the graph axes
  line(50, height-50, 50+graphWidth, height-50);  // X-axis
  line(50, height-50-graphHeight, 50, height-50+20*8);  // Y-axis
  // Draw tick marks and labels on X-axis
  for (int i = 0; i <= 3; i++) {
    float x = map(i, 0, 3, 50, 50+graphWidth);
    line(x, height-45, x, height-55);  // Tick mark
    textAlign(CENTER, TOP);
    text(i, x, height-35);  // Label
  }
  // Draw tick marks and labels on Y-axis
  for (int i = 0; i <= 10; i++) {
    float y = map(i*20, 0, 200, height-50, height-50-graphHeight);
    line(45, y, 55, y);  // Tick mark
    textAlign(RIGHT, CENTER);
    text(i*20, 40, y);  // Label
  }
  // Draw the graph line
  for (int i = 0; i < HRdata.length - 1; i++) {
    float x1 = map(i, 0, HRdata.length-1, 50, 50+graphWidth);
    float y1 = map(HRdata[i], 0, 200, height-50, height-50-graphHeight);
    float x2 = map(i+1, 0, HRdata.length-1, 50, 50+graphWidth);
    float y2 = map(HRdata[i+1], 0, 200, height-50, height-50-graphHeight);
    line(x1, y1, x2, y2);
  }
  // Draw axis labels

  // Draw axis labels
  textAlign(CENTER, TOP);
  text("Minutes", width/2 - 200, height-30);  // X-axis label
  textAlign(RIGHT, CENTER);
  text("HR", 20, height-100);  // Y-axis label
  textAlign(RIGHT, CENTER);
  text("0", 40, height-50);  // Y-axis label
  textAlign(RIGHT, CENTER);

}
