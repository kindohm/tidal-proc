import java.util.Map;
import peasy.*;
import oscP5.*;
import netP5.*;

HashMap<String, Scene> scenesHash;
Scene[] scenesArray;
Scene currentScene;
Scene lastScene;
int sceneIndex = 0;
String sceneName = "scene1";
float currentMouseWheelCount;
OscP5 oscP5;
NetAddress myRemoteLocation;
PeasyCam cam;
float oscA, oscB, oscC, oscHit, oscFade;

void setup() {
  //fullScreen(P3D);
  size(800, 600, P3D);

  cam = new PeasyCam(this, 500);

  scenesHash = new HashMap<String, Scene>();

  scenesArray = new Scene[5];
  scenesArray[0] = new Scene1();
  scenesArray[1]= new Scene1b();
  scenesArray[2] = new Scene2();
  scenesArray[3] = new Scene2b();
  scenesArray[4] = new Scene3();

  for (int i = 0; i < scenesArray.length; i++) {
    scenesHash.put(scenesArray[i].getName(), scenesArray[i]);
  }

  currentScene = scenesArray[0];

  oscP5 = new OscP5(this, 5000);
  myRemoteLocation = new NetAddress("127.0.0.1", 5000);
}

void oscEvent(OscMessage msg) {
  println("HERE?");
  
  // msg.print();
  
  if (msg.checkAddrPattern("/proc_osc")==true) {

    oscHit = msg.get(1).floatValue();
    sceneName = msg.get(2).stringValue();
    oscA = msg.get(3).floatValue();
    oscB = msg.get(4).floatValue();
    oscC = msg.get(5).floatValue();
    oscFade = msg.get(6).floatValue();

    msg.print();

    //dirty = true;
    doHitOsc();
  }
}

Scene getScene() {
  //return currentScene;
  return scenesHash.get(sceneName);
}

void draw() {
  background(0); 
  Scene scene = getScene();

  if (scene == null) return;

  if (scene != lastScene) {
    scene.init();
  }

  scene.draw();
  lastScene = scene;
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
    scene.hit(1, a, b, c, 0.5);
  } else {
    scene.hit(0, a, b, c, 0.5);
  }
}

void doHitOsc() {
  Scene scene = getScene();
  scene.hit(oscHit, oscA, oscB, oscC, oscFade);
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