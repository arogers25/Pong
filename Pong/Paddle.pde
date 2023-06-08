class Paddle extends GameObject {
  private Player controllingPlayer;
  private float directionY, yAdjust;
  private LerpColor bounceEffectCol;
  
  Paddle(Player controllingPlayer, PVector pos, PVector size) {
    super(pos, size);
    this.controllingPlayer = controllingPlayer;
    setCol(controllingPlayer.getCol());
    final float paddleSpeedMultiplier = 1.0; // How long it takes for the paddle to move across the entire screen in seconds
    speed = (height - size.y) / paddleSpeedMultiplier;
    final float LERP_TIME_MULT = 1.0;
    bounceEffectCol = new LerpColor(color(255, 0), LERP_TIME_MULT);
  }
  
  void render() {
    pushStyle();
    noStroke();
    fill(col);
    rect(pos.x, pos.y, size.x, size.y);
    if (bounceEffectCol.shouldUpdate()) {
      bounceEffectCol.updateLerp();
      fill(bounceEffectCol.getCol());
      rect(pos.x, pos.y, size.x, size.y);
    }
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
  
  void onCollide() {
    final float STARTING_COLOR_PROGRESS = 0.3;
    bounceEffectCol.startLerp(currentStyle.white, STARTING_COLOR_PROGRESS);
  }
  
  void gameTick() {
    pos.y += yAdjust;
  }
}
