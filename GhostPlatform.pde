class GhostPlatform {
  float x, y;
  int counter, start;

  Box box;

  GhostPlatform(float x, float y, int order) {
    this.x = x;
    this.y = y;

    start = 100*order;
    counter = start;
    box = new Platform(x, y, 120, 40);
  }

  void display() {
    if (counter > start-300) {
      counter -= 2;
    } else {
      counter = start;
    }
    
    image(platformImages[4], x, y);

    if (counter > 100 || counter < 0) {
      box.body.setActive(false);
    } else {
      tint(255, 255 - float(abs(50-counter))/50 * 255);
      image(platformImages[3].copy(), x, y);
      noTint();
      box.body.setActive(true);
    }
  }
}
