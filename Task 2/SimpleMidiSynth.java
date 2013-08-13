import javax.sound.midi.*;

class SimpleMidiSynth{

  Synthesizer synthesizer = null; // the Java MIDI synth
  MidiChannel channel; // the single MIDI channel
  int note; // current playing note

  SimpleMidiSynth(){ 
   
    // Get synth and open it
    try{
      synthesizer = MidiSystem.getSynthesizer();
      synthesizer.open();
    }
    catch (MidiUnavailableException e){
      e.printStackTrace();
    }
    // Set our channel to the first MIDI channel
    MidiChannel[] channels = synthesizer.getChannels();
    channel = channels[0];
  }

  // Simple control change to set pan
  void pan(int i){
    channel.controlChange(10, i);
  }

  // Select an instrument 
  void instrument(int i){
    channel.programChange(0, i);
  }

  // Panic button to kill all sounding notes
  void allNotesOff(){
    channel.allNotesOff();
  }

  // Ask this thread to halt for at least deltaT millis
  void mySleep(long deltaT){
    try{
      Thread.sleep(deltaT);
    }
    catch(InterruptedException e){
    }
  }

  // Play a note at a given velocity. The note is killed at the next call. 
  void play(int noteIn, int vel){
    channel.noteOff(note);
    channel.noteOn(noteIn, vel);
    note = noteIn;
  }

  // Play a note at a given velocity. The note is held for deltaT millis. 
  void play(int note, int vel, long deltaT){

    channel.noteOn(note, vel);
    mySleep(deltaT);
    channel.noteOff(note);
  }
  
  // Play a group of notes simultaneously for deltaT miilis. 
  // Set velocities[i] = 0 for any non-sounding note i in range 0 - velocities.length
  void play(int[] velocities, long deltaT){

    for (int i = 0 ; i < velocities.length; ++i){
      channel.noteOn(i, velocities[i]);
    }

    mySleep(deltaT);

    for (int i = 0 ; i < velocities.length; ++i){
      channel.noteOff(i);
    }
  }

  // Close and reease resources
  void close(){
    synthesizer.close();
  }
}



