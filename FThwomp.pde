class FThwomp extends FGameObject {
  float randomX;
  float randomY;
  int k = 0;
  int p = 0;
  int r = 0;
  float xSet;
  float ySet;
  boolean triggered;

  FThwomp(int w, int h, float x, float y) {
    super(w, h);
    setPosition(x, y);
    setName("thwomp");
    setRotatable(false);
    setStatic(true);
    xSet = x;
    ySet = y;
  }

  void act() {
    animate();
    collide();
  }

  void animate() {
    randomX = xSet + (float) random(-2, 2);
    randomY = ySet + (float) random(-2, 2);
    attachImage(thwomp0);
    if (getX() - player.getX() < gridSize && getX() - player.getX() > -gridSize && player.getY() > getY() && getY() < ySet) {
      triggered = true;
    }
    if (getY() == ySet + 5*gridSize) {
      r++;
    }
    if (!triggered) {
      setStatic(true);
      k = 0;
      if (getY() >= ySet) {
        int b = 0;
        b++;
        setPosition(xSet, getY()-b);
      }
    }
    if (triggered) {
      p = 0;
      attachImage(thwomp1);
      k++;
      if (k < 25) {
        setPosition(randomX, randomY);
      }
      if (k == 25) {
        setPosition(xSet, ySet);
      }
      if (k > 25) {
        setStatic(false);
        setVelocity(0, 500);
      }
    }
    if (getY() > 1519) {
      triggered = false;
    }
  }

  void collide() {
    if (isTouching("player")) {
      player.lives --;
      player.setPosition(spawnX, spawnY);
    }
  }
}
