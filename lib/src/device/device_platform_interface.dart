import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_device.dart';

abstract class DevicePlatform extends PlatformInterface {
  /// Constructs a DevicePlatform.
  DevicePlatform() : super(token: _token);

  static final Object _token = Object();

  static DevicePlatform _instance = MethodChannelDevice();

  /// The default instance of [NetworkPlatform] to use.
  static DevicePlatform get instance => _instance;

  /// Platform-specific implementations can set this with their own
  /// platform-specific class when registered.
  static set instance(DevicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the current network status
  Future<dynamic> deviceInfo() {
    throw UnimplementedError('deviceInfo() has not been implemented.');
  }
}
