import 'package:flutter/services.dart';
import 'network_platform_interface.dart';
import '../enums/device_util_enum.dart';

class MethodChannelNetwork extends NetworkPlatform {
  static const MethodChannel _channel = MethodChannel('device_utils');
  static const EventChannel _stateChannel = EventChannel('device_utils/network-status-event');

  @override
  Future<bool> isConnected() async {
    return await _channel.invokeMethod("network-is-connected");
  }

  @override
  Stream<NetworkStatus> get onNetworkChanged {
    return _stateChannel.receiveBroadcastStream().map((event) {
      switch (event) {
        case 'wifi':
          return NetworkStatus.wifi;
        case 'mobile':
          return NetworkStatus.mobile;
        case 'ethernet':
          return NetworkStatus.ethernet;
        default:
          return NetworkStatus.unknown;
      }
    });
  }
}
