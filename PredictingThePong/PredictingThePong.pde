
int ballRadius = 20;

float ballX = 500;
float ballY = 200;

float ballXSpeed, ballYSpeed, ballZSpeed = 0;

color green, red, white;

void setup(){
  size(1000, 1000, P3D);
  background(100);
  frameRate(60);
  
  green = color(0, 254, 0);
  red = color(254, 0, 0);
  white = color(254, 254, 254);
}

void draw(){
  background(254);
  noStroke();
  lights();
  
  if(ballY > 900){
    if(ballY > 900 - ballRadius){
      if(ballX < mouseX + 50 && ballX > mouseX - 50){
        ballYSpeed = - ballYSpeed; 
      } else {
        iainsGradient(0, 0, 1000, 1000, white, red, false);
      }
    }
  }
  
  translate(ballX, ballY, 0);
  fill(200, 205, 0);
  sphere(ballRadius);
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
