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
  float shapeSize = 55;
  float currentFade = 0;
  float currentScale = 1;
  float currentHitVal = 0;
  float vary = 0;
  float currentVary = 0;


  Scene3() {
    name = "scene3";
  }

  void init(String oldSceneName) {
  }

  void hit(float hitVal, float a, float b, float c, float d, float fade) {
    cam.reset(0);
    currentScale = 1;
    currentVary = 0;

    cols = int(map(a, 0, 1, minCols, maxCols));
    rows = int(map(b, 0, 1, minRows, maxRows));
    slots = int(map(c, 0, 1, minSlots, maxSlots));

    vary = map(d, 0, 1, 0, 0.05);

    currentFade = map(fade, 0, 1, 0, 0.02);
    currentHitVal = hitVal;
  }

  void doRotation() {
    cam.rotateY(0.01);
    cam.rotateX(0.002);
  }

  void draw() {    
    postDraw2d();
    doRotation();

    directionalLight(200, 102, 126, 0.15, -0.5, -0.7);    

    noStroke();

    translate(-cols/2*shapeSize, -rows/2*shapeSize, -slots/2*shapeSize);

    for (int slot = 0; slot < slots; slot++) {
      for (int col = 0; col < cols; col++) {
        for (int row = 0; row < rows; row++) {

          // safety!
          if (col >= cols || row >= rows || slot >= slots) return;

          noFill();
          strokeWeight(1);


          translate(col * shapeSize, row * shapeSize, slot * shapeSize);
          rotate(currentVary);

          if (currentHitVal < 0.5) {
            stroke(225, 225, 255);
            drawPyramid();
          } else {
            stroke(0, 255, 0);
            box(shapeSize * 0.6 * currentScale);
          }
          
          rotate(-currentVary);

          translate(-col * shapeSize, -row * shapeSize, -slot * shapeSize);
        }
      }
    }
    translate(cols/2*shapeSize, rows/2*shapeSize, slots/2*shapeSize);
    currentScale -= currentFade;
    currentVary += vary;
  }


  void drawPyramid() {
    float size = shapeSize * 0.4 * currentScale;

    beginShape();

    vertex(-size, size, -size);
    vertex( size, size, -size);
    vertex(   0, -size, 0);

    vertex( size, size, -size);
    vertex( size, size, size);
    vertex(   0, -size, 0);

    vertex( size, size, size);
    vertex(-size, size, size);
    vertex(   0, -size, 0);

    vertex(-size, size, size);
    vertex(-size, size, -size);
    vertex(   0, -size, 0);    

    endShape();
  }
}