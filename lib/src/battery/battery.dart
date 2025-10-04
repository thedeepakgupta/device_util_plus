import '../enums/device_util_enum.dart';
import 'battery_platform_interface.dart';

class BatteryUtils {
  /// Current battery level
  static Future<int> getBatteryLevel() =>
      BatteryPlatform.instance.getBatteryLevel();

  /// Stream of battery level changes
  static Stream<int> get onBatteryLevelChanged =>
      BatteryPlatform.instance.onBatteryLevelChanged;

  /// Stream of charging state changes
  static Stream<BatteryState> get onBatteryStateChanged =>
      BatteryPlatform.instance.onBatteryStateChanged;
}
