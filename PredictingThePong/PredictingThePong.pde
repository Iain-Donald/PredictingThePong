// ball
int ballRadius = 20;
float ballX = 500;
float ballY = 200;
float ballXSpeed, ballYSpeed;

// physical properties
float gravity = 0.1634;
float energyMult = 1.1;
float takeEnergyMult = 0.95;

// general color
color green, red, white;

// difficulty
int difficulty = 15;

// paddle
int paddleX = 0;
color paddleColor;

// score
int score = 0;

// frame counter for time
int frameCounter = 0;

// game states
boolean selectPosition = false;
boolean gameStart = true;
boolean gameOver = false;

// font
PFont font;

void setup(){
  // basic properties
  size(1000, 1000, P3D);
  background(100);
  frameRate(60);
  font = createFont("Consolas", 24);
  
  // assign colors
  green = color(20, 200, 25);
  red = color(254, 0, 0);
  white = color(254, 254, 254);
  paddleColor = color(20, 200, 25);
  
  // initial ball direction
  ballXSpeed = random(-difficulty, difficulty);
  ballYSpeed = random(1, difficulty/2);
  
  /*String[] fontList = PFont.list(); // list fonts
  printArray(fontList);*/
}

void draw(){
  // screen reset
  background(254);
  lights();
  
  // set font
  textFont(font);
  textSize(24);
  
  // 'CLICK TO MOVE PADDLE' game state
  if(selectPosition){
    //count time
    frameCounter ++;
    
    // color green and draw player paddle
    paddleColor = green;
    fill(paddleColor);
    rect(paddleX, 900, 150, 20);
    
    // click to move paddle
    if(mousePressed) paddleX = mouseX - 75;
    
    // times up
    if(frameCounter > 120) {
      selectPosition = false;
      frameCounter = 0;
    }
    
    // draw text
    text("CLICK TO MOVE PADDLE", 12, 72);
    
    
  } else { // 'ball moving' game state
    
    // set paddle color to red
    paddleColor = red;
    
      // if is at paddle height
      if(ballY > 900 - (ballRadius + ballYSpeed) && ballY < 950){
        
        // end initial environment properties
        gameStart = false;
        
        // if ball contacts paddle
        if(ballX < paddleX + 150 && ballX > paddleX){
          
          // screen is green for a point
          iainsGradient(0, 0, 1000, 1000, white, green, false); // gradient on point
          
          // enable 'CLICK TO MOVE PADDLE' game state
          selectPosition = true;
          
          // increment score
          score ++;
          
          // target ball speed
          
            // Y axis
          print("\nEnergy: ");
          if(ballYSpeed < difficulty * 1.3) {
            print("add Y, ");
            ballYSpeed *= energyMult;
          } else {
            print("take Y, ");
            ballYSpeed *= takeEnergyMult;
          }
          
            // X axis (plus random to reduce loops)
          if(ballXSpeed < difficulty * 1.3) {
            print("add X");
            ballXSpeed *= energyMult + random(0.01, 0.1);
          } else {
            print("take X");
            ballXSpeed *= takeEnergyMult;
          }
          
          // change ball direction
          ballYSpeed = -ballYSpeed;
          
        } else { // if ball misses paddle
        
          // 'game over' gamestate
          gameOver = true;
        }
        
      } else if (ballY < ballRadius){ // if ball is at top of screen
      
      // change ball direction
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
      paddleColor = green;
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
  
  // score text
  fill(0);
  text("Score: " + str(score), 12, 36);
  
  // ~ design line ~
  stroke(0);
  line(0, 42, 1000, 42);
  
  // disable stroke for sphere
  noStroke();
  
  // move ball to X & Y position
  translate(ballX, ballY, 0);
  
  // set color and draw ball
  fill(20, 200, 200);
  sphere(ballRadius);
  
  // restart button
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

// basic x or y-axis gradient
void iainsGradient(int x, int y, int w, int h, color c1, color c2, boolean axis){
  noFill();
  color currentColor = c1;
  if (axis){ // x axis
  
    // loop for lines
    for(int i = x; i < x + w; i++){
      
      // find current line color of i percentage of width
      currentColor = lerpColor(c1, c2, /*(((100.0/float(w))/100.0) * i) - 1)*/map(i, x, x + w, 0, 1));
      
      // set line color and transparency
      stroke(currentColor, 0.5);
      
      // draw line
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
