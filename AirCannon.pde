class AirCannon {
  PVector position;
  int direction;
  float angle;
  float maxAngle;
  int maxDistance;
  int counter, start, end;

  AirCannon(float x, float y, int direction, float angle, int start, int lowestCount, int maxDistance) {
    position = new PVector(x, y);
    this.direction = direction;
    this.angle = angle;

    maxAngle = PI/8;
    this.maxDistance = maxDistance;
    this.start = start;
    this.end = start-lowestCount;
    counter = start;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle+PI);
    image(horns[(direction+1)/2], 0, 0);
    popMatrix();
  }

  void update() {
    counter--;

    if (counter == 0) {
      if (abs(position.x-player.location.x) < 500/drawScale && abs(position.y-player.location.y) < 400/drawScale) {
        if(canPlayEffects)
        airFlow[(direction+1)/2].trigger();

        for (int i=0; i<50; i++) {
          if (direction == 1) {
            allParticles.add(new AirParticle(position.x, position.y, angle+random(-maxAngle, maxAngle)));
          } else {
            PVector newPos = PVector.fromAngle(angle + random(-maxAngle, maxAngle)).mult(random(100, 150)).add(position);
            PVector target = PVector.sub(position, newPos);
            allParticles.add(new AirParticle(newPos.x, newPos.y, target.heading()));
          }
        }
      }


      PVector thisToPlayer = PVector.sub(player.location, position);
      if (PVector.angleBetween(thisToPlayer, PVector.fromAngle(angle)) < maxAngle && thisToPlayer.mag() < maxDistance) {
        thisToPlayer.setMag(20000 * direction);
        Vec2 force = new Vec2(thisToPlayer.x, -thisToPlayer.y);
        player.body.applyForceToCenter(force);
      }

      for (Box b : boxes) {
        if (b.getClass() == MovableBox.class) {
          PVector thisToBox = PVector.sub(new PVector(b.x, b.y), position);
          if (PVector.angleBetween(thisToBox, PVector.fromAngle(angle)) < maxAngle && thisToBox.mag() < maxDistance) {
            thisToBox.setMag(20000 * direction);
            Vec2 force = new Vec2(thisToBox.x, -thisToBox.y);
            b.body.applyForceToCenter(force);
          }
        }
      }
    }

    if (counter == end) {
      counter = start;
    }
  }
}
