import Flutter
import UIKit

class BatteryStateStreamHandler: NSObject, FlutterStreamHandler {

    private var eventSink: FlutterEventSink?

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryStateDidChange),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        NotificationCenter.default.removeObserver(self)
        eventSink = nil
        return nil
    }

    @objc private func batteryStateDidChange(notification: Notification) {
        guard let sink = eventSink else { return }
        let state: String
        switch UIDevice.current.batteryState {
        case .charging:
            state = "charging"
        case .full:
            state = "full"
        case .unplugged:
            state = "discharging"
        default:
            state = "unknown"
        }
        sink(state)
    }
}
