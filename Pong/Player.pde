class Player {
  private String name;
  private int score;
  private int upKey, downKey;
  private int heldKey;
  private color col;
  private float resetAngle; // The angle the ball will reset to if this Player scores
  
  Player(String name, int upKey, int downKey, float resetAngle, color col) {
    this.name = name;
    this.upKey = upKey;
    this.downKey = downKey;
    this.resetAngle = resetAngle;
    this.col = col;
  }
  
  String getName() {
    return name;
  }
  
  void setName(String name) {
    this.name = name;
  }
  
  int getScore() {
    return score;
  }
  
  void setScore(int score) {
    this.score = max(0, score);
  }
  
  void increaseScore(int increase) {
    setScore(score + increase);
  }
  
  void resetScore() {
    setScore(0);
  }
  
  float getResetAngle() {
    return resetAngle;
  }
  
  void updateInput() {
    heldKey = 0;
    if (Input.isKeyHeld(upKey)) {
      heldKey = UP;
      return;
    }
    if (Input.isKeyHeld(downKey)) {
      heldKey = DOWN;
      return;
    }
  }
  
  int getHeldKey() {
    return heldKey;
  }
  
  int getCol() {
    return col;
  }
  
  void setCol(color col) {
    this.col = col;
  }
}
