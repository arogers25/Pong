class GameOverLayout extends Layout {
  private GameSettings gameSettings;
  private Player winner;
  private Label winnerLabel;
  
  GameOverLayout(GameSettings gameSettings, Player winner) {
    super();
    this.gameSettings = gameSettings;
    this.winner = winner;
    addWinnerLabel();
    addOptionButtons();
  }
  
  void drawBackground() {
    pushStyle();
    fill(winner.getCol(), 100);
    rect(0.0, 0.0, width, height);
    popStyle();
  }
  
  void onRestartButtonPressed() {
    setCurrentLayout(new GameLayout(gameSettings));
  }
  
  void onBackToMenuButtonPressed() {
    shouldExitToMenu = true;
  }
  
  void onQuitButtonPressed() {
    exit();
  }
  
  private void addWinnerLabel() {
    winnerLabel = new Label(currentStyle.regularFont, winner.getName() + " wins!", new PVector(0.0, height / 2.0), new PVector(width, height / 7.0), currentStyle.white, CENTER, BASELINE);
    addElement(winnerLabel);
  }
  
  private void addOptionButtons() {
    PVector buttonSize = new PVector(winnerLabel.getTextWidth() / 3.0, height / 15.0);
    PVector buttonStartPos = new PVector(width / 2.0 - winnerLabel.getTextWidth() / 2.0, height * 0.53);
    PVector buttonPosIncrement = new PVector(buttonSize.x, 0.0);
    final PFont BUTTON_FONT = currentStyle.regularFont;
    final color BUTTON_COLOR = currentStyle.secondaryColor;
    
    Button restartButton = new RectangleButton(BUTTON_FONT, "Restart", buttonStartPos, buttonSize, BUTTON_COLOR, currentStyle.white, "onRestartButtonPressed");
    addElement(restartButton);
    
    PVector backToMenuButtonPos = PVector.add(buttonStartPos, buttonPosIncrement);
    Button backToMenuButton = new RectangleButton(BUTTON_FONT, "Back To Menu", backToMenuButtonPos, buttonSize, BUTTON_COLOR, currentStyle.white, "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
    
    PVector quitButtonPos = PVector.add(backToMenuButtonPos, buttonPosIncrement);
    Button quitButton = new RectangleButton(BUTTON_FONT, "Quit", quitButtonPos, buttonSize, BUTTON_COLOR, currentStyle.white, "onQuitButtonPressed");
    addElement(quitButton);
  }
}
