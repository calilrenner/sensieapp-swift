import AudioKit
import SoundpipeAudioKit
import DunneAudioKit


class FlangerConductor {
  let engine = AudioEngine()

  
  let osc = Oscillator()
  let flanger: Flanger
  
    init() {
    osc.amplitude = 0.5
    osc.frequency = 400
    flanger = Flanger(osc)
    flanger.depth = 0
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
}
