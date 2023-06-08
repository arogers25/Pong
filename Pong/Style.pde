final class Style {
  final PVector center = new PVector(width / 2.0, height / 2.0);
  
  final color white = color(255);
  final color black = color(0);
  final color secondaryColor = color(70);
  
  final PFont regularFont = createFont("fonts/Rubik-Regular.ttf", 32);
  final PFont lightFont = createFont("fonts/Rubik-Light.ttf", 32);
  
  final color defaultLeftPaddleCol = color(255, 0, 0);
  final color defaultRightPaddleCol = color(0, 0, 255);
}
