class Button {
  Door door;
  float x, y;
  float angle;
  boolean isActivated;

  Button(float bx, float by, float dx, float dy, float bAngle, float dAngle) {
    x = bx;
    y = by;
    angle = bAngle;
    door = new Door(dx, dy, dAngle, false);
  }
  
  Button(float bx, float by, float dx, float dy, float bAngle, float dAngle, boolean s) {
    x = bx;
    y = by;
    angle = bAngle;
    door = new Door(dx, dy, dAngle, true);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();
    if (isActivated) {
      fill(0, 255, 0);
      door.adjustSize(0);
      door.b.body.setActive(false);
    } else {
      fill(255, 0, 0);
    }
    ellipse(0, -10, 20, 20);
    fill(0);
    rect(0, 0, 40, 20);
    popMatrix();

    door.display();
  }

  void checkForPress() {
    if (isActivated) return;

    if (dist(x, y, player.location.x, player.location.y) < 30) {
      isActivated = true;
      if(canPlayEffects)
      buttonPress[0].trigger();
    }
  }

  void deleteDoor() {
    box2d.destroyBody(door.b.body);
  }
}

class PressureButton extends Button {
  PressureButton(float bx, float by, float dx, float dy, float bAngle, float dAngle) {
    super(bx, by, dx, dy, bAngle, dAngle, true);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();
    fill(200);
    rect(0, 0, 75, 10);
    if (isActivated) {
      fill(0, 255, 0);
      door.adjustSize(0);
      door.b.body.setActive(false);
    } else {
      fill(255, 0, 0);
      door.adjustSize(1);
      door.b.body.setActive(true);
    }
    ellipse(0, 0, 12, 12);
    popMatrix();

    door.display();
  }

  void checkForPress() {
    boolean boolVal = false;
    if (dist(x, y, player.location.x, player.location.y) < 50) {
      boolVal = true;
    }

    for (Box b : boxes) {
      if (b.getClass() == MovableBox.class) {
        if (dist(x, y, b.x, b.y) < 50) {
          boolVal = true;
        }
      }
    }
    if (boolVal && !isActivated) {
      if(canPlayEffects)
      buttonPress[1].trigger();
    }
    isActivated = boolVal;
  }
}

class Door {
  float x, y;
  float angle;
  float scaleFactor;
  boolean isPressure;
  Box b;

  Door(float x, float y, float angle, boolean isPressure) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.isPressure = isPressure;
    scaleFactor = 1;

    b = new Platform(x, y, 150, 40);
    b.body.setTransform(box2d.coordPixelsToWorld(new Vec2(x, y)), angle);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    scale(scaleFactor);
    if (isPressure) {
      image(doorImages[3], 0, 0);
    } else {
      image(doorImages[1], 0, 0);
    }
    popMatrix();
  }

  void adjustSize(float target) {
    scaleFactor = lerp(scaleFactor, target, 0.5);
  }
}
