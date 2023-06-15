class GameLayout extends Layout {
  private GameSettings gameSettings;
  private LerpColor backgroundCol;
  private Player leftPlayer, rightPlayer;
  private Paddle leftPaddle, rightPaddle;
  private ScoreZone leftScoreZone, rightScoreZone;
  private ScoreBoard scoreBoard;
  private Ball ball;
  private GameOverLayout gameOverLayout;
  private AudioSample scoreSound;
  private AudioPlayer gameMusic;
  private final float BALL_RADIUS = height / 30.0;
  private final float BALL_START_ANGLE = radians(120.0);
  
  GameLayout(GameSettings gameSettings) {
    super();
    final float LERP_TIME_MULT = 0.5;
    backgroundCol = new LerpColor(currentStyle.black, LERP_TIME_MULT);
    this.gameSettings = gameSettings;
    createGameObjects();
    createScoreSound();
    createGameMusic();
    playGameMusic();
  }
  
  void update() {
    updateScore();
    super.update();
    if (gameOverLayout != null) {
      gameOverLayout.update();
    }
    if (shouldExitToMenu) {
      deleteSounds();
    }
  }
  
  protected final void drawBackground() {
    if (backgroundCol.shouldUpdate()) {
      backgroundCol.updateLerp();
    }
    background(backgroundCol.getCol());
  }
  
  private void setShouldUpdate(boolean shouldUpdate) {
    leftPaddle.setShouldUpdate(shouldUpdate);
    rightPaddle.setShouldUpdate(shouldUpdate);
    ball.setShouldUpdate(shouldUpdate);
  }
  
  private void resetBall(float angle) {
    if (ball == null) {
      ball = new Ball(currentStyle.center.copy(), BALL_RADIUS, leftPaddle, rightPaddle);
      addElement(ball);
    } else {
      ball.setSpeed(0.0); // Reset the ball's speed to its minimum
      ball.setPos(currentStyle.center);
      ball.setNumBounces(0);
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
    if (gameOverLayout == null) {
      scoringPlayer.increaseScore(1);
      scoreBoard.updateScore();
      playScoreSound();
    }
    int maxScore = gameSettings.maxScore;
    if (maxScore > 0 && scoringPlayer.getScore() >= maxScore) {
      gameOverLayout = new GameOverLayout(gameSettings, scoringPlayer);
      pauseGameMusic();
      setShouldUpdate(false);
      return;
    }
    final float STARTING_COLOR_PROGRESS = 0.3;
    backgroundCol.startLerp(scoringPlayer.getCol(), STARTING_COLOR_PROGRESS);
    resetBall(angle);
  }
  
  private void createPlayers() {
    leftPlayer = new Player("Left", 'W', 'S', BALL_START_ANGLE / 2.0, gameSettings.leftPaddleCol);
    rightPlayer = new Player("Right", UP, DOWN, BALL_START_ANGLE, gameSettings.rightPaddleCol);
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
    scoreBoard = new ScoreBoard(gameSettings.maxScore, new PVector(0.0, height / 7.0), new PVector(width, height), width * (1.5 / 6.0), leftPlayer, rightPlayer);
    scoreBoard.updateScore();
    addElement(scoreBoard);
  }
  
  private void createGameObjects() {
    createPlayers();
    createPaddles();
    resetBall(BALL_START_ANGLE);
    createScoreZones();
    createScoreBoard();
  }
  
  private void createScoreSound() {
    try {
      scoreSound = minim.loadSample(soundPaths.get("scoreSound").toString());
    } catch (Exception e) {
      println("Failed loading score sound: ", e.toString());
    }
  }
  
  private void playScoreSound() {
    if (scoreSound != null) {
      scoreSound.trigger();
    }
  }
  
   private void createGameMusic() {
     try {
       gameMusic = minim.loadFile(soundPaths.get("gameMusic").toString());
     } catch (Exception e) {
       println("Failed loading game music: ", e.toString());
     }
  }
  
  private void playGameMusic() {
    if (gameMusic != null) {
      gameMusic.play();
      gameMusic.loop(-1);
    }
  }
  
  void pauseGameMusic() {
    if (gameMusic != null) {
      gameMusic.pause();
    }
  }
  
  private void deleteSounds() {
    if (scoreSound != null) {
      scoreSound.close();
      scoreSound = null;
    }
    if (gameMusic != null) {
      gameMusic.close();
      gameMusic = null;
    }
    ball.deleteBounceSound();
  }
}
