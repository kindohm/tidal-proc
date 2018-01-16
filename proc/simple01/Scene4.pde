class Scene4 extends Scene {

  int rows;
  int cols;
  int maxDim = 11;
  int minDim = 3;
  Scene4Cell[][] table;
  int currentX, currentY;
  int centerX, centerY;
  int currentSquareSize = 0;
  float cellWidth, cellHeight;

  String getName() {
    return "scene4";
  }

  void buildTable() {
    table = new Scene4Cell[cols][rows];
    centerX = cols/2 + 1;
    centerY = rows/2 + 1;
  }

  void hit(float hitVal, float a, float b, float c, float d, float fade) {

    int oldCols = cols;
    int oldRows = rows;

    cols = int(map(a, 0, 1, minDim, maxDim));
    rows = int(map(a, 0, 1, minDim, maxDim));

    // ONLY permit odd numbers of rows and cols
    if (cols % 2 == 0) cols++;
    if (rows % 2 == 0) rows++;

    cellWidth = width/cols;
    cellHeight = height/rows;

    if (table == null || cols != oldCols || rows != oldRows) {
      buildTable();
      currentX = centerX;
      currentY = centerY;
      table[currentX][currentY] = new Scene4Cell();
      currentSquareSize = 1;
      return;
    } 
    
    advance();
    table[currentX][currentY] = new Scene4Cell();
    
    println(currentX + ", " + currentY);
  }

  void advance() {

    int diffX = currentX - centerX;
    int diffY = currentY - centerY;

    // begin, center
    if (diffX == 0 && diffY == 0) {
      currentX++;
      return;
    }

    // end
    if (diffX == currentSquareSize && diffY == currentSquareSize) {
      currentX++;
      currentSquareSize++;
      return;
    }

    // right side
    if (diffX == currentSquareSize && diffY < currentSquareSize && diffY >= currentSquareSize) {
      currentY--;
      return;
    }

    // top side
    if (diffY == -currentSquareSize && diffX <= currentSquareSize && diffX >= -currentSquareSize) {
      currentX--;
      return;
    }

    // left side
    if (diffX == -currentSquareSize && diffY >= -currentSquareSize && diffY <= currentSquareSize) {
      currentY++;
      return;
    }

    // bottom side
    if (diffY == currentSquareSize && diffX >= -currentSquareSize && diffX < currentSquareSize) {
      currentX++;
      return;
    }
  }


  void draw() {

    preDraw2d();

    noFill();
    stroke(255);
    strokeWeight(5);

    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        Scene4Cell cell = table[x][y];

        if (cell == null) break;

        rect(cellWidth*x, cellHeight*y, cellWidth, cellHeight);
      }
    }


    postDraw2d();
  }
}

public class Scene4Cell {
}