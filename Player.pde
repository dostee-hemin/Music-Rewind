class Player {
  Body body;

  PVector location;
  float radius;

  boolean isMovingLeft, isMovingRight;
  boolean canJump, canSlowDown, canPlayRoll;

  float angle = 0;

  Player(float x, float y) {
    location = new PVector(x, y);
    radius = 25;

    BodyDef bodyDefinition = new BodyDef();
    bodyDefinition.type = BodyType.DYNAMIC;
    bodyDefinition.setPosition(box2d.coordPixelsToWorld(x, y));


    body = box2d.createBody(bodyDefinition);

    CircleShape circle = new CircleShape();
    float radiusWorld = box2d.scalarPixelsToWorld(radius);
    circle.setRadius(radiusWorld);

    FixtureDef fixture = new FixtureDef();
    fixture.shape = circle;
    fixture.density = 0.03;
    fixture.friction = 0;
    fixture.restitution = 0;

    body.createFixture(fixture);

    body.setUserData(this);
  }

  void update() {
    location = box2d.getBodyPixelCoordPVector(body);

    if (canSlowDown && !(isMovingLeft || isMovingRight)) {
      body.applyForceToCenter(new Vec2(-10*body.getLinearVelocity().x, 0));
    }

    if (isMovingLeft) {
      Vec2 velocity = body.getLinearVelocity();
      applyForce((-50 - velocity.x)*3.5);
    } else if (isMovingRight) {
      Vec2 velocity = body.getLinearVelocity();
      applyForce((50 - velocity.x)*3.5);
    } else {
      if (body.getAngle() != 0) {
        body.applyAngularImpulse(-body.getAngularVelocity()/5);
      }
    }
  }

  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(body.getAngle());
    image(playerImage, 0, 0, radius*2, radius*2);
    popMatrix();
    noFill();
    stroke(0);
    strokeWeight(5);
    ellipse(location.x, location.y, radius*2, radius*2);

    if (location.y > maxCameraY + 700 && endPanelTargetY != 400) {
      SetupCurrentLevel();
      iconSizes[2][0] = 300;
      if(canPlayEffects)
      cassetteSounds[2].trigger();
    }
  }

  void applyForce(float x) {
    body.applyForceToCenter(new Vec2(x, 0));
    body.applyAngularImpulse(x/120);
  }

  void jump() {
    if (canJump) {
      if(canPlayEffects)
      jumpSound.trigger();
      body.setLinearVelocity(new Vec2(body.getLinearVelocity().x, 150));
    }
  }
}
