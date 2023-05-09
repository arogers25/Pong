abstract class GameObject extends PositionedElement {
  protected float speed;
  protected color col;
  
  GameObject(PVector pos, PVector size, float speed, color col) {
    super(pos, size);
    this.speed = speed;
    this.col = col;
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
  
  abstract void gameTick();
  
  void update() {
    gameTick();
    super.update();
  }
}
