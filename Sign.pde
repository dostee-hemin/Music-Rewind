class Sign {
  float x, y;
  PImage textBubble;

  float bubbleHeight;
  boolean hasPlayedSound;

  Sign(float x, float y, int ID) {
    this.x = x;
    this.y = y;

    textBubble = signImages[ID];
  }

  void display() {
    image(signImages[0], x, y);
    image(textBubble, x, y-200, bubbleHeight*1.3, bubbleHeight);
  }

  void update() {
    float target = 0;
    if (dist(player.location.x, player.location.y, x, y) < 30) {
      target = 300;
      if(!hasPlayedSound) {
        if(canPlayEffects)
        swooshSounds[0].trigger();
        hasPlayedSound = true;
      }
    }
    bubbleHeight = lerp(bubbleHeight, target, 0.2);
    if(bubbleHeight > target)
    hasPlayedSound = false;
  }
}
