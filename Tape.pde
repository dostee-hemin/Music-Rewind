class Tape {
  float x, y;
  float angle;
  float radius;

  boolean isCollected;

  Tape(float x, float y) {
    this.x = x;
    this.y = y;

    angle = random(TWO_PI);
    radius = 50;
  }

  void display() {
    if (radius > 0) {
      pushMatrix();
      translate(x, y);
      rotate(angle);
      image(tape, 0, 0, radius, radius);
      popMatrix();

      angle += 0.07;
    }

    if (isCollected) {
      if (radius > 0) {
        radius-=10;
      } else if (radius > -10) {
        for (int i=0; i<50; i++) {
          allParticles.add(new TapeParticle(x, y, random(TWO_PI)));
        }
        if (numberOfPoints < 3) {
          if(canPlayEffects)
          collectTape[0].trigger();
        } else {
          if(canPlayEffects)
          collectTape[1].trigger();
        }
        radius-=10;
      }
    }
  }

  boolean getsCollected() {
    return dist(player.location.x, player.location.y, x, y) < 50;
  }
}
