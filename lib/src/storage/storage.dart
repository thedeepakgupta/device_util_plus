import 'storage_platform_interface.dart';
import '../model/memory_info.dart';

class StorageUtils {
  /// Memory info
  /// like Storage -> total & available
  /// RAM -> Total & available
  static Future<MemoryInfo> info() async {
    final result = await StoragePlatform.instance.storageInfo();
    return MemoryInfo.fromJson(Map<String,dynamic>.from(result ?? {}));
  }
}
