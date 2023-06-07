class Label extends PositionedElement {
  private String displayText;
  private PFont displayFont;
  private float adjustedTextSize;
  private float adjustedTextWidth;
  private PVector adjustedPos;
  private color col;
  private int alignX, alignY;
  private boolean hasAdjustedPos = false;

  Label(PFont displayFont, String displayText, PVector pos, PVector size, color col, int alignX, int alignY) {
    super(pos, size);
    this.displayFont = displayFont;
    setDisplayText(displayText);
    this.col = col;
    adjustLabelSize();
    setAlignMode(alignX, alignY);
  }

  Label(PFont displayFont, String displayText, PVector pos, PVector size, color col) {
    super(pos, size);
    this.displayFont = displayFont;
    setDisplayText(displayText);
    this.col = col;
    adjustLabelSize();
    setAlignMode(LEFT, BASELINE);
  }

  private void adjustLabelSize() {
    if (displayText.length() == 0) {
      return;
    }
    final float STARTING_SCALE_FACTOR = 0.60;
    final float SCALE_FIT_PERCENTAGE = 0.80;
    float newAdjustedSize = size.y * STARTING_SCALE_FACTOR;
    if (adjustedTextSize == newAdjustedSize) {
      return;
    }
    pushStyle();
    textFont(displayFont);
    adjustedTextSize = newAdjustedSize;
    textSize(adjustedTextSize);
    if (size.x > 0.0) {
      float currentTextWidth = textWidth(displayText);
      float targetTextWidth = size.x * SCALE_FIT_PERCENTAGE;
      if (currentTextWidth > targetTextWidth) {
        float targetWidthRatio = (targetTextWidth / currentTextWidth);
        adjustedTextSize = targetWidthRatio * adjustedTextSize;
      }
    }
    adjustedTextWidth = textWidth(displayText);
    popStyle();
  }

  private void updateAdjustedPos() {
    if (hasAdjustedPos) {
      return;
    }
    adjustedPos = new PVector();
    adjustedPos.x = alignX == CENTER ? pos.x + size.x / 2.0 : pos.x;
    adjustedPos.y = alignY == CENTER ? pos.y + size.y / 2.0 : pos.y;
    if (size.x <= 0.0) {
      hasAdjustedPos = true;
    }
  }

  void setAlignMode(int alignX, int alignY) {
    this.alignX = alignX;
    this.alignY = alignY;
    updateAdjustedPos();
  }

  String getDisplayText() {
    return displayText;
  }
  
  void setDisplayText(String displayText) {
    this.displayText = displayText;
    if (size.x > 0.0) {
      adjustLabelSize();
    }
  }
  
  float getTextWidth() {
    return adjustedTextWidth;
  }

  void render() {
    if (displayText.length() == 0) {
      return;
    }
    pushStyle();
    fill(col);
    textFont(displayFont);
    textSize(adjustedTextSize);
    textAlign(alignX, alignY);
    updateAdjustedPos();
    text(displayText, adjustedPos.x, adjustedPos.y);
    popStyle();
  }

  void doInput() {
  }
}
