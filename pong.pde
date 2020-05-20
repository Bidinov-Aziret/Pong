/*
  Игра pong 
 */

// Ball

final int BALL_SIZE = 30;
final int BALL_HALF_SIZE = BALL_SIZE / 2;

int ballX;
int ballY;
int ballDX = 5;
int ballDY = 5;

// Paddles

final int PADDLES_WIDTH = 30;
final int PADDLES_HEIGHT = 120;
final int PADDLES_HALF_WIDTH = PADDLES_WIDTH / 2;
final int PADDLES_HALF_HIEGHT = PADDLES_HEIGHT / 2;

int leftPaddleX;
int leftPaddleY;
int leftPaddleDY = 5;

int rightPaddleX;
int rightPaddleY;
int rightPaddleDY = 5;

// Menu

final int MENU_STATE  = 0;
final int GAME_STATE  = 1;
final int PAUSE_STATE = 2;
final int VICTORY_STATE = 3;

int state = MENU_STATE;

// Score

final int SCORE_TEXT_SIZE = 150;
final int SCORE_MARGIN_TOP = 100;
final int SCORE_MARGIN_SIDE = 200;

int leftPlayerScore = 0;
int rigthPlayerScore = 0; 

void setup() {
  fullScreen();
  background(0);
  noStroke();
  rectMode(CENTER);

  // Ball

  ballX = width / 2;
  ballY = height / 2;

  // Paddle

  leftPaddleX = PADDLES_HALF_WIDTH;
  rightPaddleX = width - PADDLES_HALF_WIDTH;
  leftPaddleY = rightPaddleY = height / 2;
}

void draw() {
  background(0);

  //Menu
  
  switch (state) {
  case MENU_STATE:
    drawMenu();
    break;
  case GAME_STATE:
    drawGame();
    break;
  case PAUSE_STATE:
    drawPause();
    break;
  case VICTORY_STATE:
    drawVictory();
    break;
  }
}

void drawMenu() {
  fill(255, 0, 0);
  textSize(130);
  textAlign(CENTER, CENTER);
  text("Pong", width / 2, height / 2);

  fill(255);
  textSize(30);
  text("Press Enter to start the game", width / 2, height / 2 + 170);
}

void drawGame() {
  // Ball

  fill(#09C600);
  rect(ballX, ballY, BALL_SIZE, BALL_SIZE);

  ballX += ballDX;
  ballY += ballDY;  

  if (ballX - BALL_HALF_SIZE >= width) {
    leftPlayerScore++;
    ballX = width / 2;
    ballY = height / 2;
    ballDX *= -1;
  }
  if (ballX + BALL_HALF_SIZE < 0) {
    rigthPlayerScore++;
    ballX = width / 2;
    ballY = height / 2;
    ballDX *= -1;
  }
  if (ballY + BALL_HALF_SIZE >= height || ballY - BALL_HALF_SIZE < 0) {
    ballDY *= -1;
  }

  // Paddles 

  rect(leftPaddleX, leftPaddleY, PADDLES_WIDTH, PADDLES_HEIGHT);
  rect(rightPaddleX, rightPaddleY, PADDLES_WIDTH, PADDLES_HEIGHT);

  if (keyPressed) {
    if (keyCode == UP) {
      leftPaddleY -= leftPaddleDY;
      rightPaddleY -= rightPaddleDY;
      if (leftPaddleY - PADDLES_HALF_HIEGHT < 0) {
        leftPaddleY = PADDLES_HALF_HIEGHT;
      }
      if (rightPaddleY - PADDLES_HALF_HIEGHT < 0) {
        rightPaddleY = PADDLES_HALF_HIEGHT;
      }
    } else if (keyCode == DOWN) {
      leftPaddleY += leftPaddleDY;
      rightPaddleY += rightPaddleDY;
      if (leftPaddleY + PADDLES_HALF_HIEGHT > height) {
        leftPaddleY = height - PADDLES_HALF_HIEGHT;
      }
      if (rightPaddleY + PADDLES_HALF_HIEGHT > height) {
        rightPaddleY = height - PADDLES_HALF_HIEGHT;
      }
    }
  }

  // Collision Detection

  if (abs(ballX - leftPaddleX) < BALL_HALF_SIZE + PADDLES_HALF_WIDTH &&
    abs(ballY - leftPaddleY) < BALL_HALF_SIZE + PADDLES_HALF_HIEGHT ||
    abs(ballX - rightPaddleX) < BALL_HALF_SIZE + PADDLES_HALF_HIEGHT &&
    abs(ballY - rightPaddleY) < BALL_HALF_SIZE + PADDLES_HALF_HIEGHT) {
    ballDX *= -1;
  }

  // Score

  textSize(SCORE_TEXT_SIZE);
  textAlign(CENTER, CENTER);
  text(leftPlayerScore, SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
  text(rigthPlayerScore, width - SCORE_MARGIN_SIDE, SCORE_MARGIN_TOP);
}

void drawPause() {
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(30);
  text("Press ESC to continue the game", width / 2, height / 2);
}

float angle = 0;
void drawVictory() {
  noStroke();
  pushMatrix();
  translate(width / 2, height / 2);
  for (int i = 0; i < 100; i++) {
    rotate(angle);
    angle += 0.00005;
    translate(i * 10, 0);
    fill(200 * i / 100.0);
    rect(0, 0, 100, 100);
  }
  popMatrix();
  
  // ---
  
  fill(255, 0, 0);
  textSize(150);
  textAlign(CENTER, CENTER);
  text("You won!",  width / 2, height / 2);
  
  textSize(70);
  text("Your Score " + leftPlayerScore, width / 2, height / 2 + 170);
  
  fill(255);
  textSize(30);
  text("Press Enter to go back to menu", width / 2, height / 2 + 230);
}

void keyPressed() {
  switch (state) {
  case MENU_STATE:
    keyPressedInMenu();
    break;
  case GAME_STATE:
    keyPressedInGame();
    break;
  case PAUSE_STATE:
    keyPressedOnPause();
    break;
  case VICTORY_STATE:
    keyPressedInVictory();
    break;
  }
}

void keyPressedInMenu() {
  if (keyCode == ENTER) {
    leftPlayerScore = 0;
    rigthPlayerScore = 0;
    state = GAME_STATE;
  }
}

void keyPressedInGame() {
  if (key == ' ') {
    state = PAUSE_STATE;
  }
}

void keyPressedOnPause() {
  if (key == ' ') {
    state = GAME_STATE;
  }
}
  
void keyPressedInVictory() {
  if (keyCode == ENTER) {
    state = MENU_STATE;
  }
}
