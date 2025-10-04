import 'package:flutter/services.dart';
import 'storage_platform_interface.dart';

class MethodChannelStorage extends StoragePlatform {
  static const MethodChannel _channel = MethodChannel('device_utils');

  @override
  Future<dynamic> storageInfo() async {
    return await _channel.invokeMethod("storage-info");
  }
}
