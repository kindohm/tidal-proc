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