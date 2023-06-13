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
    setCurrentLayout(new GameSettingsLayout());
  }
  
  void onSoundSettingsButtonPressed() {
    setCurrentLayout(new SoundSettingsLayout());
  }
  
  void onQuitButtonPressed() {
    exit();
  }
  
  private void addTitleLabel() {
    Label titleLabel = new Label(currentStyle.regularFont, "Pong!", new PVector(0.0, width / 12.0), new PVector(width, height / 3.5), currentStyle.white, CENTER, CENTER);
    addElement(titleLabel);
  }
  
  private void addMenuButtons() {
    final PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);
    final PVector centeredButtonPos = new PVector(currentStyle.center.x - (menuButtonSize.x / 2.0), currentStyle.center.y - (menuButtonSize.y / 2.0));
    final PVector buttonPosIncrement = new PVector(0.0, menuButtonSize.y * 1.5);
    final PFont BUTTON_FONT = currentStyle.regularFont;
    final color BUTTON_COLOR = currentStyle.secondaryColor;
    
    Button playButton = new RectangleButton(BUTTON_FONT, "Play", centeredButtonPos, menuButtonSize, BUTTON_COLOR, currentStyle.white, "onPlayButtonPressed");
    addElement(playButton);
    
    final PVector soundSettingsButtonPos = PVector.add(centeredButtonPos, buttonPosIncrement);
    Button soundSettingsButton = new RectangleButton(BUTTON_FONT, "Change Sounds", soundSettingsButtonPos, menuButtonSize, BUTTON_COLOR, currentStyle.white, "onSoundSettingsButtonPressed");
    addElement(soundSettingsButton);
    
    final PVector exitButtonPos = PVector.add(soundSettingsButtonPos, buttonPosIncrement);
    Button exitButton = new RectangleButton(BUTTON_FONT, "Quit", exitButtonPos, menuButtonSize, BUTTON_COLOR, currentStyle.white, "onQuitButtonPressed");
    addElement(exitButton);
  }
}
