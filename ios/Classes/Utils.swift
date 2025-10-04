import UIKit

struct Utils {

  static func getDeviceInfo() -> [String: String] {
    let device = UIDevice.current

    return [
      "deviceId": device.identifierForVendor?.uuidString ?? "Unknown",
      "name": device.model,
      "manufacturer": "Apple",
      "brand": device.model,
      "osVersion": "\(device.systemName) \(device.systemVersion)",
    ]
  }
}