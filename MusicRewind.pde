import ddf.minim.AudioSample;
import ddf.minim.Minim;

import processing.sound.SoundFile;


import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Box> boxes = new ArrayList<Box>();
ArrayList<MovingPlatform> movingPlatforms = new ArrayList<MovingPlatform>();
ArrayList<GhostPlatform> ghostPlatforms = new ArrayList<GhostPlatform>();
ArrayList<Sign> signs = new ArrayList<Sign>();
ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<AirCannon> airCannons = new ArrayList<AirCannon>();
ArrayList<Particle> allParticles = new ArrayList<Particle>();
Player player;
Tape[] tapes = new Tape[3];
PVector exitDoor = new PVector();

PVector cameraPosition;
boolean isRewinding, isPlayingCassette;

int currentLevel = 0;
int targetLevel = 0;
int highestLevel;
float fadeAlpha;
float targetAlpha = -2;
float[][] iconSizes = new float[3][2];
float[] tapeScoreSizes = new float[3];

float minCameraX, minCameraY;
float maxCameraX, maxCameraY;
float endPanelY, endPanelTargetY;

float drawScale = 1;

int numberOfPoints;
boolean canPlayEffects = true, canPlayMusic = true;

void setup() {
  size(1000, 800, P2D);

  LoadImages();
  LoadSounds();

  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -300);

  box2d.listenForCollisions();

  iconSizes[0][1] = 400;
  iconSizes[1][1] = 400;
  iconSizes[2][1] = 200;
  for (int i=0; i<3; i++) {
    tapes[i] = new Tape(-100, -100);
    iconSizes[i][0] = iconSizes[i][1];
  }


  endPanelTargetY = 2*height;
  endPanelY = endPanelTargetY;

  if (currentLevel > 0) {
    SetupCurrentLevel();
  }

  try {
    String[] txt = loadStrings("highestLevel.txt");
    highestLevel = int(txt[0]);
  } 
  catch (NullPointerException e) {
    highestLevel = 1;
    String[] txt = {str(highestLevel)};
    saveStrings("highestLevel.txt", txt);
  }

  imageMode(CENTER);
  rectMode(CENTER);
}

void draw() {
  background(255);

  switch(currentLevel) {
  case -1:
    image(backgrounds[1], 500, 400);

    for (int i=0; i<5; i++) {
      for (int j=0; j<2; j++) {
        int number = i + j*5 + 1;
        if (number > highestLevel) {
          image(levelIcon[0], 260+i*120, 400+j*150);
        } else {
          image(levelIcon[1], 260+i*120, 400+j*150);
        }
        image(levelNumbers[number-1], 260+i*120, 400+j*150);

        if (number > highestLevel) {
          fill(0, 100);
          noStroke();
          rect(260+i*120, 400+j*150, 100, 100);
        }
      }
    }
    break;
  case 0:
    image(backgrounds[0], 500, 400);
    image(menuButtons[0], 500, 400);
    image(menuButtons[1], 500, 575);

    float angle = 0;
    if (abs(mouseX-500) < 150 && abs(mouseY-400) < 75) {
      angle = float(frameCount)/10;
    }
    pushMatrix();
    translate(433, 394);
    rotate(angle);
    image(menuButtons[2], 0, 0, 45, 45);
    popMatrix();

    pushMatrix();
    translate(570, 394);
    rotate(angle);
    image(menuButtons[2], 0, 0, 45, 45);
    popMatrix();

    angle = 0;
    if (abs(mouseX-500) < 100 && abs(mouseY-575) < 50) {
      angle = float(frameCount)/10;
    }
    pushMatrix();
    translate(455, 572);
    rotate(angle);
    image(menuButtons[2], 0, 0, 25, 25);
    popMatrix();

    pushMatrix();
    translate(546, 572);
    rotate(angle);
    image(menuButtons[2], 0, 0, 25, 25);
    popMatrix();


    if ((abs(mouseX-500) < 100 && abs(mouseY-575) < 50) ||
      (abs(mouseX-500) < 150 && abs(mouseY-400) < 75)) {
      if (!isPlayingCassette && targetAlpha != 255) {
        cassetteSounds[4].trigger();
        isPlayingCassette = true;
      }
    } else {
      isPlayingCassette = false;
      cassetteSounds[4].stop();
    }
    break;
  case 11:
    image(backgrounds[3], 500, 400);
    break;
  default:
    float xOffset = 0;
    if (minCameraX != maxCameraX) {
      xOffset = map(cameraPosition.x, minCameraX-500, maxCameraX+500, -100, 100);
    }
    float yOffset = 0;
    if (minCameraY != maxCameraY) {
      yOffset = map(cameraPosition.y, minCameraY-400, maxCameraY+400, -100, 100);
    }
    image(backgrounds[2], 500 - xOffset, 400 - yOffset);

    pushMatrix();

    translate(500, 400);
    scale(drawScale);
    translate(-cameraPosition.x, -cameraPosition.y);

    for (Box p : boxes) {
      p.display();
    }

    for (GhostPlatform gp : ghostPlatforms) {
      gp.display();
    }


    for (Sign s : signs) {
      s.update();
      s.display();
    }
    for (Button b : buttons) {
      b.checkForPress();
      b.display();
    }

    for (Tape t : tapes) {
      t.display();

      if (t.getsCollected() && !t.isCollected) {
        t.isCollected = true;
        numberOfPoints++;
      }
    }

    for (AirCannon a : airCannons) {
      a.update();
      a.display();
    }

    if (numberOfPoints == 3) {
      image(doorImages[2], exitDoor.x, exitDoor.y);
    } else {
      image(doorImages[0], exitDoor.x, exitDoor.y);
    }

    for (int i=allParticles.size()-1; i>=0; i--) {
      Particle p = allParticles.get(i);

      p.update();
      p.display();
      if (p.isFinished()) {
        allParticles.remove(p);
      }
    }

    for (MovingPlatform mp : movingPlatforms) {
      mp.update();
      mp.display();
    }

    player.update();
    player.display();

    moveCamera();

    if (canPlayMusic) {
      if (isRewinding) {
        if (!reverseSong.isPlaying()) {
          reverseSong.play();
          normalSong.stop();
        } else {
          if (reverseSong.position() > reverseSong.duration()-0.1) {
            reverseSong.cue(0);
          }
        }
      } else {
        if (!normalSong.isPlaying()) {
          normalSong.play();
          reverseSong.stop();
        } else {
          if (normalSong.position() > normalSong.duration()-0.1) {
            normalSong.cue(0);
          }
        }
      }
    }
    if (numberOfPoints == 3) {
      if (dist(player.location.x, player.location.y, exitDoor.x, exitDoor.y) < 50) {
        endPanelTargetY = 400;

        if (currentLevel == highestLevel && currentLevel != 10) {
          highestLevel = currentLevel+1;
          String[] txt = {str(highestLevel)};
          saveStrings("highestLevel.txt", txt);
        }
      }
    }
    popMatrix();

    image(UIs[0], 500, 300);
    image(levelNumbers[currentLevel-1], 497, 70, 75, 75);
    image(soundControls[0], 75, 50);
    image(soundControls[1], 150, 50);

    noFill();
    stroke(255, 0, 0);
    strokeWeight(5);
    if (!canPlayEffects) {
      ellipse(75, 50, 70, 70);
      line(50, 25, 100, 75);
    }
    if (!canPlayMusic) {
      ellipse(150, 50, 70, 70);
      line(125, 25, 175, 75);
    }

    noFill();
    stroke(#C47104);
    strokeWeight(3);
    for (int i=0; i<3; i++) {
      float x = 300 + i*55;
      ellipse(x, 45, 45, 45);
      if (i < numberOfPoints) {
        image(tape, x, 45, 50, 50);
      }
    }

    box2d.step();
  }

  image(UIs[1], 500, endPanelY);
  if (abs(endPanelY-endPanelTargetY) > 1) {
    if (endPanelY > 1590) {
      if (canPlayEffects)
        swooshSounds[1].trigger();
    }
    endPanelY = lerp(endPanelY, endPanelTargetY, 0.1);
  } else if (endPanelTargetY == 400) {
    for (int i=0; i<3; i++) {
      if (tapeScoreSizes[i] > 85) {
        tapeScoreSizes[i] -= 5;
      }
    }
  }
  for (int i=0; i<3; i++) {
    if (tapeScoreSizes[i] > 110) {
      if (tapeScoreSizes[i] < 116) 
        if (canPlayEffects)
          swooshSounds[2].trigger();
      continue;
    }
    pushMatrix();
    translate(337 + i*163, endPanelY - 103);
    rotate(map(tapeScoreSizes[i], 85, 110, 0, -HALF_PI));
    image(UIs[2], 0, 0, tapeScoreSizes[i], tapeScoreSizes[i]*1.247);
    popMatrix();
  }

  fill(0, fadeAlpha);
  noStroke();
  rect(500, 400, 1000, 800);

  for (int i=0; i<3; i++) {
    if (abs(iconSizes[i][0]-iconSizes[i][1]) < 5) {
      continue;
    }
    tint(255, map(abs(iconSizes[i][0]-iconSizes[i][1]), 0, 100, 0, 255));
    image(icons[i], 500, 300, iconSizes[i][0], iconSizes[i][0]);
    iconSizes[i][0] = lerp(iconSizes[i][0], iconSizes[i][1], 0.075);
  }
  noTint();

  if (abs(fadeAlpha - targetAlpha) > 1) {
    fadeAlpha = lerp(fadeAlpha, targetAlpha, 0.07);
    if (fadeAlpha < 0) {
      fadeAlpha = 0;
    }
  } else {
    if (targetAlpha == 255) {
      currentLevel = targetLevel;
      targetAlpha = 0;
      SetupCurrentLevel();
    }
  }
}

void moveCamera() {
  cameraPosition.x = lerp(cameraPosition.x, player.location.x, 0.04);
  cameraPosition.y = lerp(cameraPosition.y, player.location.y, 0.04);


  cameraPosition.x = constrain(cameraPosition.x, minCameraX, maxCameraX);
  cameraPosition.y = constrain(cameraPosition.y, minCameraY, maxCameraY);
}

void beginContact(Contact cp) {
  checkForJump(cp, true);
}
void endContact(Contact cp) {
  checkForJump(cp, false);
}

void checkForJump(Contact cp, boolean boolVal) {
  Fixture fixture1 = cp.getFixtureA();
  Fixture fixture2 = cp.getFixtureB();

  Body body1 = fixture1.getBody();
  Body body2 = fixture2.getBody();

  Object object1 = body1.getUserData();
  Object object2 = body2.getUserData();

  if ((object1.getClass() == Platform.class || object1.getClass() == MovableBox.class) && object2.getClass() == Player.class) {
    if (boolVal)
      if (canPlayEffects)
        dropSound.trigger();

    Vec2 pos2 = box2d.getBodyPixelCoord(body2);

    Box p = (Box) object1;
    if (p.y-pos2.y > p.h/2 && pos2.x> p.x - p.w/2 - player.radius && pos2.x < p.x + p.w/2+player.radius) {
      player.canJump = boolVal;
      player.canPlayRoll = boolVal;
      player.canSlowDown = boolVal;
    }
  }
}

void FlipEverything() {
  for (MovingPlatform mp : movingPlatforms) {
    mp.flipDirection();
  }

  for (AirCannon a : airCannons) {
    a.direction *= -1;
  }

  int[] oldStarts = new int[ghostPlatforms.size()];
  for (int i=0; i<oldStarts.length; i++) {
    oldStarts[i] = ghostPlatforms.get(i).start;
  }
  for (int i=0; i<oldStarts.length; i+=3) {
    for (int j=0; j<3; j++) {
      GhostPlatform gp = ghostPlatforms.get(i+j);
      gp.counter = oldStarts[2+i-j] - gp.counter + gp.start - 300;
      gp.start = oldStarts[2+i-j];
    }
  }
}
