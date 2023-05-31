class ScoreBoard extends PositionedElement {
  float edgeOffsetX = 0.0;
  final float defaultTextHeight = height / 7.0;
  Label leftScoreLabel, rightScoreLabel;
  Player leftPlayer, rightPlayer;
  
  ScoreBoard(PVector pos, PVector size, float edgeOffsetX, Player leftPlayer, Player rightPlayer) {
    super(pos, size);
    this.edgeOffsetX = edgeOffsetX;
    this.leftPlayer = leftPlayer;
    this.rightPlayer = rightPlayer;
    leftScoreLabel = new Label("0", new PVector(edgeOffsetX, pos.y), new PVector(0.0, defaultTextHeight), leftPlayer.getCol(), LEFT, BOTTOM);
    rightScoreLabel = new Label("0", new PVector(width - edgeOffsetX, pos.y), new PVector(0.0, defaultTextHeight), rightPlayer.getCol(), RIGHT, BOTTOM);
  }
  
  private void updateScoreLabels() {
    leftScoreLabel.setDisplayText(str(leftPlayer.score));
    leftScoreLabel.update();
    rightScoreLabel.setDisplayText(str(rightPlayer.score));
    rightScoreLabel.update();
  }
  
  void render() {
    pushStyle();
    updateScoreLabels();
    popStyle();
  }
  
  void doInput() {
  }
}
