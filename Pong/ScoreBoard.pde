class ScoreBoard extends PositionedElement {
  private float edgeOffsetX = 0.0;
  private final float defaultTextHeight = height / 7.0;
  private Label maxScoreLabel, leftScoreLabel, rightScoreLabel;
  private Player leftPlayer, rightPlayer;
  
  ScoreBoard(int maxScore, PVector pos, PVector size, float edgeOffsetX, Player leftPlayer, Player rightPlayer) {
    super(pos, size);
    this.edgeOffsetX = edgeOffsetX;
    this.leftPlayer = leftPlayer;
    this.rightPlayer = rightPlayer;
    PFont scoreFont = currentStyle.lightFont;
    String maxScoreLabelText = maxScore > 0 ? ("First To " + maxScore) : "Endless Game";
    maxScoreLabel = new Label(scoreFont, maxScoreLabelText, new PVector(0.0, pos.y - defaultTextHeight / 5.0), new PVector(size.x, defaultTextHeight / 2.0), currentStyle.white, CENTER, BOTTOM);
    leftScoreLabel = new Label(scoreFont, "0", new PVector(edgeOffsetX, pos.y), new PVector(0.0, defaultTextHeight), leftPlayer.getCol(), LEFT, BOTTOM);
    rightScoreLabel = new Label(scoreFont, "0", new PVector(width - edgeOffsetX, pos.y), new PVector(0.0, defaultTextHeight), rightPlayer.getCol(), RIGHT, BOTTOM);
  }
  
  private void updateScoreLabels() {
    maxScoreLabel.update();
    leftScoreLabel.update();
    rightScoreLabel.update();
  }
  
  void render() {
    pushStyle();
    updateScoreLabels();
    popStyle();
  }
  
  void doInput() {
  }
  
  void updateScore() {
    leftScoreLabel.setDisplayText(str(leftPlayer.score));
    rightScoreLabel.setDisplayText(str(rightPlayer.score));
  }
}
