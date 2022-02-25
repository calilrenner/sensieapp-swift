import AudioKit
import SoundpipeAudioKit
import DunneAudioKit


class FlangerConductor {
  let engine = AudioEngine()

  
  let osc = Oscillator()
  let flanger: Flanger
  
    init() {
    osc.amplitude = 0.5
    osc.amplitude = 200
    flanger = Flanger(osc)
    engine.output = flanger
          
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
