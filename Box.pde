class Box {
  Body body;

  float x, y;
  float w, h;

  Box(float x, float y, float w, float h, boolean isStatic) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    BodyDef bodyDefinition = new BodyDef();
    if (isStatic) {
      bodyDefinition.type = BodyType.STATIC;
    } else {
      bodyDefinition.type = BodyType.DYNAMIC;
    }
    bodyDefinition.setPosition(box2d.coordPixelsToWorld(x, y));


    body = box2d.createBody(bodyDefinition);

    PolygonShape polygon = new PolygonShape();
    float boxWidth = box2d.scalarPixelsToWorld(w/2);
    float boxHeight = box2d.scalarPixelsToWorld(h/2);
    polygon.setAsBox(boxWidth, boxHeight);

    FixtureDef fixture = new FixtureDef();
    fixture.shape = polygon;
    fixture.density = 0.02;
    fixture.friction = 0.4;
    fixture.restitution = 0;

    body.createFixture(fixture);
    body.setUserData(this);
  }


  void display() {
    println("ERROR! Displaying box from parent function in frame " + frameCount);
  }
}

class Platform extends Box {  
  Platform(float x, float y, float w, float h) {
    super(x, y, w, h, true);
  }
  
  Platform(float x, float y, float w, float h, float angle) {
    super(x, y, w, h, true);
    body.setTransform(box2d.coordPixelsToWorld(new Vec2(x,y)),angle);
  }

  void display() {
    Vec2 position = box2d.getBodyPixelCoord(body);
    x = position.x;
    y = position.y;

    float angle = body.getAngle();

    pushMatrix();
    translate(x, y);
    rotate(-angle);
    float xSize = min(w / floor(w/50), w);
    float ySize = min(h / floor(h/50), h);
    for (float i=xSize/2; i<w; i+=xSize) {
      for (float j=ySize/2; j<h; j+=ySize) {
        image(platformImages[0], -w/2 + i, -h/2 + j, xSize, ySize);
      }
    }
    popMatrix();
  }
}

class MovableBox extends Box {
  MovableBox(float x, float y, float w, float h) {
    super(x, y, w, h, false);
  }

  void display() {
    Vec2 position = box2d.getBodyPixelCoord(body);
    x = position.x;
    y = position.y;

    float angle = body.getAngle();

    pushMatrix();
    translate(x, y);
    rotate(-angle);
    image(platformImages[2],0,0,w,h);
    popMatrix();
  }
}
