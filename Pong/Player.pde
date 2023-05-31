class Player {
  int score = 0;
  int id = -1;
  int upKey, downKey;
  int heldKey = 0;
  
  Player(int upKey, int downKey) {
    this.upKey = upKey;
    this.downKey = downKey;
  }
  
  void updateInput() {
    if (Input.isKeyHeld(upKey)) {
      heldKey = UP;
      return;
    }
    if (Input.isKeyHeld(downKey)) {
      heldKey = DOWN;
      return;
    }
    heldKey = 0;
  }
  
  int getHeldKey() {
    return heldKey;
  }
  
  
}
