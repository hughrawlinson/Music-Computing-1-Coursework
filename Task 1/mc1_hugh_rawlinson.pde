import javax.sound.midi.*;

//Instantiate SimpleMidiSynth
SimpleMidiSynth synth;
SimpleMidiSynth synth2;
int MaxNote = 80;
int MinNote = 55;
int scale = 100;

void setup() {
  //construct midi synth
  synth = new SimpleMidiSynth();
  synth2 = new SimpleMidiSynth();
  frameRate(1);
}

void draw() {
  println(MaxNote - MinNote);
  //play the note on the synth for the duration required for 120 bpm, treating each note as a semiquaver
  int[] note = new int[MaxNote+1];
  note = fillArrayWithValues(note,0);
  note[getMidiNote(round(random(0, 100)), true)] = 100;
  note[getMidiNote(round(random(0, 100)), false)] = 100;
  synth.play(note, 100);
}

void stop() {
  synth.close();
  exit();
}

int[] fillArrayWithValues(int[] array, int value){
  for(int i = 0; i < array.length; i++){
    array[i] = value;
  }
  return array;
}

int getMidiNote(int phase, boolean mode) {
  println(phase);
  int amplitude = MaxNote - MinNote;
  if (mode) {
    return round(MinNote+(amplitude/2)+(sin(((float)phase/ (float)scale)*PI)*amplitude/2));
  }
  else {
    return round(MinNote+(amplitude/2)+(cos(((float)phase/ (float)scale)*PI)*amplitude/2));
  }
}

