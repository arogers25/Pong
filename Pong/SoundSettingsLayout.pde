public class SoundSettingsLayout extends Layout {
  private String soundToModify;
  private HashMap<String, Label> pathLabels;
  final PFont BUTTON_FONT = currentStyle.regularFont;
  final color BUTTON_COLOR = currentStyle.secondaryColor;
  final PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);
  
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
    if (selectedSound == null || !selectedSound.getPath().endsWith(".mp3")) {
      return;
    }
    songPaths.put(soundToModify, selectedSound.getAbsolutePath());
    pathLabels.get(soundToModify).setDisplayText(selectedSound.getName()); 
    
  }
  
  void onSetSoundButtonPressed(String soundToModify) {
    this.soundToModify = soundToModify;
    selectInput("Select a sound to add:", "setSelectedSound", null, this);
  }
  
  private void createModifySoundButton(String label, String soundName, PVector pos) {
    final PVector soundLabelPos = new PVector(pos.x + menuButtonSize.x, pos.y);
    final PVector soundLabelSize = new PVector(width - pos.x - menuButtonSize.x, menuButtonSize.y);
    
    RectangleButton modifySoundButton = new RectangleButton(BUTTON_FONT, 
    label, 
    pos, 
    menuButtonSize, 
    BUTTON_COLOR, 
    currentStyle.white, 
    "onSetSoundButtonPressed", 
    soundName);
    addElement(modifySoundButton);
    Label modifySoundLabel = new Label(currentStyle.regularFont, "No sound selected!", soundLabelPos, soundLabelSize, currentStyle.white, CENTER, CENTER);
    addElement(modifySoundLabel);
    pathLabels.put(soundName, modifySoundLabel);
  }

  private void addMenuButtons() {
    RectangleButton backToMenuButton = new RectangleButton(BUTTON_FONT, 
    "Back to Menu", 
    new PVector(), 
    menuButtonSize,
    BUTTON_COLOR, 
    currentStyle.white, 
    "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
    
    final PVector buttonIncrement = new PVector(0.0, menuButtonSize.y * 2.0);
    final PVector initialSoundButtonPos = PVector.sub(currentStyle.center, PVector.mult(menuButtonSize, 2.5));
    createModifySoundButton("Bounce Sound", "bounceSound", initialSoundButtonPos);
    final PVector scoreSoundButtonPos = PVector.add(initialSoundButtonPos, buttonIncrement);
    createModifySoundButton("Score Sound", "scoreSound", scoreSoundButtonPos);
    final PVector musicButtonPos = PVector.add(scoreSoundButtonPos, buttonIncrement);
    createModifySoundButton("Music", "gameMusic", musicButtonPos);
  }
}
