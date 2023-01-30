class FHitblock extends FGameObject {
  int frame;
  FHitblock(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setName("hitblockTile");
  }
  
  void act() {
    animate();
    collide();
  }
  
  void animate() {
    action = hitblock;
    if (frame >= action.length) frame = 0;
    if (frameCount % objectRefresh == 0) {
      attachImage(hitblock[frame]);
      frame++;
    }
  }
  void collide() {
    if (isTouching("player")) println("true");
  }
}
