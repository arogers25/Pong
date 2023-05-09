class GameLayout extends Layout {
  GameLayout() {
    super();
    PVector paddleSize = new PVector(height / 25.0, height / 7.0);
    float paddleOffsetX =  (paddleSize.x / 2.0);
    float startingPaddleY = currentStyle.center.y - (paddleSize.y / 2.0);
    Paddle leftPaddle = new Paddle(new PVector(width * (1.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, 'W', 'S');
    addElement(leftPaddle);
    Paddle rightPaddle = new Paddle(new PVector(width * (5.0 / 6.0), startingPaddleY), paddleSize, UP, DOWN);
    addElement(rightPaddle);
  }
  
  protected final void drawBackground() {
    background(currentStyle.black);
  }
}
