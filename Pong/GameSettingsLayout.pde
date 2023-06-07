class GameSettingsLayout extends Layout {
  ColorPicker leftColorPicker, rightColorPicker;
  
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
    GameSettings gameSettings = new GameSettings(leftPaddleCol, rightPaddleCol);
    currentLayout = new GameLayout(gameSettings);
  }
  
  void onBackToMenuButtonPressed() {
    currentLayout = new MenuLayout();
  }
  
  private void addMenuButtons() {
    PFont buttonFont = currentStyle.regularFont;
    PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);
    
    PVector startGameButtonPos = new PVector(currentStyle.center.x - menuButtonSize.x / 2.0, height / 1.2);
    RectangleButton startGameButton = new RectangleButton(buttonFont, "Start Game", startGameButtonPos, menuButtonSize, color(70), currentStyle.white, "onStartGameButtonPressed");
    addElement(startGameButton);
    
    RectangleButton backToMenuButton = new RectangleButton(buttonFont, "Back to Menu", new PVector(), menuButtonSize, color(70), currentStyle.white, "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
    
    float colorPickerY = height / 3.0;
    PVector colorPickerSize = new PVector(height / 5.0, height / 3.0);
    PVector labelSize = new PVector(colorPickerSize.x * 2.0, height / 10.0);
    PVector labelOffset = new PVector(colorPickerSize.x / 2.0, labelSize.y / 10.0);
    
    PVector leftColorPickerPos = new PVector(width / 6.0, colorPickerY);
    leftColorPicker = new ColorPicker(currentStyle.defaultLeftPaddleCol, leftColorPickerPos, colorPickerSize);
    addElement(leftColorPicker);
    Label leftSideLabel = new Label(currentStyle.regularFont, "Left Side", PVector.sub(leftColorPickerPos, labelOffset), labelSize, currentStyle.white, CENTER, BOTTOM);
    addElement(leftSideLabel);
    
    PVector rightColorPickerPos = new PVector(width * (5.0 / 6.0) - colorPickerSize.x, colorPickerY);
    rightColorPicker = new ColorPicker(currentStyle.defaultRightPaddleCol, rightColorPickerPos, colorPickerSize);
    addElement(rightColorPicker);
    Label rightSideLabel = new Label(currentStyle.regularFont, "Right Side", PVector.sub(rightColorPickerPos, labelOffset), labelSize, currentStyle.white, CENTER, BOTTOM);
    addElement(rightSideLabel);
  }
}
