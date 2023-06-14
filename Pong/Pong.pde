HashMap<String, File> songPaths;

// For draw() see AppEngine.pde
float oldTime = 0.0;
float deltaTime = 0.0; // The time in seconds it takes to draw one frame

void settings() {
  fullScreen();
}

void setup() {
  setupAppEngine();
  songPaths = new HashMap();
  setCurrentLayout(new MenuLayout());
}

void updateDeltaTime() {
  final float MILLIS_TO_SECONDS = 0.001;
  deltaTime = (millis() - oldTime) * MILLIS_TO_SECONDS;
  oldTime = millis();
}
