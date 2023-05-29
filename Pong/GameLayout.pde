class GameLayout extends Layout {
  Paddle leftPaddle, rightPaddle;
  ScoreZone leftScoreZone, rightScoreZone;
  Ball ball;
  final float BALL_RADIUS = height / 30.0;
  
  GameLayout() {
    super();
    PVector paddleSize = new PVector(height / 25.0, height / 7.0);
    float paddleOffsetX =  (paddleSize.x / 2.0);
    float startingPaddleY = currentStyle.center.y - (paddleSize.y / 2.0);
    leftPaddle = new Paddle(new PVector(width * (1.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, 'W', 'S');
    addElement(leftPaddle);
    rightPaddle = new Paddle(new PVector(width * (5.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize, UP, DOWN);
    addElement(rightPaddle);
    final float ZONE_WIDTH = width / 8.0;
    final float ZONE_X = ZONE_WIDTH + BALL_RADIUS;
    leftScoreZone = new ScoreZone(0, new PVector(-ZONE_X, 0.0), new PVector(ZONE_WIDTH, height));
    addElement(leftScoreZone);
    rightScoreZone = new ScoreZone(1, new PVector(width + ZONE_X, 0.0) , new PVector(ZONE_WIDTH, height));
    addElement(rightScoreZone);
    final float startAngle = PI / 1.5;
    createBall(startAngle);
  }
  
  void update() {
    super.update();
    int scored = max(leftScoreZone.hasBallEntered(), rightScoreZone.hasBallEntered());
    if (scored != -1) {
      float angle = (scored == 0 ? PI / 1.5 : PI / 1.5 + PI);
      createBall(angle);
    }
    ball.update();
  }
  
  protected final void drawBackground() {
    background(currentStyle.black);
  }
  
  private void createBall(float angle) {
    ball = new Ball(currentStyle.center.copy(), BALL_RADIUS, leftPaddle, rightPaddle);
    ball.setAngle(angle);
    leftScoreZone.setTargetBall(ball);
    rightScoreZone.setTargetBall(ball);
  }
}
