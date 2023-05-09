class Paddle extends GameObject {
  int upKey, downKey;
  
  Paddle(PVector pos, PVector size, int upKey, int downKey) {
    super(pos, size, 300.0, currentStyle.white);
    this.upKey = upKey;
    this.downKey = downKey;
  }
  
  void render() {
    pushStyle();
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
    if (Input.isKeyHeld(upKey)) {
      pos.y -= speed * deltaTime;
      return;
    }
    if (Input.isKeyHeld(downKey)) {
      pos.y += speed * deltaTime;
      return;
    }
  }
  
  void gameTick() {
  }
}
