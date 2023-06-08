abstract class GameObject extends PositionedElement {
  protected float speed;
  protected color col;
  protected boolean shouldUpdate = true;
  
  GameObject(PVector pos, PVector size) {
    super(pos, size);
  }
  
  float getSpeed() {
    return col;
  }
  
  void setSpeed(float speed) {
    this.speed = speed;
  }
  
  color getCol() {
    return col;
  }
  
  void setCol(color col) {
    this.col = col;
  }
  
  void setShouldUpdate(boolean shouldUpdate) {
    this.shouldUpdate = shouldUpdate;
  }
  
  abstract void gameTick();
  
  void update() {
    if (shouldUpdate) {
      gameTick();
    }
    super.update();
  }
}
