class MovingPlatform {
  PVector startLocation, endLocation;
  ArrayList<Box> bxs = new ArrayList<Box>();
  float angle;

  MovingPlatform(float startX, float startY, float endX, float endY, float angle) {
    startLocation = new PVector(startX, startY);
    endLocation = new PVector(endX, endY);

    this.angle = angle;

    bxs.add(new Platform(startLocation.x, startLocation.y, 120, 40));
  }

  void display() {
    pushMatrix();
    translate(startLocation.x, startLocation.y);
    rotate(-angle);
    image(portals[0], 0, 0);
    popMatrix();

    pushMatrix();
    translate(endLocation.x, endLocation.y);
    rotate(-angle);
    image(portals[1], 0, 0);
    popMatrix();

    for (Box b : bxs) {
      Vec2 position = box2d.getBodyPixelCoord(b.body);
      b.x = position.x;
      b.y = position.y;
      pushMatrix();
      translate(position.x, position.y);
      rotate(-angle);
      image(platformImages[1], 0, 0);
      popMatrix();
    }
    
    if(random(1) < 0.3) {
      PVector loc = startLocation.copy();
      PVector dir = PVector.fromAngle(-angle);
      loc.add(dir.mult(random(-50,50)));
      allParticles.add(new PortalParticle(loc.x,loc.y,PVector.sub(endLocation,startLocation).heading(), true));
      
      loc = endLocation.copy();
      dir = PVector.fromAngle(-angle);
      loc.add(dir.mult(random(-50,50)));
      allParticles.add(new PortalParticle(loc.x,loc.y,PVector.sub(startLocation,endLocation).heading(), false));
    }
  }

  void update() {
    if (bxs.isEmpty()) {
      return;
    }
    float recordDist = 500;
    for (Box p : bxs) {
      recordDist = min(recordDist, dist(p.x, p.y, startLocation.x, startLocation.y));
    }
    if (recordDist > 200) {
      bxs.add(new Platform(startLocation.x, startLocation.y, 120, 40));
    }

    Vec2 velocity = new Vec2(endLocation.x-startLocation.x, endLocation.y-startLocation.y);
    velocity.normalize();
    velocity.mulLocal(5);

    for (int i=bxs.size()-1; i>=0; i--) {
      Box b = bxs.get(i);

      Vec2 platPosition = box2d.getBodyPixelCoord(b.body);
      Vec2 newPos = new Vec2(platPosition.x + velocity.x, platPosition.y + velocity.y);
      b.body.setTransform(box2d.coordPixelsToWorld(newPos), angle);


      if (dist(platPosition.x, platPosition.y, endLocation.x, endLocation.y) < 10) {
        box2d.destroyBody(b.body);
        bxs.remove(b);
      }
    }
  }

  void flipDirection() {
    PVector temp = startLocation.copy();
    startLocation = endLocation;
    endLocation = temp;
  }

  void reset() {
    for (Box p : bxs) {
      box2d.destroyBody(p.body);
    }
    bxs.clear();
  }
}
