class LerpColor {
  private color currentCol, startCol, endCol;
  private float timeMultiplier;
  private float progress;
  
  LerpColor(color endCol, float timeMultiplier) {
    this.endCol = endCol;
    startCol = endCol;
    this.timeMultiplier = timeMultiplier;
    progress = 0.0;
  }
  
  boolean shouldUpdate() {
    return currentCol != endCol;
  }
  
  void startLerp(color startCol) {
    this.startCol = startCol;
    currentCol = startCol;
  }
  
  void startLerp(color startColor, float startingProgress) {
    startLerp(startColor);
    progress = startingProgress;
  }
  
  void updateLerp() {
    progress += deltaTime * timeMultiplier;
    currentCol = lerpColor(startCol, endCol, progress);
  }
  
  color getCol() {
    return currentCol;
  }
}
