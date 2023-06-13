class SoundSettingsLayout extends Layout {
  SoundSettingsLayout() {
    super();
    addMenuButtons();
  }

  void drawBackground() {
    background(currentStyle.black);
  }

  void onBackToMenuButtonPressed() {
    currentLayout = new MenuLayout();
  }

  private void addMenuButtons() {
    final PFont BUTTON_FONT = currentStyle.regularFont;
    final color BUTTON_COLOR = currentStyle.secondaryColor;
    final PVector menuButtonSize = new PVector(width / 7.0, height / 12.0);

    RectangleButton backToMenuButton = new RectangleButton(BUTTON_FONT, "Back to Menu", new PVector(), menuButtonSize, BUTTON_COLOR, currentStyle.white, "onBackToMenuButtonPressed");
    addElement(backToMenuButton);
  }
}
