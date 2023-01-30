class FHammerbro extends FGameObject {
  int direction = R;
  int speed = 75;
  int lives;
  int frame;
  int k = 75;
  int l = 0;

  FHammerbro(float x, float y) {
    super();
    setPosition(x, y);
    setName("objecthammerbro");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
    throwHammer();
  }

  void animate() {
    action = hammerbro;
    if (frame >= action.length) frame = 0;
    if (frameCount % playerRefresh == 0) {
      if (direction == R) attachImage(hammerbro[frame]);
      if (direction == L) attachImage(reverseImage(hammerbro[frame]));
      frame++;
    }
  }

  void collide() {
    k++;
    if (k == 150) {
      direction = -direction;
      k = 0;
    }
    l++;
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/1.25) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.lives--;
        player.setPosition(spawnX, spawnY);
      }
    }
  }

  void move() {
    float vY = getVelocityY();
    setVelocity(speed*direction, vY);
  }

  void throwHammer() {
    l++;
    if (l == 220) {
      FBox h = new FBox(gridSize, gridSize);
      h.setPosition(getX(), getY());
      h.attachImage(hammer);
      h.setSensor(true);
      h.setVelocity(random(-250, 250), -300);
      h.setAngularVelocity(75);
      h.setName("hammer");
      world.add(h);
      
      l = 0;
    }
  }
}
