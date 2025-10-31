import 'device_platform_interface.dart';
import '../model/device_info.dart';

class DeviceUtils {
  static Future<DeviceInfo> info() async {
    final result = await DevicePlatform.instance.deviceInfo();
    return DeviceInfo.fromJson(Map<String, dynamic>.from(result ?? {}));
  }

  static Future<dynamic> vibrate() async {
    final result = await DevicePlatform.instance.vibrate();
    return result;
  }
}
