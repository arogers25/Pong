class Paddle extends GameObject {
  int upKey, downKey;
  
  Paddle(PVector pos, PVector size, int upKey, int downKey) {
    super(pos, size);
    this.upKey = upKey;
    this.downKey = downKey;
    final float paddleSpeedMultiplier = 3.0; // How long it takes for the paddle to move across the entire screen in seconds
    speed = (height - size.y) / paddleSpeedMultiplier;
    col = currentStyle.white;
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
