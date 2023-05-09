class Paddle extends GameObject {
  
  Paddle(PVector pos) {
    super(pos, new PVector(width / 15.0, height / 12.0), 10.0, currentStyle.white);
  }
  
  void render() {
    pushStyle();
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
  }
  
  void gameTick() {
  }
}
