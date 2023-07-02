
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

int score = 0;

void setup(){
  size(1000, 1000, P3D);
  background(100);
  frameRate(60);
  
  green = color(0, 254, 0);
  red = color(254, 0, 0);
  white = color(254, 254, 254);
  
  ballXSpeed = random(-difficulty, difficulty);
  ballYSpeed = random(1, difficulty/2);
}

void draw(){
  background(254);
  noStroke();
  lights();
  
  // player paddle
  paddleX = mouseX - 50;
  fill(0);
  rect(paddleX, 900, 100, 20);
  
  // gradient on loss
  if(ballY > 900){
    if(ballY > 900 - ballRadius){
      if(ballX < mouseX + 50 && ballX > mouseX - 50){
        iainsGradient(0, 0, 1000, 1000, white, green, false); // gradient on point
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
        iainsGradient(0, 0, 1000, 1000, white, red, false);
        score = 0;
      }
    }
  } else if (ballY < 0 + ballRadius){
    ballYSpeed = -ballYSpeed;
  }
  
  if(ballX > 1000 - ballRadius || ballX < 0 + ballRadius){
    ballXSpeed = -ballXSpeed;
  }
  //print("\nG: " + gravity + "  ballYSpeed: " + ballYSpeed);
  
  fill(0);
  textSize(64);
  text("Score: " + str(score), 40, 60);
  
  ballYSpeed += gravity;
 
  ballX += ballXSpeed;
  ballY += ballYSpeed;
  translate(ballX, ballY, 0);
  fill(200, 205, 0);
  sphere(ballRadius);
  
  if(keyPressed){
      if(key == 'w'){
         ballY = 500;
         ballYSpeed = random(1, difficulty/2);
         ballX = 500;
         ballXSpeed = random(-difficulty, difficulty);
         score = 0;
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
