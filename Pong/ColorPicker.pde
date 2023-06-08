class ColorPicker extends PositionedElement {
  private color pickedCol;
  private Slider hueSlider;
  private Slider saturationSlider;

  ColorPicker(color pickedCol, PVector pos, PVector size) {
    super(pos, size);
    this.pickedCol = pickedCol;
    addSliders();
  }

  void render() {
    pushStyle();
    fill(pickedCol);
    rect(pos.x, pos.y, size.x, size.y / 2.0);
    popStyle();
  }

  void doInput() {
  }

  void update() {
    super.update();
    updateSliders();
    //saturationSlider.update();
  }

  color getPickedCol() {
    return pickedCol;
  }

  private void addSliders() {
    PVector sliderSize = new PVector(size.x, size.y / 12.0);
    PVector startingSliderPos = new PVector(pos.x, pos.y + size.y / 1.7);

    hueSlider = new Slider(startingSliderPos, sliderSize, currentStyle.white, currentStyle.secondaryColor, hue(pickedCol), 0.0, 255.0);
    
    PVector saturationSliderPos = new PVector(startingSliderPos.x, startingSliderPos.y + sliderSize.y * 2.0);
    saturationSlider = new Slider(saturationSliderPos, sliderSize, currentStyle.white, currentStyle.secondaryColor, saturation(pickedCol), 0.0, 255.0);
  }

  private void updateSliders() {
    hueSlider.update();
    int hueVal = (int)hueSlider.getCurrentValue();
    
    saturationSlider.update();
    int saturationVal = (int)saturationSlider.getCurrentValue();
    
    pushStyle();
    colorMode(HSB);
    pickedCol = color(hueVal, saturationVal, 255);
    popStyle();
  }
}
