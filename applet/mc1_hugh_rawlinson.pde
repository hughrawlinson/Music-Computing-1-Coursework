import javax.sound.midi.*;

//Instantiate SimpleMidiSynth
SimpleMidiSynth synth;

//Instantiate image and various other variables
PImage img;
int counter;
int row = 0;
int note;

void setup(){
  //load image;
  img = loadImage("ikeda.png");
  
  //set window size based on image
  size(img.width,img.height);
  
  //set framerate
  frameRate(480);
  
  //construct midi synth
  synth = new SimpleMidiSynth();
  strokeWeight(3);
  stroke(255,0,0);
}

void draw(){
  //draw image each frame
  image(img,0,0);
  
  //check if note is white or black
  //because the image is greyscale I can do this by only checking one of the colour values of each pixel.
  //the algorithm is designed so that each row of 'barcode' in the image only gets read once.
  //if the note is white, set a low note, if black set a high note.
  if(red(img.pixels[(counter%214) + (counter/214)*9]) > 127){
    note = 48;
  }
  else{
    note = 84;
  }
  
  //draw a point to track where the cursor is in the image.
  point(counter %214, counter/214 * 9 + 3);
  
  //play the note on the synth for the duration required for 120 bpm, treating each note as a semiquaver
  synth.play(note, 100, 125);
  
  //incrmement counter
  counter = (counter + 2);
  
  //if we've gone past the end of the image, exit the program.
  if((counter%214) + (counter/214)*9 > img.width*img.height){
    exit();
  }
}

void stop(){
  synth.close();
  exit();
}
