import easy.ease.*; //extremely important, imports the library EasyEase which allows me to interpolate certain animations

PImage pumpkin; //pumpkin image
PFont font; //harrington 48 font used in the game

int pumpkins = 0, spiders = 0, ghosts = 0, demons = 0, zombies = 0, vampires = 0, horsemen = 0, werewolves = 0, pps = 0; //variables to store the amount of pumpkins and buildings

float pumpkinSize = 400; //default pumpkin size

float intensity = 5;
float totalLength = 1;
float curveSpan = 0.2;
float delay = 0.6;
EasyEase curve = new EasyEase(this, intensity, totalLength, curveSpan, 0); //EasyEase object for curve interpolation


void setup() {
  pumpkins = 0; //initialize integer pumpkin
  
  //size(displayWidth, displayHeight);
  fullScreen(); //make the game fullscreen by default
  
  pumpkin = loadImage("pumpkin.png"); //load pumpkin.png as the variable pumpkin through the relative file path "game/pumpkin.png" which shorthands to just "pumpkin.png"
  font = loadFont("Harrington-48.vlw"); //load font harrington-48.vlw through the relative path "game/data/Harrington-48.vlw" which shorthands to just "Harrington-48.vlw"
  
  imageMode(CENTER); //set image origin
  
  strokeWeight(6); //set drawing border width
  stroke(#FF9100); //set drawing border color
  textFont(font); //set default font
}

void draw() {
  float framedCount = curve.framer(frameCount); //seconds counter for pumpkin animation
  float scaleOut = curve.inOut(framedCount, 385, 400, "alternate"); //interpolation curve for the pumpkin animation
  
  background(#440052); //erase all game elements at the beginning of every draw loop and reset the background color
  
  fill(#9A02A2);
  rect(0, 0, 500, displayHeight); //main container for the pumpkin
  
  if (pumpkins < 1000) {
    textSize(64);
  }
  else if (pumpkins >= 1000) {
    textSize(45);
  } //shrink the "pumpkins" text if the number of pumpkins exceeds 1000, to prevent the text from escapeing the main container
  
  fill(#FF880F);
  text("Pumpkins: " + pumpkins, 75, 100); //pumpkin counter
  textSize(32);
  text("Per second: " + pps, 75, 150); //pumpkins per second display
  
  image(pumpkin, 250, 440, pumpkinSize, pumpkinSize); //display pumpkin.png
  
  fill(#F07800);
  rect(displayWidth - 450, 0, 450, displayHeight); //main building container
  
  fill(#F05C00);
  rect(displayWidth - 450, 0, 450, 100);    //
  rect(displayWidth - 450, 100, 450, 100);  //
  rect(displayWidth - 450, 200, 450, 100);  //
  rect(displayWidth - 450, 300, 450, 100);  //draw the individual containers for the buildings
  rect(displayWidth - 450, 400, 450, 100);  //
  rect(displayWidth - 450, 500, 450, 100);  //
  rect(displayWidth - 450, 600, 450, 100);  //
  
  fill(0);
  text("Spider: 100$P - " + spiders, displayWidth - 420, 60);              //
  text("Ghost: 500$P - " + ghosts, displayWidth - 420, 160);               //
  text("Demon: 1000$P - " + demons, displayWidth - 420, 260);              //
  text("Zombie: 2000$P - " + zombies, displayWidth - 420, 360);            //draw the dynamic labels for the buildings
  text("Vampire: 10000$P - " + vampires, displayWidth - 420, 460);         //
  text("!Head Horseman: 50000$P - " + horsemen, displayWidth - 420, 560);  //headless horseman being written as !Head Horseman is both a joke and a way of fixing a graphical error where the text is too big for the container
  text("Werewolf: 100000$P - " + werewolves, displayWidth - 420, 660);     //
  
  //showMouseCoordinates();
  
  addPumpkins(); //run pumpkin per second iterator
  
  pumpkinSize = scaleOut; //idle animation for the pumpkin
  
  if (mousePressed && mouseX > 75 && mouseX < 430 && mouseY > 250 && mouseY < 630) {
    pumpkinSize -= 10;
  }
  else {
    pumpkinSize = scaleOut;
  } //click animation for pumpkin
  
}

void mousePressed() {
  if (mouseX > 75 && mouseX < 430 && mouseY > 250 && mouseY < 630) {
    pumpkins += 100000;
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 0 && mouseY < 100) {
    spiders();
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 100 && mouseY < 200) {
    ghosts();
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 200 && mouseY < 300) {
    demons();
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 300 && mouseY < 400) {
    zombies();
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 400 && mouseY < 500) {
    vampires();
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 500 && mouseY < 600) {
    horsemen();
  }
  if (mouseX > displayWidth - 450 && mouseX < displayWidth && mouseY > 600 && mouseY < 700) {
    werewolves();
  } //button press detection method, uses mouseClicked and the area of each button to detect which one is being pressed, if at all
}

/*void showMouseCoordinates() {
  fill(0);
  text(mouseX + " , " + mouseY, mouseX, mouseY);
}*/

void spiders() {
  if (pumpkins >= 100) {
    spiders++;
    pps += 1;
    pumpkins -= 100;
  }
} //generalized spider method

void ghosts() {
  if (pumpkins >= 500) {
    ghosts++;
    pps += 10;
    pumpkins -= 500;
  }
} //generalized ghost method

void demons() {
  if (pumpkins >= 1000) {
    demons++;
    pps += 30;
    pumpkins -= 1000;
  }
} //generalized demon method

void zombies() {
  if (pumpkins >= 2000) {
    zombies++;
    pps += 100;
    pumpkins -= 2000;
  }
} //generalized zombie method

void vampires() {
  if (pumpkins >= 10000) {
    vampires++;
    pps += 300;
    pumpkins -= 10000;
  }
} //generalized vampire method

void horsemen() {
  if (pumpkins >= 50000) {
    horsemen++;
    pps += 700;
    pumpkins -= 50000;
  }
} //generalized horseman method

void werewolves() {
  if (pumpkins >= 100000) {
    werewolves++;
    pps += 1000;
    pumpkins -= 100000;
  }
} //generalized werewolf method

void addPumpkins() {
  if ((frameCount % 60) == 0) {
    pumpkins += pps;
  }
} //pumpkins per second method, uses modulo to figure out when the global frameCount is evenly divisible by 60 and then runs if this condition is true. since the program framerate is 60 fps, this means that, if called every frame, addPumpkins() will only add pumpkins every 60 frames, i.e. every second.
