class GameSettingsLayout extends Layout {
  private ColorPicker leftColorPicker, rightColorPicker;
  private Slider scoreSlider;
  private Label maxScoreLabel;
  private int maxScore;
  
  GameSettingsLayout() {
    super();
    addMenuButtons();
  }
  
  void drawBackground() {
    background(currentStyle.black);
  }
  
  void onStartGameButtonPressed() {
    color leftPaddleCol = leftColorPicker.getPickedCol();
    color rightPaddleCol = rightColorPicker.getPickedCol();
    GameSettings gameSettings = new GameSettings(maxScore, leftPaddleCol, rightPaddleCol);
    setCurrentLayout(new GameLayout(gameSettings));
  }
  
  void onBackToMenuButtonPressed() {
    setCurrentLayout(new MenuLayout());
  }
  
  void update() {
    super.update();
    updateMaxScoreLabel();
  }
  
  private void addMenuButtons() {
    final PFont BUTTON_FONT = currentStyle.regularFont;
    final color BUTTON_COLOR = currentStyle.secondaryColor;
    final PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);
    
    final PVector startGameButtonPos = new PVector(currentStyle.center.x - menuButtonSize.x / 2.0, height / 1.2);
    RectangleButton startGameButton = new RectangleButton(BUTTON_FONT, "Start Game", startGameButtonPos, menuButtonSize, BUTTON_COLOR, currentStyle.white, "onStartGameButtonPressed");
    addElement(startGameButton);
    
    RectangleButton backToMenuButton = new RectangleButton(BUTTON_FONT, "Back to Menu", new PVector(), menuButtonSize, BUTTON_COLOR, currentStyle.white, "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
    
    final float colorPickerY = height / 3.0;
    final PVector colorPickerSize = new PVector(height / 5.0, height / 3.0);
    final PVector labelSize = new PVector(colorPickerSize.x * 2.0, height / 10.0);
    final PVector labelOffset = new PVector(colorPickerSize.x / 2.0, labelSize.y / 10.0);
    
    final PVector leftColorPickerPos = new PVector(width / 6.0, colorPickerY);
    leftColorPicker = new ColorPicker(currentStyle.defaultLeftPaddleCol, leftColorPickerPos, colorPickerSize);
    addElement(leftColorPicker);
    Label leftSideLabel = new Label(currentStyle.regularFont, "Left Side", PVector.sub(leftColorPickerPos, labelOffset), labelSize, currentStyle.white, CENTER, BOTTOM);
    addElement(leftSideLabel);
    
    final PVector rightColorPickerPos = new PVector(width * (5.0 / 6.0) - colorPickerSize.x, colorPickerY);
    rightColorPicker = new ColorPicker(currentStyle.defaultRightPaddleCol, rightColorPickerPos, colorPickerSize);
    addElement(rightColorPicker);
    Label rightSideLabel = new Label(currentStyle.regularFont, "Right Side", PVector.sub(rightColorPickerPos, labelOffset), labelSize, currentStyle.white, CENTER, BOTTOM);
    addElement(rightSideLabel);
    
    final PVector scoreSliderSize = new PVector(width / 3.0, menuButtonSize.y / 3.0);
    final PVector scoreSliderPos = new PVector(currentStyle.center.x - scoreSliderSize.x / 2.0, startGameButtonPos.y - scoreSliderSize.y * 2.0);
    final float DEFAULT_MAX_SCORE = 7.0;
    scoreSlider = new Slider(scoreSliderPos, scoreSliderSize, currentStyle.white, BUTTON_COLOR, DEFAULT_MAX_SCORE, 0.0, 100.0);
    addElement(scoreSlider);
    
    final PVector scoreSliderLabelPos = new PVector(scoreSliderPos.x, scoreSliderPos.y - menuButtonSize.y);
    maxScoreLabel = new Label(currentStyle.regularFont, "", scoreSliderLabelPos, new PVector(scoreSliderSize.x, menuButtonSize.y), currentStyle.white, CENTER, CENTER);
    updateMaxScoreLabel();
    addElement(maxScoreLabel);
  }
  
  private void updateMaxScoreLabel() {
    maxScore = (int)scoreSlider.getCurrentValue();
    String scoreText = (maxScore == 0) ? "Infinite" : str(maxScore);
    maxScoreLabel.setDisplayText("Max Score: " + scoreText);
  }
}
