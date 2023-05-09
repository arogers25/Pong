// For draw() see AppEngine.pde
float oldTime = 0.0;
float deltaTime = 0.0; // The time in seconds it takes to draw one frame

void settings() {
  fullScreen();
}

void setup() {
  setupAppEngine();
  setCurrentLayout(new MenuLayout());
}
