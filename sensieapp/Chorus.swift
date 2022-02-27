import AudioKit
import SoundpipeAudioKit
import DunneAudioKit

class ChorusConductor {
  let engine = AudioEngine()
  
  let osc = Oscillator()
  let chorus: Chorus
  
  init() {
    chorus = Chorus(osc)
    
    engine.output = chorus
    
    do{
      try engine.start()
    } catch {
      print(error)
    }
  }
  
  func toggleOscillator() {
    osc.isStarted ? osc.stop() : osc.play()
  }
    
    func updateFrequency() {
      if osc.frequency > 600 {
        osc.frequency = 440
      } else {
        osc.frequency = 1000
      }
    }

}
