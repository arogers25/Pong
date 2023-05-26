class GameLayout extends Layout {
  Paddle leftPaddle, rightPaddle;
  ScoreZone leftScoreZone, rightScoreZone;
  Ball ball;
  
  GameLayout() {
    super();
    PVector paddleSize = new PVector(height / 25.0, height / 7.0);
    float paddleOffsetX =  (paddleSize.x / 2.0);
    float startingPaddleY = currentStyle.center.y - (paddleSize.y / 2.0);
    leftPaddle = new Paddle(new PVector(width * (1.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, 'W', 'S');
    addElement(leftPaddle);
    rightPaddle = new Paddle(new PVector(width * (5.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, UP, DOWN);
    addElement(rightPaddle);
    leftScoreZone = new ScoreZone(0, new PVector(0.0, 0.0), new PVector(width / 8.0, height));
    addElement(leftScoreZone);
    rightScoreZone = new ScoreZone(1, new PVector(width * (7.0 / 8.0), 0.0), new PVector(width / 8.0, height));
    addElement(rightScoreZone);
    createBall();
  }
  
  void update() {
    super.update();
    ball.update();
  }
  
  protected final void drawBackground() {
    background(currentStyle.black);
  }
  
  private void createBall() {
    ball = new Ball(currentStyle.center, height / 30.0, leftPaddle, rightPaddle);
    final float startAngle = PI / 1.5;
    ball.setAngle(startAngle);
  }
}
