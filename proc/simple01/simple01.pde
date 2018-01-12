import java.util.Map;

HashMap<String, Scene> scenes;
String sceneName = "scene1";

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
  Scene scene = scenes.get(sceneName);
  if (mouseButton == LEFT) {
    scene.hit(1);
  } else {
    scene.hit(0.5);
  }
}

abstract class Scene {

  void draw() {
  }

  void hit(float hitVal) {
  }
}

class Scene1 extends Scene {

  int rows = 10;
  int cols = 40;
  int currentRow = 0, currentCol = 0, rectWidth, rectHeight;
  float[][] table;

  Scene1() {
    buildTable();
  }

  void buildTable() {
    currentRow = 0;
    currentCol = 0;
    rectWidth = width/cols;
    rectHeight = height/rows;
    table = new float[cols][rows];
  }

  void hit(float hitVal) {
    if (currentRow == 0 && currentCol == 0) {
      buildTable();
    }

    table[currentCol][currentRow] = hitVal;

    currentRow++;

    if (currentRow >= rows) {
      currentRow = 0;
      currentCol++;
    }

    if (currentCol >= cols) {
      currentCol = 0;
    }
  }

  void draw() {

    if (table == null) {
      return;
    }

    stroke(0);
    strokeWeight(5);
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        if (table[col][row] > 0.5) {
          fill(100, 100, 255, 200);
        } else if (table[col][row] > 0) {
          fill(0, 255, 255, 200);
        } else {
          fill(0, 0, 0);
        }
        rect(col * rectWidth, row * rectHeight, rectWidth, rectHeight);
      }
    }
  }
}