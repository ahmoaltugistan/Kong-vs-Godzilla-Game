import processing.sound.*;

PImage[] imgKong = new PImage[9];
PImage[] imgGodzilla = new PImage[9];
PImage img1;
PImage img2;
PImage img3; 
PImage img4;
PImage img5;
PImage img6;
PImage img7;

float cloudX1; 
float cloudX2; 
float waveX1;
float waveX2;

int kongFrame = 0, godzillaFrame = 0, frameCounter = 0;

boolean gameStarted = false;
boolean kongHit = false;
boolean godzillaHit = false;
boolean roarPlayed = false;

PFont font;

SoundFile kongRoar;
SoundFile godzillaRoar;
SoundFile punchSound;

void setup() {
  size(1284, 798);
  imageMode(CENTER);
  font = createFont("Impact", 10);

  img1 = loadImage("Clouds 1-01-01.png");
  img2 = loadImage("Clouds 2-01-01.png");
  img3 = loadImage("Sea 2-01.png");
  img4 = loadImage("Wave 1-01-01.png");
  img5 = loadImage("Wave 2-01-01.png");
  img6 = loadImage("Sunny Sky-01.png");
  img7 = loadImage("Building-01.png");

  for (int i = 0; i < 9; i++) {
    imgKong[i] = loadImage("Kong Frame " + (i + 1) + ".png");
    if (imgKong[i] == null) println("Eksik: Kong Frame " + (i + 1));
    
    imgGodzilla[i] = loadImage("Godzilla Frame " + (i + 1) + ".png");
    if (imgGodzilla[i] == null) println("Eksik: Godzilla Frame " + (i + 1));
  }

  cloudX1 = width / 2;
  cloudX2 = width / 2;
  waveX1 = width / 2;
  waveX2 = width / 2;

  kongRoar = new SoundFile(this, "kong growl 2.mp3");
  godzillaRoar = new SoundFile(this, "Godzilla's Hong Kong growl..mp3");
  punchSound = new SoundFile(this, "Punch - Sound Effect (HD).mp3");
}

void draw() {
  if (!gameStarted) {
    background(30);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    textFont(font);
    textSize(100);
    text("KING KONG VS GODZILLA", width / 2, height / 2 - 60);
    fill(200);
    textSize(48);
    text("Push any button to start...", width / 2, height / 2 + 50);
  } else {
    background(255);
    image(img6, width / 2, height / 2, 1284, 798);
    image(img1, cloudX1, height / 2, 1284, 798);
    image(img2, cloudX2, height / 2, 1284, 798);
    image(img3, width / 2, height / 2, 1284, 798);
    image(img4, waveX1, height / 2, 1284, 798);
    image(img5, waveX2, height / 2, 1284, 798);
    image(img7, width / 2, height / 2, 1284, 798);

    cloudX1 += 1.0;
    cloudX2 -= 1.0;
    if (cloudX1 > width + 640) cloudX1 = -640;
    if (cloudX2 < -640) cloudX2 = width + 640;

    waveX1 += 2.0;
    waveX2 -= 2.0;
    if (waveX1 > width + 640) waveX1 = -640;
    if (waveX2 < -640) waveX2 = width + 640;

    if (!roarPlayed) {
      kongRoar.play();
      delay(1500);
      godzillaRoar.play();
      roarPlayed = true;
    }

    if (frameCounter % 7 == 0) {
      kongFrame = kongHit ? 8 : (kongFrame + 1) % 8;
      godzillaFrame = godzillaHit ? 8 : (godzillaFrame + 1) % 8;
    }
    frameCounter++;

    if (imgKong[kongFrame] != null)
      image(imgKong[kongFrame], 639, 400, 1284, 798);
    if (imgGodzilla[godzillaFrame] != null)
      image(imgGodzilla[godzillaFrame], 642, 400, 1284, 798);
  }
}

void keyPressed() {
  gameStarted = true;
}

void mousePressed() {
  if (!gameStarted) {
    gameStarted = true;
    return;
  }
  kongHit = !kongHit;
  godzillaHit = !godzillaHit;
  punchSound.play();
}
