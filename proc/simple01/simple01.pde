import java.util.Map;

HashMap<String, Scene> scenes;
String sceneName = "scene1";
float currentMouseWheelCount;

void setup() {
  size(500, 500);
  scenes = new HashMap<String, Scene>();
  scenes.put("scene1", new Scene1());
}

void draw() {
  background(0);
  Scene scene = scenes.get(sceneName);
  scene.draw();
}

void mousePressed() {
  doHit();
}

void keyPressed() {
  if (key == ' '){
    doHit();
  }
}

void doHit() {
  float c = map(currentMouseWheelCount, 0, 100, 0, 1);
  float a = map(mouseX, 0, width, 0, 1);
  float b = map(mouseY, 0, height, 0, 1);
  Scene scene = scenes.get(sceneName);
  if (mouseButton == LEFT) {
    scene.hit(1, a, b, c);
  } else {
    scene.hit(0.5, a, b, c);
  }
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  currentMouseWheelCount -= e;
  if (currentMouseWheelCount < 0) {
    currentMouseWheelCount = 0;
  } else if (currentMouseWheelCount > 100) {
    currentMouseWheelCount = 100;
  }
}