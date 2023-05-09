class GameLayout extends Layout {
  GameLayout() {
    super();
    addElement(new Paddle(new PVector(width * (3.0 / 4.0), height / 2.0)));
  }
  
  protected final void drawBackground() {
    background(currentStyle.black);
  }
}
