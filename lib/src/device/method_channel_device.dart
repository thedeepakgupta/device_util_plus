import 'package:flutter/services.dart';
import 'device_platform_interface.dart';

class MethodChannelDevice extends DevicePlatform {
  static const MethodChannel _channel = MethodChannel('device_utils');

  @override
  Future<dynamic> deviceInfo() async {
    return await _channel.invokeMethod("device-info");
  }

  @override
  Future<dynamic> vibrate() async {
    return await _channel.invokeMethod("device-vibrate");
  }
}
