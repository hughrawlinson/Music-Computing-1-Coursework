import javax.sound.midi.*;

SimpleMidiSynth synth;

PImage img;
int counter;
int note;

void setup(){
  img = loadImage("ikeda.png");
  size(img.width,img.height);
  int w = img.width;
  int h = img.height;
  frameRate(480);
  colorMode(RGB, 127);
  synth = new SimpleMidiSynth();
}

void draw(){
  image(img,0,0);
  
  counter = counter + 2;
  
  if(counter > img.width * img.height){
    this.stop();
  }
  
  if(red(img.pixels[counter]) > 63){
    note = 48;
  }
  else{
    note = 84;
  }
  
  synth.play(note, 100, 125);
}

void stop(){
  synth.close();
}

