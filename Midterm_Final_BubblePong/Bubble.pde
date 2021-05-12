class Bubble {
  float x;
  float y;
  //float diameter;
  float yspeed;
float xpos;
  
  Bubble(float tempD) {
    x = random(width);
    y = height;
  xpos = tempD;
    yspeed = random(0,1);
   
  }
  
  void ascend() {
    y -= yspeed;
    x = x + random(1);
}

void display() {
  stroke(5);
  fill(127, 100);
  rect(x, y, xpos, 15);
}

void top() { 
  if (y <= -xpos/2) {
  
  y = height+xpos/2;
}
}
}
 
