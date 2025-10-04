import UIKit
import Network

struct Utils {

  // MARK: - Network Info
      static func getBatteryLevel() -> Int {
          UIDevice.current.isBatteryMonitoringEnabled = true
          let level = Int(UIDevice.current.batteryLevel * 100)
          return level
      }

      // MARK: - Network Info
      static func isConnected() -> Bool {
          let monitor = NWPathMonitor()
          let path = monitor.currentPath
          let isConnected = path.status == .satisfied
          return isConnected;
      }


      // MARK: - Storage Info
      static func getDeviceResources() -> [String: UInt64] {
          var result: [String: UInt64] = [:]


          let fileURL = URL(fileURLWithPath: NSHomeDirectory())
          if let values = try? fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey]) {
              if let total = values.volumeTotalCapacity {
                  result["storage_total"] = UInt64(total)
              }
              if let free = values.volumeAvailableCapacityForImportantUsage {
                  result["storage_available"] = UInt64(free)
              }
          }


          let totalRAM = ProcessInfo.processInfo.physicalMemory
          result["ram_total"] = totalRAM
          result["ram_available"] = totalRAM

          return result
      }

      // MARK: - Device Info
      static func getDeviceInfo() -> [String: String] {
          let device = UIDevice.current

          return [
              "deviceId": device.identifierForVendor?.uuidString ?? "Unknown",
              "name": device.name,
              "manufacturer": "Apple",
              "brand": device.model,
              "osVersion": "\(device.systemName) \(device.systemVersion)",
          ]
      }
}