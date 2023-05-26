class ScoreZone extends PositionedElement {
  private Ball targetBall;
  private int side;
  private boolean entered;
  
  ScoreZone(int side, PVector pos, PVector size) {
    super(pos, size);
    this.side = side;
  }
  
  void render() {
    pushStyle();
    fill(255, 100);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();
  }
  
  void doInput() {
  }
  
  private boolean ballCollides() {
    PVector ballPos = targetBall.getPos();
    PVector ballMaxs = PVector.add(ballPos, targetBall.getSize());
    PVector maxs = PVector.add(pos, size);
    return (ballMaxs.x >= pos.x && ballPos.x <= maxs.x && ballMaxs.y >= pos.y && ballPos.y <= maxs.y);
  }
  
  int hasBallEntered() {
    return entered ? side : -1;
  }
  
  void setTargetBall(Ball targetBall) {
    if (targetBall == null) {
      return;
    }
    this.targetBall = targetBall;
  }
  
  void update() {
    super.update();
    entered = (targetBall != null && ballCollides());
  }
}
