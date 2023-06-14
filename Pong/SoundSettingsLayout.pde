public class SoundSettingsLayout extends Layout {
  String soundToModify;
  HashMap<String, Label> pathLabels;
  
  SoundSettingsLayout() {
    super();
    pathLabels = new HashMap();
    addMenuButtons();
  }

  void drawBackground() {
    background(currentStyle.black);
  }

  void onBackToMenuButtonPressed() {
    currentLayout = new MenuLayout();
  }
  
  void setSelectedSound(File selectedSound) {
    if (selectedSound == null) {
      return;
    }
    songPaths.put(soundToModify, selectedSound.getAbsolutePath());
    pathLabels.get(soundToModify).setDisplayText(selectedSound.getName()); 
    
  }
  
  void onSetSoundButtonPressed(String soundToModify) {
    this.soundToModify = soundToModify;
    //songPaths.put(soundToModify, "Testing");
    selectInput("Select a sound to add:", "setSelectedSound", null, this);
    //soundToModify = minim.loadSample("data/sounds/defaultBounce.mp3");
  }
  
  //private createModifySoundButton(String label, PVector pos, PVector size, 

  private void addMenuButtons() {
    final PFont BUTTON_FONT = currentStyle.regularFont;
    final color BUTTON_COLOR = currentStyle.secondaryColor;
    final PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);

    RectangleButton backToMenuButton = new RectangleButton(BUTTON_FONT, 
    "Back to Menu", 
    new PVector(), 
    menuButtonSize,
    BUTTON_COLOR, 
    currentStyle.white, 
    "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
    
    PVector initialSoundButtonPos = PVector.sub(currentStyle.center, PVector.mult(menuButtonSize, 2.5));
    PVector initialSoundLabelPos = new PVector(initialSoundButtonPos.x + menuButtonSize.x, initialSoundButtonPos.y);
    PVector buttonPosIncrement = new PVector(0.0, menuButtonSize.y * 2.0);
    PVector soundLabelSize = new PVector(width - initialSoundButtonPos.x - menuButtonSize.x, menuButtonSize.y);
    RectangleButton bounceSoundButton = new RectangleButton(BUTTON_FONT, 
    "Bounce Sound", 
    initialSoundButtonPos, 
    menuButtonSize, 
    BUTTON_COLOR, 
    currentStyle.white, 
    "onSetSoundButtonPressed", 
    "bounceSound");
    addElement(bounceSoundButton);
    Label bounceSoundLabel = new Label(currentStyle.regularFont, "No sound selected!", initialSoundLabelPos, soundLabelSize, currentStyle.white, CENTER, CENTER);
    addElement(bounceSoundLabel);
    pathLabels.put("bounceSound", bounceSoundLabel);
    
    //PVector scoreSound
    RectangleButton scoreSoundButton = new RectangleButton(BUTTON_FONT, 
    "Score Sound", 
    PVector.add(initialSoundButtonPos, buttonPosIncrement), 
    menuButtonSize, 
    BUTTON_COLOR, 
    currentStyle.white, 
    "onSetSoundButtonPressed", 
    "scoreSound");
    addElement(scoreSoundButton);
    Label scoreSoundLabel = new Label(currentStyle.regularFont, "No sound selected!", PVector.add(initialSoundLabelPos, buttonPosIncrement), soundLabelSize, currentStyle.white, CENTER, CENTER);
    addElement(scoreSoundLabel);
    pathLabels.put("scoreSound", scoreSoundLabel);
  }
}
