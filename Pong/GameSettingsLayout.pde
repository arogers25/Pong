class GameSettingsLayout extends Layout {
  ColorPicker leftColorPicker;
  
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
    
    leftColorPicker = new ColorPicker(color(255, 0, 0), new PVector(100.0, 100.0), new PVector(200.0, 200.0));
    addElement(leftColorPicker);
  }
}
