import java.util.Map;

HashMap<String, Scene> scenesHash;
Scene[] scenesArray;
Scene currentScene;
int sceneIndex = 0;
String sceneName = "scene1b";
float currentMouseWheelCount;

void setup() {
  size(500, 500);
  scenesHash = new HashMap<String, Scene>();

  scenesArray = new Scene[2];
  scenesArray[0] = new Scene1();
  scenesArray[1]= new Scene1b();
  
  for (int i = 0; i < scenesArray.length; i++){
    scenesHash.put(scenesArray[i].getName(), scenesArray[i]);
  }
  
  currentScene = scenesArray[0];
}

Scene getScene() {
  return currentScene;
}

void draw() {
  background(0); 
  getScene().draw();
}

void mousePressed() {
  doHit();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      sceneIndex++;
      if (sceneIndex >= scenesArray.length) sceneIndex = 0;      
      currentScene = scenesArray[sceneIndex];
    } else if (keyCode == LEFT) {
      sceneIndex--;
      if (sceneIndex < 0) sceneIndex = scenesArray.length - 1;
      currentScene = scenesArray[sceneIndex];
    }
  } else {
    if (key == ' ') {
      doHit();
    }
  }
}

void doHit() {
  float c = map(currentMouseWheelCount, 0, 100, 0, 1);
  float a = map(mouseX, 0, width, 0, 1);
  float b = map(mouseY, 0, height, 0, 1);
  Scene scene = getScene();
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