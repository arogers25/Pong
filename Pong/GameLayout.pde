class GameLayout extends Layout {
  GameLayout() {
    super();
    PVector paddleSize = new PVector(height / 25.0, height / 7.0);
    float paddleOffsetX =  (paddleSize.x / 2.0);
    float startingPaddleY = currentStyle.center.y - (paddleSize.y / 2.0);
    Paddle leftPaddle = new Paddle(new PVector(width * (1.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, 'W', 'S');
    addElement(leftPaddle);
    Paddle rightPaddle = new Paddle(new PVector(width * (5.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, UP, DOWN);
    addElement(rightPaddle);
    Ball ball = new Ball(currentStyle.center, height / 30.0, leftPaddle, rightPaddle);
    final float startAngle = PI / 1.5;
    ball.setAngle(startAngle);
    addElement(ball);
  }
  
  protected final void drawBackground() {
    background(currentStyle.black);
  }
}
