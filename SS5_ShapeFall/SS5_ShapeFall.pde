/* Zarina Barsh */


Quad[] quads = new Quad[1000];

float r= 0;
float g= 0;
float b= 0;
void setup() {
size(1200, 720);
for (int i = 0; i < quads.length ; i++) {
quads[i] = new Quad(color(i*3), 0, i*2, i/2);
}

}
void draw() {
background(255);
for (int i = 0; i < quads.length; i++) {
quads[i].move();
quads[i].display();

}
}
class Quad {
color c;
float xpos;
float ypos;
float xspeed;

Quad(color c_, float xpos_, float ypos_, float xspeed_) {
c = c_;
xpos = xpos_;
ypos = ypos_;
xspeed = xspeed_;

}
void display() {
rectMode(CENTER);
stroke(0);
fill(c);
rect(xpos, ypos, 20, 10);
}
void move() {
   xpos = xpos + xspeed;
ypos = ypos + xspeed;
//ypos = ypos + xspeed;

if (xpos > width || ypos < .25) {
  
xspeed = -xspeed;
}

ypos = ypos - xspeed;

  if (ypos > height || xpos < 1) {
    xspeed = -xspeed;

  }
}
}
