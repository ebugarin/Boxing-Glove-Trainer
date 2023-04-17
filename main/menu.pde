
void menu_draw() {
  pushStyle();
  PImage img;
  img = loadImage("DALL·E 2023-04-16 22.52.30 - A boxing ring.png");
  background(img);
  fill(255, 0, 0);
  textSize(35);
  font = createFont("Helvetica_Roman.ttf", 128);
  
  textFont(font, 80);
  textAlign(CENTER, CENTER);
  text("Boxing Training", width/2, 200);
  
  textAlign(LEFT, LEFT);
  textFont(font, 30);
  text("Press 'l' for Force Calculator", 110, 400);
  text("Press 'c' for Cardio Training", 110, 440);

  popStyle();
}
