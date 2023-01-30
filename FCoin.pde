class FCoin extends FGameObject {
  int frame;
  FCoin(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setName("coinTile");
  }

  void act() {
    animate();
    collisions();
  }

  void animate() {
    action = coins;
    if (frame >= action.length) frame = 0;
    if (frameCount % objectRefresh/1.5 == 0) {
      attachImage(coins[frame]);
      frame++;
    }
  }

  void collisions() {
    if (isTouching("player")) {
      score = score + 1;
      world.remove(this);
      enemies.remove(this);
    }
  }
}
