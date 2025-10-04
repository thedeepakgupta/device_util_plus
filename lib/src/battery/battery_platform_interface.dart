import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_battery.dart';
import '../enums/device_util_enum.dart';

abstract class BatteryPlatform extends PlatformInterface {
  /// Constructs a BatteryPlatform.
  BatteryPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryPlatform _instance = MethodChannelBattery();

  /// The default instance of [BatteryPlatform] to use.
  static BatteryPlatform get instance => _instance;

  /// Platform-specific implementations can set this with their own
  /// platform-specific class when registered.
  static set instance(BatteryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the current battery level (0-100)
  Future<int> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  /// Stream of battery level changes
  Stream<int> get onBatteryLevelChanged {
    throw UnimplementedError('onBatteryLevelChanged() not implemented.');
  }

  /// Stream of charging status changes
  Stream<BatteryState> get onBatteryStateChanged {
    throw UnimplementedError('onBatteryStateChanged() not implemented.');
  }
}
