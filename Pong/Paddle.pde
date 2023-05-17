class Paddle extends GameObject {
  private int upKey, downKey;
  private float directionY, yAdjust;
  
  Paddle(PVector pos, PVector size, int upKey, int downKey) {
    super(pos, size);
    this.upKey = upKey;
    this.downKey = downKey;
    final float paddleSpeedMultiplier = 1.0; // How long it takes for the paddle to move across the entire screen in seconds
    speed = (height - size.y) / paddleSpeedMultiplier;
    col = currentStyle.white;
  }
  
  void render() {
    pushStyle();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
    directionY = 0.0;
    if (Input.isKeyHeld(upKey) && pos.y > 0) {
      directionY = -1.0;
    }
    float paddleMaxY = pos.y + size.y;
    if (Input.isKeyHeld(downKey) && paddleMaxY < height && directionY == 0.0) {
      directionY = 1.0;
    }
    yAdjust = directionY * speed * deltaTime;
  }
  
  float getYAdjust() {
    return yAdjust;
  }
  
  void gameTick() {
    pos.y += yAdjust;
  }
}
