import Flutter
import UIKit
import Network


class NetworkStatusStreamHandler: NSObject, FlutterStreamHandler {

    private var eventSink: FlutterEventSink?
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue.global(qos: .background)

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events

        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            var status = "unknown"
            if path.status == .satisfied {
                if path.usesInterfaceType(.wifi) {
                    status = "wifi"
                } else if path.usesInterfaceType(.cellular) {
                    status = "mobile"
                } else if path.usesInterfaceType(.wiredEthernet) {
                    status = "ethernet"
                }
            } else {
                status = "none"
            }

            DispatchQueue.main.async {
                self.eventSink?(status)
            }
        }
        monitor?.start(queue: queue)
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        monitor?.cancel()
        monitor = nil
        eventSink = nil
        return nil
    }
}
