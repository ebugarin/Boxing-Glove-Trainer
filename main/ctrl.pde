void keyPressed() {
  switch (key) {
    case 'm':
      tab = "menu";
      break;
      
    case 'l':
      tab = "force";
      break;
      
    case 'c':
      tab = "cardio";
      break;
      
    case 'p':
      tab = "speed";
      break;
      
    case 'r':
      // Reset everything
      counter = 0;
      timer = 30.0;
      accel_x = 0.0;
      accel_y = 0.0;
      loop(); // Start the animation again
  
      
  }
}
