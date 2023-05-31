class GameLayout extends Layout {
  Player leftPlayer, rightPlayer;
  Paddle leftPaddle, rightPaddle;
  ScoreZone leftScoreZone, rightScoreZone;
  Ball ball;
  final float BALL_RADIUS = height / 30.0;
  final float BALL_START_ANGLE = radians(120.0);
  
  GameLayout() {
    super();
    createGameObjects();
  }
  
  void update() {
    updateScore();
    super.update();
  }
  
  protected final void drawBackground() {
    background(currentStyle.black);
  }
  
  private void resetBall(float angle) {
    if (ball == null) {
      ball = new Ball(currentStyle.center.copy(), BALL_RADIUS, leftPaddle, rightPaddle);
      addElement(ball);
    } else {
      ball.setSpeed(0.0); // Reset the ball's speed to its minimum
      ball.setPos(currentStyle.center);
    }
    ball.setAngle(angle);
  }
  
  private Player getScoringPlayer() { // The Player whose ScoreZone has been entered is the opposite of the one who hit the ball
    Player scoringPlayer;
    if (leftScoreZone.hasEntered()) {
      return rightScoreZone.getControllingPlayer();
    }
    if (rightScoreZone.hasEntered()) {
      return leftScoreZone.getControllingPlayer();
    }
    return null;
  }
  
  private void updateScore() {
    Player scoringPlayer = getScoringPlayer();
    if (scoringPlayer == null) {
      return;
    }
    float angle = scoringPlayer.getResetAngle();
    scoringPlayer.increaseScore(1);
    resetBall(angle);
  }
  
  private void createPlayers() {
    leftPlayer = new Player('W', 'S', BALL_START_ANGLE);
    rightPlayer = new Player(UP, DOWN, BALL_START_ANGLE / 2.0);
  }
  
  private void createPaddles() {
    PVector paddleSize = new PVector(height / 25.0, height / 7.0);
    float paddleOffsetX =  (paddleSize.x / 2.0);
    float startingPaddleY = currentStyle.center.y - (paddleSize.y / 2.0);
    leftPaddle = new Paddle(leftPlayer, new PVector(width * (1.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize);
    addElement(leftPaddle);
    rightPaddle = new Paddle(rightPlayer, new PVector(width * (5.0 / 6.0) - paddleOffsetX, startingPaddleY), paddleSize);
    addElement(rightPaddle);
  }
  
  private void createScoreZones() {
    final float ZONE_WIDTH = width / 8.0;
    leftScoreZone = new ScoreZone(leftPlayer, ball, new PVector(-(ZONE_WIDTH + BALL_RADIUS), 0.0), new PVector(ZONE_WIDTH, height));
    addElement(leftScoreZone);
    rightScoreZone = new ScoreZone(rightPlayer, ball, new PVector(width + BALL_RADIUS, 0.0) , new PVector(ZONE_WIDTH, height));
    addElement(rightScoreZone);
  }
  
  private void createScoreBoard() {
    ScoreBoard testScoreBoard = new ScoreBoard(new PVector(0.0, height / 7.0), new PVector(width, height), width * (2.0 / 6.0), leftPlayer, rightPlayer);
    addElement(testScoreBoard);
  }
  
  private void createGameObjects() {
    createPlayers();
    createPaddles();
    resetBall(BALL_START_ANGLE);
    createScoreZones();
    createScoreBoard();
  }
}
