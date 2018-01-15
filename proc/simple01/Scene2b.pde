class Scene2b extends Scene2 {
  Scene2b() {
    name = "scene2b";
    red1 = 0; 
    green1 = 255; 
    blue1 = 0;
    red2 = 255; 
    green2 = 255; 
    blue2 = 0;
  }

  void init(String oldSceneName) {
    //cam.reset(0);
    //cam.rotateY(-1);
    //cam.rotateX(0);
    //cam.rotateZ(0);
    //cam.rotateY(-3.33);
  }

  void doRotation() {
    cam.rotateY(0.01);
  }
}