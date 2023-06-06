class MenuLayout extends Layout {
  MenuLayout() {
    super();
    addTitleLabel();
    addMenuButtons();
  }
  
  void drawBackground() {
    background(currentStyle.black);
  }
  
  void onPlayButtonPressed() {
    setCurrentLayout(new GameLayout());
  }
  
  void onQuitButtonPressed() {
    exit();
  }
  
  private void addTitleLabel() {
    Label titleLabel = new Label("Pong!", new PVector(0.0, width / 12.0), new PVector(width, height / 3.5), currentStyle.white, CENTER, CENTER);
    addElement(titleLabel);
  }
  
  private void addMenuButtons() {
    PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);
    PVector centeredButtonPos = new PVector(currentStyle.center.x - (menuButtonSize.x / 2.0), currentStyle.center.y - (menuButtonSize.y / 2.0));
    PVector buttonPosIncrement = new PVector(0.0, menuButtonSize.y * 1.5);
    
    Button playButton = new RectangleButton("Play", centeredButtonPos, menuButtonSize, color(70), currentStyle.white, "onPlayButtonPressed");
    addElement(playButton);
    
    PVector exitButtonPos = PVector.add(centeredButtonPos, buttonPosIncrement);
    Button exitButton = new RectangleButton("Quit", exitButtonPos, menuButtonSize, color(70), currentStyle.white, "onQuitButtonPressed");
    addElement(exitButton);
  }
}
