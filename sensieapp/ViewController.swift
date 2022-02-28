import UIKit
import CoreMotion

var motionManager: CMMotionManager!
var flangerConductor = FlangerConductor()


class ViewController: UIViewController {
    @IBOutlet weak var rotationXLabel: UILabel!
    @IBOutlet weak var rotationYLabel: UILabel!
    @IBOutlet weak var rotationZLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var frequencySlider: UISlider!
    @IBOutlet weak var depthSlider: UISlider!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var amplitudeSlider: UISlider!
    @IBOutlet weak var amplitudeLabel: UILabel!
    
    @IBAction func startTapped(_ sender: Any) {
        flangerConductor.toggleOscillator()
        
        switch startButton.titleLabel?.text {

          case "start":
            startButton.setTitle("stop", for: .normal)
            startMotionUpdates()

          case "stop":
            startButton.setTitle("start", for: .normal)
            stopMotionUpdates()

          default:
          print("Unable to change button title text.")
          }
    }
    
    @IBAction func frequencyChanged(_ sender: UISlider) {
        flangerConductor.osc.frequency = sender.value
        frequencyLabel.text = String(Int(sender.value))
    }
    
    @IBAction func depthChanged(_ sender: UISlider) {
        flangerConductor.flanger.depth = sender.value
        depthLabel.text = String(format: "%.2f", (sender.value))
    }
    
    @IBAction func amplitudeChanged(_ sender: UISlider) {
        flangerConductor.osc.amplitude = sender.value
        amplitudeLabel.text = String(format: "%.2f", (sender.value))
    }
    
    func initializeMotion() {
        motionManager = CMMotionManager()
    }
    
    func startMotionUpdates() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: motionHandler)
    }
    
    func motionHandler(deviceMotion: CMDeviceMotion?, error: Error?) {
        if let err = error {
            print("motionHandler error: \(err.localizedDescription)")
        } else {
            if let dm = deviceMotion {
                self.processMotionData(dm)
            } else {
                print("motionHandler: deviceMotion = nil")
            }
        }
    }
    
    func processMotionData(_ dm: CMDeviceMotion) {
        let rotX = String(format: "%.3f", dm.rotationRate.x)
        let rotY = String(format: "%.3f", dm.rotationRate.y)
        let rotZ = String(format: "%.3f", dm.rotationRate.z)
        
        let currentFrequency = abs(Float(dm.rotationRate.x * 100 + dm.rotationRate.y * 100 + dm.rotationRate.z * 100))
        
        if(currentFrequency < 400) {
            flangerConductor.osc.frequency = 400
        } else {
            flangerConductor.osc.frequency = currentFrequency
        }
    
        rotationXLabel.text = "RotationRate x: \(rotX)"
        rotationYLabel.text = "RotationRate y: \(rotY)"
        rotationZLabel.text = "RotationRate z: \(rotZ)"
    }
    
    func stopMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeMotion()
        frequencySlider.value = 400
    }
}

