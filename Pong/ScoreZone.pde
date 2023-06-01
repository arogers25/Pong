class ScoreZone extends PositionedElement {
  private Ball targetBall;
  private Player controllingPlayer;
  private boolean entered;
  
  ScoreZone(Player controllingPlayer, Ball targetBall, PVector pos, PVector size) {
    super(pos, size);
    this.controllingPlayer = controllingPlayer;
    this.targetBall = targetBall;
  }
  
  void render() {
    /*pushStyle();
    fill(255, 100);
    rect(pos.x, pos.y, size.x, size.y);
    popStyle();*/
  }
  
  void doInput() {
  }
  
  private boolean ballCollides() {
    PVector ballPos = targetBall.getPos();
    PVector ballMaxs = PVector.add(ballPos, targetBall.getSize());
    PVector maxs = PVector.add(pos, size);
    return (ballMaxs.x >= pos.x && ballPos.x <= maxs.x && ballMaxs.y >= pos.y && ballPos.y <= maxs.y);
  }
  
  boolean hasEntered() {
    return entered;
  }
  
  Player getControllingPlayer() {
    return controllingPlayer;
  }
  
  void update() {
    super.update();
    entered = (targetBall != null && ballCollides());
  }
}
