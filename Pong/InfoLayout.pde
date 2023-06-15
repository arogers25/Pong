class InfoLayout extends Layout {
  InfoLayout() {
    super();
    addMenuButtons();
    addInfoLabel();
  }
  
  void drawBackground() {
    background(0);
  }
  
  void onBackToMenuButtonPressed() {
    setCurrentLayout(new MenuLayout());
  }
  
  private void addMenuButtons() {
    final PFont BUTTON_FONT = currentStyle.regularFont;
    final color BUTTON_COLOR = currentStyle.secondaryColor;
    final PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);
    
    RectangleButton backToMenuButton = new RectangleButton(BUTTON_FONT, "Back to Menu", new PVector(), menuButtonSize, BUTTON_COLOR, currentStyle.white, "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
  }
  
  private void addInfoLabel() {
    String infoText = "Pong!\n\n";
    infoText += "Controls:\nLeft Paddle: W (Up) S (Down)\nRight Paddle: Up Arrow (Up) Down Arrow (Down)\nPress ESCAPE to return to main menu at any time\n\n";
    infoText += "Credits:\nMade using Processing 4\nSounds played using Minim library\nDefault game sounds sourced from freesound.org\nFonts sourced from Google Fonts\n\n";
    infoText += "Made in 2023 by Andreas Rogers\n";
    infoText += "github.com/arogers25";
    final PVector infoTextSize = new PVector(width, height / 15.0);
    final PVector infoTextPos = new PVector(0.0, height / 2.0 - infoTextSize.y / 2.0);
    
    Label infoLabel = new Label(currentStyle.lightFont, infoText, infoTextPos, infoTextSize, currentStyle.white, CENTER, CENTER);
    addElement(infoLabel);
  }
}
