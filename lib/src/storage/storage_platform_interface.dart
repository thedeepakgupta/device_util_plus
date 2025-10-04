import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_storage.dart';

abstract class StoragePlatform extends PlatformInterface {
  /// Constructs a BatteryPlatform.
  StoragePlatform() : super(token: _token);

  static final Object _token = Object();

  static StoragePlatform _instance = MethodChannelStorage();

  /// The default instance of [NetworkPlatform] to use.
  static StoragePlatform get instance => _instance;

  /// Platform-specific implementations can set this with their own
  /// platform-specific class when registered.
  static set instance(StoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the current network status
  Future<dynamic> storageInfo() {
    throw UnimplementedError('storageInfo() has not been implemented.');
  }
}
