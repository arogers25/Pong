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
    currentLayout = new GameLayout();
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
    
    leftColorPicker = new ColorPicker(color(255, 0, 0), new PVector(width / 6.0, colorPickerY), colorPickerSize);
    addElement(leftColorPicker);
    
    PVector rightColorPickerPos = new PVector(width * (5.0 / 6.0) - colorPickerSize.x, colorPickerY);
    rightColorPicker = new ColorPicker(color(0, 0, 255), rightColorPickerPos, colorPickerSize);
    addElement(rightColorPicker);
  }
}
