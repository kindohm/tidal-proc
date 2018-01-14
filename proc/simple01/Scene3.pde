class Scene3 extends Scene {

  int rows = 5;
  int cols = 5;
  int slots = 5;
  int minCols = 1;
  int maxCols = 10;
  int minRows = 1;
  int maxRows = 10;
  int minSlots = 1;
  int maxSlots = 10;
  int currentRow = 0, currentCol = 0, currentSlot = 0, shapeSize = 55;
  int red1 = 255, green1 = 100, blue1 = 200, red2 = 255, green2 = 200, blue2 = 120;
  Scene3Cell[][][] table;

  Scene3() {
    name = "scene3";
    buildTable();
  }

  void init() {
  }

  void buildTable() {
    currentRow = 0;
    currentCol = 0;
    currentSlot = 0;
    table = new Scene3Cell[cols][rows][slots];
  }

  void hit(float hitVal, float a, float b, float c, float fade) {
    //cam.reset(0);
    
    int newCols = int(map(a, 0, 1, minCols, maxCols));
    int newRows = int(map(b, 0, 1, minRows, maxRows));
    int newSlots = int(map(c, 0, 1, minSlots, maxSlots));
    float newFade = map(fade, 0, 1, 0, 0.1);

    if (newCols != cols || newRows != rows || newSlots != slots) {
      rows = newRows;
      cols = newCols;
      slots = newSlots;
      buildTable();
    }

    if (currentRow == 0 && currentCol == 0 && currentSlot == 0) {
      buildTable();
    }

    table[currentCol][currentRow][currentSlot] = new Scene3Cell(hitVal, newFade);

    currentRow++;

    if (currentRow >= rows) {
      currentRow = 0;
      currentCol++;
    }

    if (currentCol >= cols) {
      currentCol = 0;
      currentSlot++;
    }

    if (currentSlot >= slots) {
      currentSlot = 0;
    }
  }

  void doRotation() {
    cam.rotateY(0.01);
    //cam.rotateX(0.001);
  }

  void draw() {    
    postDraw2d();
    doRotation();
    sphereDetail(10);
    //lights();
    directionalLight(200, 102, 126, 0.15, -0.5, -0.7);

    float hitVal, strokeVal, opacity;
    Scene3Cell cell;

    if (table == null) {
      return;
    }

    noStroke();


    translate(-cols/2*shapeSize, -rows/2*shapeSize, -slots/2*shapeSize);

    for (int slot = 0; slot < slots; slot++) {
      for (int col = 0; col < cols; col++) {
        for (int row = 0; row < rows; row++) {

          // safety!
          if (col >= cols || row >= rows || slot >= slots) return;

          cell = table[col][row][slot];
          if (cell != null) {
            hitVal = cell.getHitVal();
          } else {
            break;
          }

          noFill();
          strokeWeight(1);
          stroke(0, 175, 255);
          translate(col * shapeSize, row * shapeSize, slot * shapeSize);

          drawPyramid(cell.scale);


          translate(-col * shapeSize, -row * shapeSize, -slot * shapeSize);

          if (cell != null) cell.fade();
        }
      }
    }
    translate(cols/2*shapeSize, rows/2*shapeSize, slots/2*shapeSize);
  }


  void drawPyramid(float scale) {
    float size = shapeSize * 0.25 * scale;

    beginShape();
    
    vertex(-size, -size, -size);
    vertex( size, -size, -size);
    vertex(   0, 0, size);

    vertex( size, -size, -size);
    vertex( size, size, -size);
    vertex(   0, 0, size);

    vertex( size, size, -size);
    vertex(-size, size, -size);
    vertex(   0, 0, size);

    vertex(-size, size, -size);
    vertex(-size, -size, -size);
    vertex(   0, 0, size);    

    endShape();
  }
}

class Scene3Cell {
  float hitVal;
  float fadeRate;
  float scale = 1;

  Scene3Cell(float newHitVal, float newFadeRate) {
    hitVal = newHitVal;
    fadeRate = newFadeRate;
  }

  float getHitVal() {
    return hitVal;
  }
  
  float getScale(){
    return scale;
  }
  
  void fade() {
    scale *= (1-fadeRate);
  }
}