import 'package:flutter/services.dart';
import 'battery_platform_interface.dart';
import '../enums/device_util_enum.dart';

class MethodChannelBattery extends BatteryPlatform {
  static const MethodChannel _channel = MethodChannel('device_utils');
  static const EventChannel _levelChannel = EventChannel(
    'device_utils/battery-level-event',
  );
  static const EventChannel _stateChannel = EventChannel(
    'device_utils/battery-status-event',
  );

  @override
  Future<int> getBatteryLevel() async {
    final int batteryLevel = await _channel.invokeMethod('battery-level');
    return batteryLevel;
  }

  @override
  Stream<int> get onBatteryLevelChanged {
    return _levelChannel.receiveBroadcastStream().map((event) => event as int);
  }

  @override
  Stream<BatteryState> get onBatteryStateChanged {
    return _stateChannel.receiveBroadcastStream().map((event) {
      switch (event) {
        case 'charging':
          return BatteryState.charging;
        case 'discharging':
          return BatteryState.discharging;
        case 'full':
          return BatteryState.full;
        default:
          return BatteryState.unknown;
      }
    });
  }
}
