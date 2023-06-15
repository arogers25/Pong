HashMap<String, File> soundPaths;

// For draw() see AppEngine.pde
float oldTime = 0.0;
float deltaTime = 0.0; // The time in seconds it takes to draw one frame

void settings() {
  fullScreen();
}

void setup() {
  setupAppEngine();
  setCurrentLayout(new MenuLayout());
  loadDefaultSounds();
}

void loadDefaultSounds() {
  soundPaths = new HashMap();
  final String SOUNDS_PATH = sketchPath() + "/data/sounds/";
  File defaultBounce = new File(SOUNDS_PATH + "defaultBounce.mp3");
  if (defaultBounce.exists()) {
    soundPaths.put("bounceSound", defaultBounce);
  }
  File defaultScore = new File(SOUNDS_PATH + "defaultScore.mp3");
  if (defaultScore.exists()) {
    soundPaths.put("scoreSound", defaultScore);
  }
}

void updateDeltaTime() {
  final float MILLIS_TO_SECONDS = 0.001;
  deltaTime = (millis() - oldTime) * MILLIS_TO_SECONDS;
  oldTime = millis();
}
