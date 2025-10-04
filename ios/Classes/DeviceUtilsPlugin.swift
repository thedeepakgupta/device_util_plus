import Flutter
import UIKit

public class DeviceUtilsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_utils", binaryMessenger: registrar.messenger())
    let instance = DeviceUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "device-info":
      result(Utils.getDeviceInfo())
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
