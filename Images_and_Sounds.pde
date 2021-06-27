PImage[] menuButtons = new PImage[3];
PImage[] levelNumbers = new PImage[10];
PImage[] levelIcon = new PImage[2];
PImage[] backgrounds = new PImage[4];
PImage[] icons = new PImage[3];
PImage[] UIs = new PImage[3];
PImage[] platformImages = new PImage[5];
PImage tape;
PImage[] doorImages = new PImage[4];
PImage[] signImages = new PImage[13];
PImage[] portals = new PImage[2];
PImage[] horns = new PImage[2];
PImage[] soundControls = new PImage[2];
PImage playerImage;

void LoadImages() {
  menuButtons[0] = loadImage("Images/playButton.png");
  menuButtons[1] = loadImage("Images/levelButton.png");
  menuButtons[1].resize(200,100);
  menuButtons[2] = loadImage("Images/spinThing.png");
  playerImage = loadImage("Images/player.png");
  
  for(int i=1; i<=10; i++) {
    levelNumbers[i-1] = loadImage("Images/number" + i + ".png");
  }
  levelIcon[0] = loadImage("Images/select1.png");
  levelIcon[1] = loadImage("Images/select2.png");
  backgrounds[0] = loadImage("Images/background1.png");
  backgrounds[1] = loadImage("Images/background2.png");
  backgrounds[2] = loadImage("Images/background3.png");
  backgrounds[3] = loadImage("Images/background4.png");
  
  for(int i=1; i<=3; i++) {
    icons[i-1] = loadImage("Images/icon" + i + ".png");
    UIs[i-1] = loadImage("Images/ui" + i + ".png");
  }
  UIs[0].resize(800,600);
  for(int i=1; i<=platformImages.length; i++) {
    platformImages[i-1] = loadImage("Images/platform"+i+".png");
  }
  platformImages[1].resize(120,40);
  platformImages[3].resize(120,40);
  platformImages[4].resize(120,40);
  for(int i=0; i<signImages.length; i++) {
    signImages[i] = loadImage("Images/signs"+i+".png");
  }
  tape = loadImage("Images/tape.png");
  doorImages[0] = loadImage("Images/door1.png");
  doorImages[1] = loadImage("Images/door2.png");
  doorImages[2] = loadImage("Images/door3.png");
  doorImages[3] = loadImage("Images/door4.png");
  tape.resize(50,50);
  portals[0] = loadImage("Images/portal1.png");
  portals[1] = loadImage("Images/portal2.png");
  horns[0] = loadImage("Images/horn1.png");
  horns[1] = loadImage("Images/horn2.png");
  soundControls[0] = loadImage("Images/sound1.png");
  soundControls[1] = loadImage("Images/sound2.png");
  soundControls[0].resize(70,70);
  soundControls[1].resize(70,70);
  portals[0].resize(150,75);
  portals[1].resize(150,75);
}

Minim minim;

AudioSample jumpSound;
AudioSample dropSound;
AudioSample[] collectTape = new AudioSample[2];
AudioSample[] buttonPress = new AudioSample[2];
AudioSample[] airFlow = new AudioSample[2];
AudioSample[] swooshSounds = new AudioSample[3];
AudioSample[] cassetteSounds = new AudioSample[5];

SoundFile normalSong;
SoundFile reverseSong;

void LoadSounds() {
  minim = new Minim(this);
  
  jumpSound = minim.loadSample("Sounds/jump.mp3");
  dropSound = minim.loadSample("Sounds/drop.mp3");
  collectTape[0] = minim.loadSample("Sounds/collect0.mp3");
  collectTape[1] = minim.loadSample("Sounds/collect1.mp3");
  airFlow[0] = minim.loadSample("Sounds/air2.mp3");
  airFlow[1] = minim.loadSample("Sounds/air1.mp3");
  buttonPress[0] = minim.loadSample("Sounds/button1.mp3");
  buttonPress[1] = minim.loadSample("Sounds/button2.mp3");
  swooshSounds[0] = minim.loadSample("Sounds/swoosh1.mp3");
  swooshSounds[1] = minim.loadSample("Sounds/swoosh2.mp3");
  swooshSounds[2] = minim.loadSample("Sounds/swoosh3.mp3");
  for(int i=0; i<5; i++) {
    cassetteSounds[i] = minim.loadSample("Sounds/cassette"+i+".mp3");
  }
  
  normalSong = new SoundFile(this, "Songs/normal.mp3");
  reverseSong = new SoundFile(this, "Songs/reverse.mp3");
}
