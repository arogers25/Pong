class MenuLayout extends Layout {
  MenuLayout() {
    super();
    addMenuButtons();
  }
  
  void onPlayButtonPressed() {
    setCurrentLayout(new GameLayout());
  }
  
  private void addMenuButtons() {
    PVector menuButtonSize = new PVector(width / 10.0, height / 12.0);
    PVector centeredButtonPos = new PVector(currentStyle.center.x - (menuButtonSize.x / 2.0), currentStyle.center.y -(menuButtonSize.y / 2.0));
    Button playButton = new RectangleButton("Play", centeredButtonPos, menuButtonSize, color(70), currentStyle.white, "onPlayButtonPressed");
    addElement(playButton);
  }
}
