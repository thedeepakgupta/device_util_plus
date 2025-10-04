class MemoryInfo {
  final num _totalStorage;
  final num _availableStorage;
  final num _totalRam;
  final num _availableRam;

  MemoryInfo(
    this._totalStorage,
    this._availableStorage,
    this._totalRam,
    this._availableRam,
  );

  factory MemoryInfo.fromJson(Map<String, dynamic> json) => MemoryInfo(
    json['storage_total'] ?? 0,
    json['storage_available'] ?? 0,
    json['ram_total'] ?? 0,
    json['ram_available'] ?? 0,
  );

  // Getter methods
  num get totalStorage => _totalStorage / 1024 / 1024;

  num get availableStorage => _availableStorage / 1024 / 1024;

  num get usedStorage => totalStorage - availableStorage;

  num get totalRam => _totalRam / 1024 / 1024;

  num get availableRam => _availableRam / 1024 / 1024;

  num get usedRam => totalRam - availableRam;

  @override
  String toString() {
    return "Total Storage: $totalStorage, Total Ram: $totalRam";
  }
}
