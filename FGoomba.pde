class FGoomba extends FGameObject {

  int direction = L;
  int speed = 75;
  int lives;
  int frame;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setName("goomba");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    action = goombas;
    if (frame >= action.length) frame = 0;
    if (frameCount % playerRefresh == 0) {
      if (direction == R) attachImage(goombas[frame]);
      if (direction == L) attachImage(reverseImage(goombas[frame]));
      frame++;
    }
  }

  void collide() {
    if (isTouching("wallTile")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
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
}
