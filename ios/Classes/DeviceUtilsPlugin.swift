import Flutter
import UIKit

public class DeviceUtilsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_utils", binaryMessenger: registrar.messenger())
    let instance = DeviceUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)


// Battery level EventChannel
        let levelChannel = FlutterEventChannel(name: "device_utils/battery-level-event", binaryMessenger: registrar.messenger())
        let levelHandler = BatteryLevelStreamHandler()
        levelChannel.setStreamHandler(levelHandler)
//         instance.batteryLevelStreamHandler = levelHandler


// Battery state EventChannel
        let stateChannel = FlutterEventChannel(name: "device_utils/battery-status-event", binaryMessenger: registrar.messenger())
        let stateHandler = BatteryStateStreamHandler()
        stateChannel.setStreamHandler(stateHandler)
//         instance.batteryStateStreamHandler = stateHandler

        let networkChannel = FlutterEventChannel(name: "device_utils/network-status-event", binaryMessenger: registrar.messenger())
        let networkHandler = NetworkStatusStreamHandler()
        networkChannel.setStreamHandler(networkHandler)
//         instance.batteryStateStreamHandler = stateHandler

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "battery-level":
       result(Utils.getBatteryLevel())
    case "network-is-connected":
       result(Utils.isConnected())
    case "storage-info":
      result(Utils.getDeviceResources())
    case "device-info":
      result(Utils.getDeviceInfo())
    case "device-vibrate":
      Utils.vibrateDevice()
      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
