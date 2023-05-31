class Paddle extends GameObject {
  private Player controllingPlayer;
  private float directionY, yAdjust;
  
  Paddle(Player controllingPlayer, PVector pos, PVector size) {
    super(pos, size);
    this.controllingPlayer = controllingPlayer;
    setCol(controllingPlayer.getCol());
    final float paddleSpeedMultiplier = 1.0; // How long it takes for the paddle to move across the entire screen in seconds
    speed = (height - size.y) / paddleSpeedMultiplier;
  }
  
  void render() {
    pushStyle();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
    controllingPlayer.updateInput();
    directionY = 0.0;
    int heldKey = controllingPlayer.getHeldKey();
    if (heldKey == UP && pos.y > 0) {
      directionY = -1.0;
    }
    float paddleMaxY = pos.y + size.y;
    if (heldKey == DOWN && paddleMaxY < height && directionY == 0.0) {
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
