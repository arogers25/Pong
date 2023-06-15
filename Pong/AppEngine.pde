// This file contains all necessary methods for Elements to display and be controlled properly
// This is intended to make new projects able to run almost instantly with the proper files copied
// There should be no modifications to this code, and all unique code for a project should be contained in its main file or in a different file 

import java.lang.reflect.Method; // For element click events
import ddf.minim.*;

Minim minim;
Style currentStyle;
Layout currentLayout;
boolean shouldExitToMenu = false;

void setupAppEngine() {
  Input.setAppInst(this);
  minim = new Minim(this);
  currentStyle = new Style();
}

void setCurrentLayout(Layout currentLayout) {
  this.currentLayout = currentLayout;
}

// Default Processing method overrides

void draw() {
  updateDeltaTime();
  if (currentLayout != null) {
    currentLayout.update();
  }
  Input.updateStates();
  if (shouldExitToMenu) {
    setCurrentLayout(new MenuLayout());
    shouldExitToMenu = false;
  }
}

void exit() {
  if (Input.isKeyPressed(ESC)) {
    shouldExitToMenu = true;
    return;
  } else {
    super.exit();
  }
}

void keyPressed() {
  Input.doKeyPressed();
}

void keyReleased() {
  Input.doKeyReleased();
}

void mousePressed() {
  Input.doMousePressed();
}

void mouseReleased() {
  Input.doMouseReleased();
}
