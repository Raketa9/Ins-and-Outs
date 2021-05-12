/** Zarina Barsh. Midterm. "BubblePong" **/


/** game screen variations, air friction, gravity, racket phisics
was taken from the web site: https://www.toptal.com/game/ultimate-guide-to-processing-simple-game 
by  "Flappy Pong" OGUZ GELAL**/
/** checker board was taken from 
https: github.com/entertainmenttechnology/Corn-MTEC2280-Spring2021/edit/main/week4/challenge3_checkers/challenge3_checkers.pde **/
/** bubbles were take from Aray tutorial "Coding Train"**/
/********* VARIABLES *********/
// this integer is made to controll the 3 screen, with a global variable starting with 0 that stores the information of the active sceene
Bubble[] bubbles = new Bubble[50];
int scene = 0;

// checker board 
int grid = 8;
int squareSize;

// racket is a tetris shape element
PImage ishape;
float racketWidth = 100;
float racketHeight = 10;

// the bouncing ball

int ballX, ballY;
int diameter = 60; 

// global variables for fill
float r;
float g;
float b;

 /** two elements needed in order to have a realistic effect on the circle shape 
 code brought in from "flappy pong" mentioned above**/

/// gravity
float gravity = 0.1;
float ballSpeedVert = 0;
float ballSpeedHorizon = 10;
// air friction
float airfriction = 0.0001;
float friction = 0.1;



/********* SETUP BLOCK *********/

void setup() {
  size(640, 640);
   squareSize = width/grid;
   
    ballX=width/4;
    ballY=height/5;
    
 for(int i = 0; i < bubbles.length; i++) {
   
 bubbles[i] = new Bubble(i*4);
 }

//  for (int i = 0; i < bubbles.length; i++) {
 //   bubbles[i] = new Bubble(100+i*100, 300, random(320, 72));
//  }

}


/********* DRAW BLOCK *********/

void draw() {
 // if statement that checks the variable and displays the contents of the screen accordingly
  if (scene == 0) { // welcoming screen 
    startScreen();
  } else if (scene == 1) { // game screen
    scene();
  } else if (scene == 2) { // game over screen
    gameOverScreen();
  }
}


/********* SCREEN CONTENTS *********/

//screen 1
void startScreen() {
  //initialization of Cheker board
  for (int w = 0; w < width; w += squareSize) {
   for (int h = 0; h < height; h += squareSize) {
      if ((h+w) % 2 == 0) { // even count will be a random combination of red and blue colors with every click
        fill(r, b);
        stroke(20);
      } else { // odd square count will be a random color combination of green and blue
        fill(g, b);
        stroke(20);
      }
      rect(h, w, squareSize, squareSize); // draws the even squares
    }
  }
  // instructable Text to start the game and its placement
  textAlign(CENTER);
  fill(r,g,b, 250);
  textSize(60);
  stroke(30);
  text("Press ENTER to start", height/2, width/2);
}
/**** game  ****/
//Game screen 
// This method sets the necessary variables to start the game  
void startGame() {
  scene=1;
  
}
void scene() {
  // codes of game screen
  background(255);
  imageMode(CENTER); // centers the ishape and mouse cursos
  drawBubbles();
  drawBall();
  drawRacket();
  racketSurface();
  applyGravity();
  //applyHorizontalSpeed();
  keepInScreen();
  
}

void drawBubbles() {
for (int i = 0; i < bubbles.length; i++) {
    bubbles[i].ascend();
    bubbles[i].display();
    bubbles[i].top();
}
  
}



/********* INPUTS *********/

public void keyPressed() {
  // if we are on the initial screen when ENTER pressed, start the game
 
    if (keyCode == ENTER) {
    startGame();
  }
}

 // changes color of ball with click
void mousePressed() {
  r= random (255);
  g= random (255);
  b= random (255);
}



void drawBall() {
   fill(r,g,b);
  ellipse(ballX, ballY, diameter, diameter);
  
}

/**********GRAVITY ON THE BALL**********/
/** code taken from flappy pong**/
void applyGravity() {
  ballSpeedVert += gravity;
  ballY += ballSpeedVert;
  ballSpeedVert -= (ballSpeedVert * airfriction);
}
void makeBounceBottom(int surface) {
  ballY = surface -(diameter/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}
void makeBounceTop(int surface) {
  ballY = surface +(diameter/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}

void applyHorizontalSpeed(){
  ballX += ballSpeedHorizon;
  
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}

void makeBounceLeft(int surface){
  ballX = surface+(diameter/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
void makeBounceRight(int surface){
  ballX = surface-(diameter/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
// keep ball in the screen
void keepInScreen() {
  // ball hits floor
  if (ballY+(diameter/2) > height) { 
    makeBounceBottom(height);
  }
  // ball hits ceiling
  if (ballY-(diameter/2) < 0) {
    makeBounceTop(0);
  }
  if (ballX-(diameter/2) < 0){
    makeBounceLeft(0);
  }
  if (ballX+(diameter/2) > width){
    makeBounceRight(width);
  }
}

void drawRacket(){
  rectMode(CENTER);
  fill (r,g,b); // assigns color to ellipse
  rect(mouseX, mouseY, racketWidth, racketHeight);
}


void racketSurface() {
  float overhead = mouseY - pmouseY;
  if ((ballX+(diameter/2) > mouseX-(racketWidth/2)) && (ballX-(diameter/2) < mouseX+(racketWidth/2))) {
    if (dist(ballX, ballY, ballX, mouseY)<=(diameter/2)+abs(overhead)) {
      makeBounceBottom(mouseY);
      // racket moving up
      if (overhead<0) {
        ballY+=overhead;
        ballSpeedVert+=overhead;
      }
    }
  }
}


//screen 3
void gameOverScreen() {
  // codes for game over screen
   background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}
