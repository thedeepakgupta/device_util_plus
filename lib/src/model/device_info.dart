class DeviceInfo {
  final String deviceId;
  final String name;
  final String manufacturer;
  final String osVersion;
  final String brand;

  DeviceInfo({this.deviceId = '', this.name = '', this.manufacturer = '', this.osVersion = '', this.brand = ''});

  factory DeviceInfo.fromJson(Map<String, dynamic> js) => DeviceInfo(
    deviceId: js['deviceId'] ?? '',
    name: js['name'] ?? '',
    manufacturer: js['manufacturer'] ?? '',
    osVersion: js['osVersion'] ?? '',
    brand: js['brand'] ?? '',
  );

  @override
  String toString() {
    return "Id:$deviceId,Name:$name,Manufacturer:$manufacturer,OS:$osVersion,Brand:$brand";
  }
}
