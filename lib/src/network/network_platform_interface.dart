import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_network.dart';
import '../enums/device_util_enum.dart';

abstract class NetworkPlatform extends PlatformInterface {
  /// Constructs a BatteryPlatform.
  NetworkPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkPlatform _instance = MethodChannelNetwork();

  /// The default instance of [NetworkPlatform] to use.
  static NetworkPlatform get instance => _instance;

  /// Platform-specific implementations can set this with their own
  /// platform-specific class when registered.
  static set instance(NetworkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the current network status
  Future<bool> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  /// Stream of charging status changes
  Stream<NetworkStatus> get onNetworkChanged {
    throw UnimplementedError('onNetworkChanged() not implemented.');
  }
}
