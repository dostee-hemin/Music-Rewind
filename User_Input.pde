void keyPressed() {
  if (currentLevel < 1) {
    return;
  }
  switch(key) {
  case 'r':
  case 'R':
    if (isRewinding) {
      if (canPlayEffects)
        cassetteSounds[1].trigger();
      iconSizes[0][0] = 300;
      normalSong.cue((1-reverseSong.percent()/100) * normalSong.duration());
    } else {
      if (canPlayEffects)
        cassetteSounds[0].trigger();
      iconSizes[1][0] = 300;
      reverseSong.cue((1-normalSong.percent()/100) * reverseSong.duration());
    }
    isRewinding = !isRewinding;
    FlipEverything();
    break;
  case 'q':
  case 'Q':
    SetupCurrentLevel();
    iconSizes[2][0] = 300;
    if (canPlayEffects)
      cassetteSounds[2].trigger();
    break;
  }

  if (endPanelTargetY > 800) {
    switch(keyCode) {
    case LEFT:
      player.isMovingLeft = true;
      break;
    case RIGHT:
      player.isMovingRight = true;
      break;
    case UP:
      player.jump();
      break;
    }
  }
}

void keyReleased() {
  if (currentLevel < 1) {
    return;
  }
  if (player.isMovingLeft && keyCode == LEFT) {
    player.isMovingLeft = false;
  }

  if (player.isMovingRight && keyCode == RIGHT) {
    player.isMovingRight = false;
  }
}

void mousePressed() {
  switch(currentLevel) {
  case -1:
    // Levels button
    for (int i=0; i<5; i++) {
      for (int j=0; j<2; j++) {
        int level = i + j*5 + 1;
        if (level > highestLevel) {
          continue;
        }
        if (abs(mouseX-260-i*120) < 50 && abs(mouseY-400-j*150) < 50) {
          targetAlpha = 255;
          targetLevel = level;
          cassetteSounds[3].trigger();
        }
      }
    }

    // Home button
    if (abs(mouseX-100) < 50 && abs(mouseY-700) < 50) {
      currentLevel = 0;
      cassetteSounds[3].trigger();
    }
    break;
  case 0:
    // Play button
    if (abs(mouseX-500) < 150 && abs(mouseY-400) < 75) {
      targetAlpha = 255;
      targetLevel = highestLevel;
      cassetteSounds[3].trigger();
      isPlayingCassette = false;
      cassetteSounds[4].stop();
    }

    // Level Select button
    if (abs(mouseX-500) < 100 && abs(mouseY-575) < 50) {
      currentLevel = -1;
      cassetteSounds[3].trigger();
      isPlayingCassette = false;
      cassetteSounds[4].stop();
    }
    break;
  case 11:
    // Home button
    if (abs(mouseX-500) < 50 && abs(mouseY-750) < 50) {
      targetAlpha = 255;
      targetLevel = 0;
      cassetteSounds[3].trigger();
    }
    break;
  default:
    // Next Level button in EndPanel
    if (abs(mouseX-500) < 100 && abs(mouseY-endPanelY-150) < 100) {
      targetAlpha = 255;
      targetLevel = currentLevel + 1;
    }

    // Home button
    if (abs(mouseX-700) < 75 && abs(mouseY-30) < 75) {
      targetAlpha = 255;
      targetLevel = 0;
      cassetteSounds[3].trigger();
    }

    if (dist(mouseX, mouseY, 75, 50) < 35) {
      cassetteSounds[3].trigger();
      canPlayEffects = !canPlayEffects;
    } else if (dist(mouseX, mouseY, 150, 50) < 35) {
      cassetteSounds[3].trigger();
      canPlayMusic = !canPlayMusic;
      if (canPlayMusic) {
        if (isRewinding) {
          reverseSong.play();
        } else {
          normalSong.play();
        }
      } else {
        normalSong.stop();
        reverseSong.stop();
      }
    }
  }
}
