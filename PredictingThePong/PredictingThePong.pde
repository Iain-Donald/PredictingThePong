
int ballRadius = 20;

float ballX = 500;
float ballY = 200;

float ballXSpeed, ballYSpeed;
float gravity = 0.1634;
float energyMult = 1.1;
float takeEnergyMult = 0.95;

color green, red, white;

int difficulty = 15;

int paddleX = 0;
color paddleColor;

int score = 0;
int frameCounter = 0;

boolean selectPosition = false;
boolean gameStart = true;
boolean gameOver = false;

PFont font;

void setup(){
  size(1000, 1000, P3D);
  background(100);
  frameRate(60);
  font = createFont("Consolas", 24);
  
  green = color(0, 254, 0);
  red = color(254, 0, 0);
  white = color(254, 254, 254);
  paddleColor = color(20, 200, 25);
  
  ballXSpeed = random(-difficulty, difficulty);
  ballYSpeed = random(1, difficulty/2);
  String[] fontList = PFont.list();
printArray(fontList);
}

void draw(){
  background(254);
  lights();
  textFont(font);
  textSize(24);
  
  if(selectPosition){
    frameCounter ++;
    // player paddle
    paddleColor = color(20, 200, 25);
    fill(paddleColor);
    rect(paddleX, 900, 150, 20);
    if(mousePressed){
      paddleX = mouseX - 75;
    }
    if(frameCounter > 120) {
      selectPosition = false;
      frameCounter = 0;
    }
    text("CLICK TO MOVE PADDLE", 12, 72);
  } else {
    paddleColor = color(254, 0, 0);
      if(ballY > 900 - (ballRadius * 1.5) && ballY < 950){
        gameStart = false;
        if(ballX < paddleX + 150 && ballX > paddleX){
          iainsGradient(0, 0, 1000, 1000, white, green, false); // gradient on point
          selectPosition = true;
          score ++;
          print("\nEnergy: ");
          if(ballYSpeed < difficulty * 1.3) {
            print("add");
            ballYSpeed *= energyMult;
          } else {
            print("take");
            ballYSpeed *= takeEnergyMult;
          }
          ballYSpeed = -ballYSpeed;
        } else {
          gameOver = true;
        }
      } else if (ballY < 0 + ballRadius){
      ballYSpeed = -ballYSpeed;
    }
  
    if(ballX > 1000 - ballRadius || ballX < 0 + ballRadius){
      ballXSpeed = -ballXSpeed;
    }
    ballYSpeed += gravity;
    ballX += ballXSpeed;
    ballY += ballYSpeed;
    if(gameStart) {
      paddleX = mouseX - 75;
      paddleColor = color(20, 200, 25);
    }
    
    if(gameOver) {
      iainsGradient(0, 0, 1000, 1000, white, red, false);
      fill(254, 0, 0);
      text("GAME OVER", 12, 72);
      text("PRESS 'R' TO RESTART", 12, 108);
    }
    
    // player paddle
    fill(paddleColor);
    rect(paddleX, 900, 150, 20);
  }
  
  // gradient on loss
  
  //print("\nG: " + gravity + "  ballYSpeed: " + ballYSpeed);
  
  fill(0);
  text("Score: " + str(score), 12, 36);
  
  stroke(0);
  line(0, 42, 1000, 42);
  noStroke();
  
  translate(ballX, ballY, 0);
  fill(20, 200, 200);
  sphere(ballRadius);
  
  if(keyPressed){
      if(key == 'r'){
         ballY = 200;
         ballYSpeed = random(1, difficulty/2);
         ballX = 500;
         ballXSpeed = random(-difficulty, difficulty);
         score = 0;
         gameStart = true;
         gameOver = false;
      }
  }
}


void iainsGradient(int x, int y, int w, int h, color c1, color c2, boolean axis){
  noFill();
  color currentColor = c1;
  if (axis){ // x axis
    for(int i = x; i < x + w; i++){
      currentColor = lerpColor(c1, c2, /*(((100.0/float(w))/100.0) * i) - 1)*/map(i, x, x + w, 0, 1));
      stroke(currentColor, 0.5);
      line(i, y, i, y + h);
    }
  } else { // y axis
    for(int i = y; i < y + h; i++){
      currentColor = lerpColor(c1, c2, map(i, y, y + h, 0, 1));
      stroke(currentColor, 100);
      line(x, i, x + w, i);
    }
  }
}
