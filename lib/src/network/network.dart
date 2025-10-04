import '../enums/device_util_enum.dart';
import 'network_platform_interface.dart';

class NetworkUtils {
  /// Current network status
  static Future<bool> isConnected() => NetworkPlatform.instance.isConnected();

  /// Current network status
  static Stream<NetworkStatus> get onNetworkChange =>
      NetworkPlatform.instance.onNetworkChanged;
}
