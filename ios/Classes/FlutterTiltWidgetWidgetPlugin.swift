import Flutter
import UIKit
import CoreMotion

public class FlutterTiltWidgetWidgetPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let eventChannel = FlutterEventChannel(name: "flutter_tilt_widget_event_channel", binaryMessenger: registrar.messenger())

    let tiltEventStreamHandler = TiltEventStreamHandler()
    tiltEventStreamHandler.startMotionUpdates()
    eventChannel.setStreamHandler(tiltEventStreamHandler)
  }
}

class TiltEventStreamHandler: NSObject, FlutterStreamHandler {
    let motionManager = CMMotionManager()
    var sink : FlutterEventSink?
    func startMotionUpdates() {
        print("startMotionUpdates")
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            motionManager.startGyroUpdates(to: OperationQueue.main) { (gyroData, error) in
                if let data = gyroData {
                    let x = gyroData?.rotationRate.x
                    let y = gyroData?.rotationRate.y
                    let z = gyroData?.rotationRate.z
                    self.sink?([x, y, z])
                }
            }
       }
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.sink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }
}
