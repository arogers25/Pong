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
    addWarningLabel();
  }

  void drawBackground() {
    background(currentStyle.black);
  }

  void onBackToMenuButtonPressed() {
    setCurrentLayout(new MenuLayout());
  }
  
  void setSelectedSound(File selectedSound) {
    if (selectedSound == null || !selectedSound.getPath().endsWith(".mp3")) {
      return;
    }
    soundPaths.put(soundToModify, selectedSound);
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
    String foundSongName = soundPaths.get(soundName) == null ? "No song selected!" : soundPaths.get(soundName).getName();
    Label modifySoundLabel = new Label(currentStyle.regularFont, foundSongName, soundLabelPos, soundLabelSize, currentStyle.white, CENTER, CENTER);
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
  
  private void addWarningLabel() {
    addElement(new Label(currentStyle.regularFont, "All sounds must be .mp3s", new PVector(0, height / 7.0), new PVector(width, height / 7.0), currentStyle.white, CENTER, CENTER));
  }
}
