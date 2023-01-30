class FFlag extends FGameObject {
  int frame;
  int flagX;
  int flagY;
  int flagNumber = 0;
  int k = 1;
  float xSet;
  float ySet;
  
  FFlag(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setName("flagTile");
    xSet = x;
    ySet = y;
  }

  void act() {
    animate();
    collide();
  }

  void animate() {
    action = flag;
    if (frame >= action.length) frame = 0;
    if (frameCount % objectRefresh == 0) {
      attachImage(flag[frame]);
      frame++;
    }
  }
  
  void collide() {
    if (isTouching("player") && k == 1) {
      flagNumber++;
      k = 0;
      if (flagNumber == 1) {
        spawnX = xSet;
        spawnY = ySet;
      }
      if (flagNumber == 2) {
        spawnX = xSet;
        spawnY = ySet;
      }
    }
  }
}
