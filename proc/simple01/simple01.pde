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

abstract class Scene {

  void draw() {
  }

  void hit(float hitVal, float a, float b, float c) {
  }
}

class Scene1 extends Scene {

  int rows = 10;
  int cols = 40;
  int minCols = 1;
  int maxCols = 100;
  int minRows = 1;
  int maxRows = 100;
  int currentRow = 0, currentCol = 0, rectWidth, rectHeight;
  float stroke;
  Scene1Cell[][] table;

  Scene1() {
    buildTable();
  }

  void buildTable() {
    currentRow = 0;
    currentCol = 0;
    rectWidth = width/cols;
    rectHeight = height/rows;
    table = new Scene1Cell[cols][rows];
  }

  void hit(float hitVal, float a, float b, float c) {

    stroke = map(c, 0, 1, 1, 15);

    int newCols = int(map(a, 0, 1, minCols, maxCols));
    int newRows = int(map(b, 0, 1, minRows, maxRows));

    if (newCols != cols || newRows != rows) {
      rows = newRows;
      cols = newCols;
      buildTable();
    }

    if (currentRow == 0 && currentCol == 0) {
      buildTable();
    }

    table[currentCol][currentRow] = new Scene1Cell(hitVal, stroke);

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
    float hitVal, strokeVal;
    Scene1Cell cell;

    if (table == null) {
      return;
    }

    stroke(0);

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        cell = table[col][row];
        if (cell != null) {
          hitVal = cell.getHitVal();
          strokeVal = cell.getStroke();
        } else {
          hitVal = 0;
          strokeVal = 1;
        }

        strokeWeight(strokeVal);
        if (hitVal > 0.5) {
          fill(100, 100, 255, 200);
        } else if (hitVal > 0) {
          fill(0, 255, 255, 200);
        } else {
          fill(0, 0, 0);
        }
        rect(col * rectWidth, row * rectHeight, rectWidth, rectHeight);
      }
    }
  }
}

class Scene1Cell {
  float stroke;
  float hitVal;

  Scene1Cell(float newHitVal, float newStroke) {
    stroke = newStroke;
    hitVal = newHitVal;
  }

  float getStroke() {
    return stroke;
  }

  float getHitVal() {
    return hitVal;
  }
}