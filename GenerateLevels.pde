void SetupCurrentLevel() {
  drawScale = 1;
  endPanelTargetY = 2*height;
  numberOfPoints = 0;
  cameraPosition = new PVector();
  endPanelY = endPanelTargetY;
  if (player != null) {
    box2d.destroyBody(player.body);
  }

  for (Box b : boxes) {
    box2d.destroyBody(b.body);
  }
  boxes.clear();

  for (MovingPlatform mp : movingPlatforms) {
    mp.reset();
  }
  movingPlatforms.clear();

  for (GhostPlatform gp : ghostPlatforms) {
    box2d.destroyBody(gp.box.body);
  }
  ghostPlatforms.clear();

  signs.clear();
  allParticles.clear();
  airCannons.clear();
  for (Button b : buttons) {
    b.deleteDoor();
  }
  buttons.clear();
  isRewinding = false;

  normalSong.stop();
  reverseSong.stop();
  normalSong.cue(0);
  for (int i=0; i<3; i++) {
    tapeScoreSizes[i] = 150 + i*100;
  }
  switch(currentLevel) {
  case 1:
    setupLevel1();
    break;
  case 2:
    setupLevel2();
    break;
  case 3:
    setupLevel3();
    break;
  case 4:
    setupLevel4();
    break;
  case 5:
    setupLevel5();
    break;
  case 6:
    setupLevel6();
    break;
  case 7:
    setupLevel7();
    break;
  case 8:
    setupLevel8();
    break;
  case 9:
    setupLevel9();
    break;
  case 10:
    setupLevel10();
    break;
  }

  cameraPosition.set(player.location.x, player.location.y);
}

void setupLevel1() {
  player = new Player(100, -200);

  boxes.add(new Platform(1050, 750, 2100, 100));
  boxes.add(new Platform(1500, 650, 300, 100));
  boxes.add(new Platform(2500, 750, 400, 100));
  boxes.add(new Platform(3120, 450, 50, 500));
  boxes.add(new Platform(3070, 400, 50, 40));
  boxes.add(new Platform(3045, 600, 100, 40));
  boxes.add(new Platform(3450, 750, 1100, 100));
  boxes.add(new Platform(3800, 450, 400, 50));
  boxes.add(new Platform(3300, 550, 200, 50));

  boxes.add(new Platform(0, 400, 1, 800));
  boxes.add(new Platform(4000, 400, 1, 800));


  tapes[0] = new Tape(1500, 550);
  tapes[1] = new Tape(2500, 450);
  tapes[2] = new Tape(3900, 300);

  signs.add(new Sign(300, 675, 1));
  signs.add(new Sign(750, 675, 2));
  signs.add(new Sign(1100, 675, 3));
  signs.add(new Sign(3500, 675, 4));

  minCameraY = 400;
  maxCameraY = 400;
  minCameraX = 500;
  maxCameraX = 3500;

  exitDoor = new PVector(3900, 650);
}

void setupLevel2() {
  drawScale = 0.7;
  player = new Player(100, 100);

  boxes.add(new Platform(250, 750, 500, 100));
  boxes.add(new Platform(900, 550, 400, 500));
  boxes.add(new Platform(1500, 200, 500, 800));
  boxes.add(new Platform(1500, 750, 800, 50));
  boxes.add(new Platform(2000, 650, 200, 300));
  boxes.add(new Platform(2200, 500, 200, 600));
  boxes.add(new Platform(2500, 200, 20, 800));
  boxes.add(new Platform(2750, 775, 500, 50));
  boxes.add(new Platform(1800, 400, 100, 50));
  boxes.add(new Platform(2585, 550, 150, 50));
  boxes.add(new Platform(2585, 200, 150, 50));
  boxes.add(new Platform(2950, 350, 150, 50));

  movingPlatforms.add(new MovingPlatform(600, 100, 600, 750, 0));
  movingPlatforms.add(new MovingPlatform(2400, 750, 2400, 100, 0));
  movingPlatforms.add(new MovingPlatform(1100, 660, 1900, 660, HALF_PI));

  minCameraY = -100;
  maxCameraY = 400;
  minCameraX = 500;
  maxCameraX = 2500;

  signs.add(new Sign(300, 675, 5));
  signs.add(new Sign(900, 275, 6));

  exitDoor.set(2900, 700);

  tapes[0] = new Tape(900, 200);
  tapes[1] = new Tape(2585, 100);
  tapes[2] = new Tape(1500, 650);
}
void setupLevel3() {
  drawScale = 0.7;
  player = new Player(-700, 100);

  boxes.add(new Platform(300, 750, 500, 100));
  boxes.add(new Platform(-700, 750, 200, 100));
  boxes.add(new Platform(1500, -150, 1000, 20));
  boxes.add(new Platform(1200, -500, 400, 30));
  boxes.add(new Platform(2200, -700, 400, 30));
  boxes.add(new Platform(2380, -385, 40, 600));
  boxes.add(new Platform(2920, -420, 40, 670));
  boxes.add(new Platform(2650, -95, 500, 20));
  boxes.add(new Platform(2650, -900, 200, 1100));
  boxes.add(new Platform(3220, -770, 640, 30));

  movingPlatforms.add(new MovingPlatform(700, 0, 700, 650, 0));
  movingPlatforms.add(new MovingPlatform(900, 250, 900, -400, 0));

  ghostPlatforms.add(new GhostPlatform(-500, 650, 3));
  ghostPlatforms.add(new GhostPlatform(-300, 650, 2));
  ghostPlatforms.add(new GhostPlatform(-100, 650, 1));

  ghostPlatforms.add(new GhostPlatform(1450, -600, 3));
  ghostPlatforms.add(new GhostPlatform(1600, -500, 2));
  ghostPlatforms.add(new GhostPlatform(1800, -650, 1));

  ghostPlatforms.add(new GhostPlatform(2825, -575, 3));
  ghostPlatforms.add(new GhostPlatform(2825, -425, 2));
  ghostPlatforms.add(new GhostPlatform(2825, -275, 1));

  minCameraY = -1600;
  maxCameraY = 600;
  minCameraX = -750;
  maxCameraX = 3500;

  exitDoor.set(3400, -835);

  signs.add(new Sign(-700, 675, 7));

  tapes[0] = new Tape(900, 0);
  tapes[1] = new Tape(1800, -800);
  tapes[2] = new Tape(2825, -475);
}
void setupLevel4() {
  drawScale = 0.9;
  player = new Player(500, 400);

  boxes.add(new Platform(500, 750, 1000, 100));
  boxes.add(new Platform(300, -300, 600, 10));
  boxes.add(new Platform(300, -450, 400, 10));
  boxes.add(new Platform(595, -405, 10, 200));
  boxes.add(new Platform(495, -480, 10, 50));
  boxes.add(new Platform(545, -510, 110, 10));
  boxes.add(new Platform(300, -1300, 600, 10));
  boxes.add(new Platform(32, -1450, 75, 10));
  boxes.add(new Platform(117, -1650, 75, 10));
  boxes.add(new Platform(32, -1850, 75, 10));
  boxes.add(new Platform(118, -2005, 75, 10));
  boxes.add(new Platform(700, -1705, 600, 10));
  boxes.add(new Platform(150, -1700, 10, 600));
  boxes.add(new Platform(400, -3100, 800, 10));
  boxes.add(new Platform(300, -1000, 200, 10));
  boxes.add(new Platform(500, -1100, 200, 10));
  boxes.add(new Platform(700, -1200, 200, 10));

  boxes.add(new Platform(0, -1600, 10, 4800));
  boxes.add(new Platform(1000, -1600, 10, 4800));

  movingPlatforms.add(new MovingPlatform(750, 300, 750, -400, 0));
  movingPlatforms.add(new MovingPlatform(600, -365, 0, -365, HALF_PI));
  movingPlatforms.add(new MovingPlatform(900, -3000, 900, -2200, 0));

  ghostPlatforms.add(new GhostPlatform(100, 500, 3));
  ghostPlatforms.add(new GhostPlatform(300, 350, 2));
  ghostPlatforms.add(new GhostPlatform(500, 200, 1));

  ghostPlatforms.add(new GhostPlatform(100, -600, 3));
  ghostPlatforms.add(new GhostPlatform(100, -750, 2));
  ghostPlatforms.add(new GhostPlatform(100, -900, 1));

  ghostPlatforms.add(new GhostPlatform(750, -2100, 3));
  ghostPlatforms.add(new GhostPlatform(500, -2100, 2));
  ghostPlatforms.add(new GhostPlatform(250, -2100, 1));

  minCameraY = -4000;
  maxCameraY = 400;
  minCameraX = 500;
  maxCameraX = 500;

  tapes[0] = new Tape(545, -470);
  tapes[1] = new Tape(800, -1400);
  tapes[2] = new Tape(500, -2200);

  exitDoor.set(200, -3155);
}
void setupLevel5() {
  player = new Player(100, 100);

  boxes.add(new Platform(350, 750, 700, 100));
  boxes.add(new Platform(1000, 650, 600, 300));
  boxes.add(new Platform(725, 175, 50, 350));
  boxes.add(new Platform(2000, 175, 50, 350));
  boxes.add(new Platform(1600, 750, 600, 100));
  boxes.add(new Platform(2100, 650, 400, 300));
  boxes.add(new Platform(2600, 50, 200, 100));
  boxes.add(new Platform(2900, 50, 200, 100));
  boxes.add(new Platform(2800, 750, 600, 100));
  boxes.add(new Platform(2600, 400, 200, 300));
  boxes.add(new Platform(2900, 400, 200, 300));
  boxes.add(new Platform(2750, 540, 100, 20));
  boxes.add(new Platform(1550, 100, 20, 200));
  boxes.add(new Platform(1650, 100, 20, 200));
  boxes.add(new MovableBox(1600, 50, 60, 60));
  boxes.add(new MovableBox(2750, 0, 60, 60));

  boxes.add(new Platform(0, 400, 1, 800));
  boxes.add(new Platform(3000, 400, 1, 800));

  movingPlatforms.add(new MovingPlatform(2400, 100, 2400, 700, 0));

  buttons.add(new Button(500, 690, 725, 425, 0, HALF_PI));
  buttons.add(new PressureButton(1200, 495, 1600, 210, 0, 0));
  buttons.add(new PressureButton(1700, 695, 2000, 425, 0, HALF_PI));
  buttons.add(new Button(2600, 244, 2750, 270, 0, 0));
  buttons.add(new Button(2900, 244, 2750, 80, 0, 0));
  buttons.add(new PressureButton(2750, 525, 2700, 625, 0, HALF_PI));

  signs.add(new Sign(400, 675, 8));
  signs.add(new Sign(1500, 675, 9));

  minCameraY = 400;
  maxCameraY = 400;
  minCameraX = 500;
  maxCameraX = 2500;

  tapes[0] = new Tape(800, 400);
  tapes[1] = new Tape(1450, 200);
  tapes[2] = new Tape(2750, 400);

  exitDoor.set(2900, 650);
}

void setupLevel6() {
  drawScale = 0.6;
  player = new Player(500, 600);

  boxes.add(new Platform(25, 500, 800, 50, -QUARTER_PI));
  boxes.add(new Platform(975, 500, 800, 50, QUARTER_PI));
  boxes.add(new Platform(75, 270, 800, 50, -QUARTER_PI));
  boxes.add(new Platform(925, 270, 800, 50, QUARTER_PI));
  boxes.add(new Platform(360, 320, 50, 500));
  boxes.add(new Platform(640, 320, 50, 500));
  boxes.add(new Platform(285, 70, 200, 50));
  boxes.add(new Platform(715, 70, 200, 50));
  boxes.add(new Platform(500, 800, 400, 100));
  boxes.add(new Platform(-540, 225, 600, 50));
  boxes.add(new Platform(1540, 225, 600, 50));
  boxes.add(new Platform(-540, -400, 200, 50));
  boxes.add(new MovableBox(-490, -470, 60, 60));
  boxes.add(new Platform(1670, -400, 240, 40));
  boxes.add(new Platform(-205, -390, 40, 800));
  boxes.add(new Platform(1205, -390, 40, 800));
  boxes.add(new Platform(200, -105, 40, 400));
  boxes.add(new Platform(800, -105, 40, 400));

  movingPlatforms.add(new MovingPlatform(-215, 135, 350, 700, QUARTER_PI));
  movingPlatforms.add(new MovingPlatform(1215, 135, 650, 700, -QUARTER_PI));
  movingPlatforms.add(new MovingPlatform(-760, 100, -760, -400, 0));

  ghostPlatforms.add(new GhostPlatform(500, 550, 3));
  ghostPlatforms.add(new GhostPlatform(500, 400, 2));
  ghostPlatforms.add(new GhostPlatform(500, 250, 1));

  ghostPlatforms.add(new GhostPlatform(1410, 25, 1));
  ghostPlatforms.add(new GhostPlatform(1670, -100, 2));
  ghostPlatforms.add(new GhostPlatform(1410, -225, 3));

  buttons.add(new Button(1670, -430, 500, 100, 0, 0));
  buttons.add(new PressureButton(-440, 195, 500, 150, 0, 0));

  minCameraY = -1600;
  maxCameraY = 400;
  minCameraX = -2000;
  maxCameraX = 2000;

  tapes[0] = new Tape(280, -50);
  tapes[1] = new Tape(-270, -700);
  tapes[2] = new Tape(1370, -650);

  exitDoor.set(720, -5);
}

void setupLevel7() {
  drawScale = 0.7;
  player = new Player(350, 500);

  boxes.add(new Platform(350, 750, 800, 50));
  boxes.add(new Platform(900, 500, 900, 20));
  boxes.add(new Platform(575, 240, 20, 500));
  boxes.add(new Platform(317, 0, 535, 50));
  boxes.add(new Platform(0, 150, 300, 20));
  boxes.add(new Platform(-140, -110, 20, 500));
  boxes.add(new Platform(-90, -50, 80, 20));
  boxes.add(new Platform(0, -250, 100, 20));
  boxes.add(new Platform(150, -190, 200, 330));
  boxes.add(new Platform(450, -500, 50, 600));
  boxes.add(new Platform(800, -250, 50, 1100));
  boxes.add(new Platform(975, 325, 400, 50));
  boxes.add(new Platform(1360, 425, 20, 150));
  boxes.add(new Platform(1450, 325, 200, 50));
  boxes.add(new Platform(1325, -100, 150, 20));
  boxes.add(new Platform(1240, -140, 20, 100));
  boxes.add(new Platform(2200, 600, 500, 50));
  boxes.add(new Platform(1925, 425, 50, 400));

  movingPlatforms.add(new MovingPlatform(350, -350, 350, 350, 0));

  ghostPlatforms.add(new GhostPlatform(550, -225, 3));
  ghostPlatforms.add(new GhostPlatform(700, -375, 2));
  ghostPlatforms.add(new GhostPlatform(550, -525, 1));

  airCannons.add(new AirCannon(1350, 425, -1, PI, 30, 30, 500));
  airCannons.add(new AirCannon(1450, 300, 1, -HALF_PI, 100, 125, 300));
  airCannons.add(new AirCannon(1250, -140, 1, 0, 125, 125, 500));
  airCannons.add(new AirCannon(1250, -140, 1, 0, 125, 125, 500));

  signs.add(new Sign(850, 275, 11));
  signs.add(new Sign(675, 465, 10));

  minCameraY = -1600;
  maxCameraY = 400;
  minCameraX = -2000;
  maxCameraX = 2000;

  tapes[0] = new Tape(550, -600);
  tapes[1] = new Tape(1325, -200);
  tapes[2] = new Tape(2050, 500);

  exitDoor.set(2250, 525);
}

void setupLevel8() {
  drawScale = 0.7;
  player = new Player(350, 500);

  boxes.add(new Platform(200, 900, 400, 300));
  boxes.add(new Platform(200, 1140, 800, 20));
  boxes.add(new Platform(-190, 875, 20, 510));
  boxes.add(new Platform(10, 1090, 20, 80));
  boxes.add(new Platform(590, 1090, 20, 80));
  boxes.add(new Platform(700, 900, 400, 300));
  boxes.add(new Platform(10, 675, 20, 150));
  boxes.add(new Platform(600, 675, 20, 150));
  boxes.add(new Platform(-330, 610, 300, 20));
  boxes.add(new Platform(-200, 0, 200, 20));
  boxes.add(new Platform(390, -250, 20, 800));
  boxes.add(new Platform(510, -250, 20, 800));
  boxes.add(new Platform(310, -110, 140, 20));
  boxes.add(new Platform(310, 140, 140, 20));
  boxes.add(new MovableBox(450, -200, 60, 60));
  boxes.add(new MovableBox(800, 600, 60, 60));
  boxes.add(new Platform(920, 800, 100, 40, -QUARTER_PI));
  boxes.add(new Platform(1400, 500, 300, 40));
  boxes.add(new Platform(1400, 1000, 900, 50));
  boxes.add(new Platform(1700, 800, 300, 50));
  boxes.add(new Platform(1875, 900, 50, 250));
  boxes.add(new Platform(950, 790, 50, 10, QUARTER_PI));

  movingPlatforms.add(new MovingPlatform(-380, 0, -380, 500, 0));
  movingPlatforms.add(new MovingPlatform(75, 200, 75, -300, 0));

  ghostPlatforms.add(new GhostPlatform(-90, 650, 1));
  ghostPlatforms.add(new GhostPlatform(-90, 800, 2));
  ghostPlatforms.add(new GhostPlatform(-90, 950, 3));

  buttons.add(new Button(310, 130, 450, -110, 0, 0));
  buttons.add(new Button(310, -120, 450, 140, 0, 0));
  buttons.add(new PressureButton(60, 1125, 1700, 900, 0, HALF_PI));
  buttons.add(new PressureButton(1500, 475, 1600, 900, 0, HALF_PI));

  airCannons.add(new AirCannon(450, 1150, 1, -HALF_PI, 10, 30, 400));
  airCannons.add(new AirCannon(575, 1100, -1, PI, 20, 30, 600));
  airCannons.add(new AirCannon(920, 800, 1, -QUARTER_PI, 10, 10, 300));

  minCameraY = -1600;
  maxCameraY = 1600;
  minCameraX = -2000;
  maxCameraX = 2000;

  tapes[0] = new Tape(310, -500);
  tapes[1] = new Tape(-90, 1100);
  tapes[2] = new Tape(1400, 400);

  exitDoor.set(1800, 925);
}

void setupLevel9() {
  drawScale = 0.7;
  player = new Player(500, 500);

  boxes.add(new Platform(525, 750, 1050, 50));
  boxes.add(new Platform(-25, 600, 50, 350));
  boxes.add(new Platform(1025, 650, 50, 150));
  boxes.add(new Platform(1200, 550, 800, 50));
  boxes.add(new Platform(550, 375, 300, 50));
  boxes.add(new Platform(675, 175, 50, 350));
  boxes.add(new Platform(225, 200, 150, 400));
  boxes.add(new Platform(475, 125, 50, 250));
  boxes.add(new Platform(375, 125, 150, 250));
  boxes.add(new Platform(-225, 400, 450, 50));
  boxes.add(new Platform(-100, 200, 500, 50));
  boxes.add(new Platform(-225, 0, 450, 50));
  boxes.add(new Platform(-475, 200, 50, 450));
  boxes.add(new Platform(225, -100, 50, 200));
  boxes.add(new Platform(-250, -225, 50, 400));
  boxes.add(new Platform(75, -225, 350, 50));
  boxes.add(new Platform(75, -450, 700, 50));
  boxes.add(new Platform(375, -25, 250, 50));
  boxes.add(new Platform(575, -375, 300, 400));
  boxes.add(new MovableBox(-75, -75, 60, 60));
  boxes.add(new Platform(1062, 50, 725, 100));
  boxes.add(new Platform(900, 200, 50, 200));
  boxes.add(new Platform(1150, 200, 50, 200));
  boxes.add(new Platform(1400, 250, 50, 300));
  boxes.add(new Platform(1037, -25, 775, 50));
  boxes.add(new Platform(1275, -125, 300, 150));
  boxes.add(new Platform(1100, -200, 50, 300));
  boxes.add(new Platform(1162, -550, 875, 50));
  boxes.add(new Platform(1350, -450, 150, 150));
  boxes.add(new Platform(1625, 0, 50, 1150));
  boxes.add(new MovableBox(1250, -250, 60, 60));

  movingPlatforms.add(new MovingPlatform(80, 750, 80, 225, PI));
  movingPlatforms.add(new MovingPlatform(150, 300, -450, 300, HALF_PI));
  movingPlatforms.add(new MovingPlatform(-400, 400, -400, 0, 0));
  movingPlatforms.add(new MovingPlatform(-450, 100, 150, 100, HALF_PI));

  ghostPlatforms.add(new GhostPlatform(775, 350, 3));
  ghostPlatforms.add(new GhostPlatform(1025, 350, 2));
  ghostPlatforms.add(new GhostPlatform(1275, 350, 1));

  ghostPlatforms.add(new GhostPlatform(1510, 350, 3));
  ghostPlatforms.add(new GhostPlatform(1510, 150, 2));
  ghostPlatforms.add(new GhostPlatform(1510, -50, 1));

  buttons.add(new Button(575, 340, 825, 650, 0, HALF_PI));
  buttons.add(new PressureButton(290, -55, 575, 100, 0, 0));
  buttons.add(new Button(775, 100, 1400, 462, PI, HALF_PI));
  buttons.add(new Button(1025, 100, 1510, 250, PI, 0));
  buttons.add(new Button(1275, 100, 1510, 50, PI, 0));
  buttons.add(new PressureButton(900, -55, 575, 0, 0, 0));
  buttons.add(new Button(150, 300, -75, 300, -HALF_PI, HALF_PI));
  buttons.add(new Button(-450, 100, -275, 100, HALF_PI, HALF_PI));

  airCannons.add(new AirCannon(300, 300, 1, 0, 10, 10, 350));

  airCannons.add(new AirCannon(-195, -10, 1, -HALF_PI, 30, 47, 350));
  airCannons.add(new AirCannon(-195, -10, 1, -HALF_PI, 31, 47, 350));
  airCannons.add(new AirCannon(-195, -10, 1, -HALF_PI, 32, 47, 350));
  airCannons.add(new AirCannon(-265, -325, 1, 0, 47, 47, 350));

  airCannons.add(new AirCannon(1160, -190, 1, -HALF_PI, 30, 45, 350));
  airCannons.add(new AirCannon(1160, -190, 1, -HALF_PI, 31, 45, 350));
  airCannons.add(new AirCannon(1160, -190, 1, -HALF_PI, 32, 45, 350));
  airCannons.add(new AirCannon(1300, -450, 1, PI, 45, 45, 350));

  minCameraY = -1600;
  maxCameraY = 400;
  minCameraX = -2000;
  maxCameraX = 2000;

  tapes[0] = new Tape(1510, -450);
  tapes[1] = new Tape(-200, -400);
  tapes[2] = new Tape(575, 250);

  exitDoor.set(925, 675);
}

void setupLevel10() {
  drawScale = 0.5;
  player = new Player(500, 0);

  boxes.add(new Platform(500, 400, 300, 50));
  boxes.add(new Platform(-275, 900, 1250, 50));
  boxes.add(new Platform(375, 675, 50, 500));
  boxes.add(new Platform(625, 675, 50, 500));
  boxes.add(new Platform(-800, 400, 200, 50));
  boxes.add(new Platform(-875, 800, 50, 150));
  boxes.add(new Platform(-800, 700, 200, 50));
  boxes.add(new Platform(-725, 550, 50, 250));
  boxes.add(new Platform(-875, 300, 50, 150));
  boxes.add(new Platform(50, 200, 600, 50));
  boxes.add(new Platform(-625, 200, 550, 50));
  boxes.add(new Platform(0, 50, 800, 50));
  boxes.add(new Platform(-375, 125, 50, 100));
  boxes.add(new Platform(-225, 125, 50, 100));
  boxes.add(new MovableBox(-300, 150, 60, 60));
  boxes.add(new Platform(1275, 900, 1250, 50));
  boxes.add(new Platform(1875, 800, 50, 150));
  boxes.add(new Platform(1825, 700, 150, 50));
  boxes.add(new Platform(1775, 525, 50, 300));
  boxes.add(new Platform(1700, 350, 200, 50));
  boxes.add(new Platform(1625, 400, 50, 150));
  boxes.add(new Platform(1300, 450, 600, 50));
  boxes.add(new Platform(1025, 550, 50, 150));
  boxes.add(new Platform(1150, 600, 200, 50));
  boxes.add(new Platform(1150, 700, 50, 150));
  boxes.add(new Platform(1212, 750, 75, 50));
  boxes.add(new Platform(1475, 600, 250, 50));
  boxes.add(new MovableBox(1150, 540, 60, 60));
  boxes.add(new Platform(700, -100, 200, 50));
  boxes.add(new Platform(1300, -300, 200, 50));
  boxes.add(new Platform(1000, -800, 200, 50));
  boxes.add(new Platform(860, -750, 150, 50, QUARTER_PI));
  boxes.add(new Platform(820, -750, 75, 20, -QUARTER_PI));
  boxes.add(new Platform(500, -900, 200, 50));
  boxes.add(new MovableBox(525, -950, 60, 60));

  movingPlatforms.add(new MovingPlatform(1225, 830, 1775, 830, HALF_PI));
  movingPlatforms.add(new MovingPlatform(1700, 880, 1700, 450, 0));
  movingPlatforms.add(new MovingPlatform(1775, 530, 1225, 530, HALF_PI));
  movingPlatforms.add(new MovingPlatform(1300, 450, 1300, 880, 0));
  movingPlatforms.add(new MovingPlatform(750, 900, 750, 400, 0));

  ghostPlatforms.add(new GhostPlatform(150, 450, 3));
  ghostPlatforms.add(new GhostPlatform(-150, 450, 2));
  ghostPlatforms.add(new GhostPlatform(-450, 450, 1));

  ghostPlatforms.add(new GhostPlatform(150, 800, 1));
  ghostPlatforms.add(new GhostPlatform(0, 650, 2));
  ghostPlatforms.add(new GhostPlatform(-2000, 1000, 3));

  buttons.add(new Button(-800, 375, -300, 200, 0, 0));
  buttons.add(new PressureButton(-850, 840, -25, 125, HALF_PI, HALF_PI));
  buttons.add(new Button(1700, 375, 1775, 800, PI, HALF_PI));
  buttons.add(new Button(1850, 800, 1225, 675, -HALF_PI, HALF_PI));
  buttons.add(new Button(1175, 675, 1225, 525, HALF_PI, HALF_PI));
  buttons.add(new PressureButton(1050, 540, 75, 125, HALF_PI, HALF_PI));
  buttons.add(new PressureButton(450, -925, 175, 125, 0, HALF_PI));

  airCannons.add(new AirCannon(500, -200, 1, HALF_PI, 50, 52, 350));
  airCannons.add(new AirCannon(500, -200, 1, HALF_PI, 51, 52, 350));
  airCannons.add(new AirCannon(500, -200, 1, HALF_PI, 52, 52, 350));

  airCannons.add(new AirCannon(900, -200, 1, -HALF_PI, 50, 52, 350));
  airCannons.add(new AirCannon(900, -200, 1, -HALF_PI, 51, 52, 350));
  airCannons.add(new AirCannon(900, -200, 1, -HALF_PI, 52, 52, 350));

  airCannons.add(new AirCannon(1300, -900, 1, HALF_PI, 50, 52, 350));
  airCannons.add(new AirCannon(1300, -900, 1, HALF_PI, 51, 52, 350));
  airCannons.add(new AirCannon(1300, -900, 1, HALF_PI, 52, 52, 350));

  airCannons.add(new AirCannon(850, -750, 1, -HALF_PI-QUARTER_PI, 50, 52, 150));
  airCannons.add(new AirCannon(850, -750, 1, -HALF_PI-QUARTER_PI, 51, 52, 150));
  airCannons.add(new AirCannon(850, -750, 1, -HALF_PI-QUARTER_PI, 52, 52, 150));

  signs.add(new Sign(500, 355, 12));

  minCameraY = -1600;
  maxCameraY = 800;
  minCameraX = -2000;
  maxCameraX = 2000;

  tapes[0] = new Tape(-800, 300);
  tapes[1] = new Tape(1700, 250);
  tapes[2] = new Tape(-300, -150);

  exitDoor.set(-125, 125);
}
