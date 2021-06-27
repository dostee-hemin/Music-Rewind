class Particle {
  PVector location;
  PVector velocity;
  float lifetime;

  color particleColor;

  Particle(float x, float y, float angle) {
    location = new PVector(x, y);
    velocity = PVector.fromAngle(angle);
  }

  void display() {
    stroke(particleColor, lifetime/10 * 255);
    strokeWeight(10);
    point(location.x, location.y);
  }

  void update() {
    lifetime--;

    location.add(velocity);
  }

  boolean isFinished() {
    return lifetime <= 0;
  }
}

class TapeParticle extends Particle {
  TapeParticle(float x, float y, float angle) {
    super(x, y, angle);

    velocity.setMag(random(2, 5));
    lifetime = random(10, 20);

    particleColor = color(random(100));
  }
}

class AirParticle extends Particle {
  AirParticle(float x, float y, float angle) {
    super(x, y, angle);
    velocity.setMag(random(2, 5));
    lifetime = random(20, 40);

    particleColor = color(random(200, 255));
  }
}

class PortalParticle extends Particle {
  PortalParticle(float x, float y, float angle, boolean isCreate) {
    super(x, y, angle);
    velocity.setMag(random(1, 2));
    lifetime = random(20, 40);

    if (isCreate) {
      particleColor = color(0, random(50, 150), random(200, 255));
    } else {
      particleColor = color(random(150, 200), 0, random(150, 200));
    }
  }
}
