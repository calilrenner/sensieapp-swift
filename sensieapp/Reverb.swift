import AudioKit
import AudioKitUI
import AVFoundation
import SoundpipeAudioKit
import DunneAudioKit
import SwiftUI

class ReverbConductor {
  let engine = AudioEngine()
  
  let osc = Oscillator()
  let reverb: Reverb
  
  init() {
    reverb = Reverb(osc)
      osc.amplitude = 0.02
    
    engine.output = reverb
    
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
