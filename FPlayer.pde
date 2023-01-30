class FPlayer extends FGameObject {
  int lives = 3;
  int frame;
  int direction = R;
  FPlayer() {
    super();
    setPosition(spawnX, spawnY);
    setName("player");
    setRotatable(false);
    attachImage(idle[0]);
  }

  void act() {
    handleInput();
    handleCollisions();
    animate();
    gameover();
    win();
  }

  void handleInput() {
    float vX = getVelocityX();
    float vY = getVelocityY();
    if (vY < 0.1) {
      action = idle;
    }
    if (aKey) {
      action = run;
      if (!swimming) setVelocity(-150, vY);
      if (swimming) setVelocity(-50, vY);
    }
    if (dKey) {
      if (!swimming) setVelocity(150, vY);
      if (swimming) setVelocity(50, vY);
      action = run;
    }

    if (wKey && isTouching("grassTile") || wKey && isTouching("bridgeTile") || wKey && isTouching("stoneTile") || wKey && isTouching("iceTile") || wKey && isTouching("leafTile")) {
      action = jump;
      setVelocity(vX, -375);
    }

    if (wKey && isTouching("waterTile")) {
      setVelocity(vX, -75);
    }

    if (abs(vY) > 0.1) {
      action = jump;
    }
    if (getVelocityX() > 1) {
      direction = R;
    } else if (getVelocityX() < -1) {
      direction = L;
    }
  }

  void handleCollisions() {
    if (isTouching("spikeTile") || isTouching("lavaTile") || isTouching("hammer")) {
      setPosition(spawnX, spawnY);
      lives = lives -1;
    }
    if (isTouching("waterTile")) {
      swimming = true;
    } else swimming = false;
  }

  void checkForCollisions() {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
    }
  }

  void gameover() {
    textFont(pixelFont);
    textSize(60);
    if (lives <= 0) {
      rectMode(CENTER);
      fill(white);
      rect(width/2, height/2, width+25, height+25);
      fill(255, 0, 0);
      textWithBorderString("GAMEOVER", 0, flagRed, width/2, height/2);
    }
  }
  
  void win() {
    if (score == 5) {
      rectMode(CENTER);
      fill(white);
      rect(width/2, height/2, width+25, height+25);
      fill(0, 255, 0);
      textSize(75);
      textWithBorderString("WINNER", 0, leafGreen, width/2, height/2);
    }
  }
  
  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % playerRefresh == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
}
