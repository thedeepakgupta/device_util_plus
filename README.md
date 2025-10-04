# Device Utils

`device_util_plus` is a Flutter plugin that provides essential device information, network utilities, storage details, and battery status for both Android and iOS platforms. It supports **real-time updates** for battery and network status using EventChannels.

---

## Platform Support

| Android | iOS | 
|:-------:|:---:| 
|    ✅    |  ✅  | 

## Requirements

- Flutter >=3.29.0
- Dart >=3.7.0 <4.0.0
- iOS >=12.0
- Android >= 21

## Features

### Storage Info
- Get **Total Storage** and **Available Storage**
- Get **Total RAM** and **Available RAM**

### Network Utils
- Check if the device is **connected** to the internet
- Receive **real-time network status changes** (WiFi, Mobile, Ethernet)

### Battery
- Get **current battery level**
- Receive **real-time battery level changes**
- Receive **real-time battery status changes** (charging, discharging, full, etc.)

### Device Info
- Get **device name**
- Get **manufacturer**
- Get **brand**
- Get **OS version**
- Get **device model**

---

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  device_util_plus: latest
```  

Then run:
``` bash
flutter pub get
```

Add by command line:
``` bash
flutter pub add device_util_plus
```

## Usage

Import `package:device_util_plus/device_util_plus.dart`, instantiate `BatteryUtils`,`NetworkUtils`,`StorageUtils` & `DeviceUtils` and use the Android and iOS get platform-specific device information.

##  Examples

### Battery

```dart
import 'package:device_util_plus/device_util_plus.dart';

BatteryUtils.getBatteryLevel().then((result) {
  print('Battery Level => $result');
});

BatteryUtils.onBatteryLevelChanged.listen((level) {
  print('Battery Level Changed => $level');
});

BatteryUtils.onBatteryStateChanged.listen((status) {
  print('Battery Status Changed => $status');
});
```

### Network

```dart
import 'package:device_util_plus/device_util_plus.dart';

// Check connectivity
NetworkUtils.isConnected().then((result) {
  print('Is Connected => $result');
});

// Listen to network changes
NetworkUtils.onNetworkChange.listen((result) {
  print('Network Status Changed => $result'); // wifi, mobile, ethernet, none
});
```

### Storage

```dart
import 'package:device_util_plus/device_util_plus.dart';

StorageUtils.info().then((MemoryInfo data) {
  print('Storage Info => ${data.toString()}');
});
```

The `MemoryInfo` class provides detailed information about the device's **storage** and **RAM**. It allows you to retrieve both total and available memory, as well as calculate used memory. Values are returned in **megabytes (MB)** for easier readability.

#### Properties

* `totalStorage`: Total device storage in MB
* `availableStorage`: Available device storage in MB
* `usedStorage`: Used device storage in MB (calculated as `totalStorage - availableStorage`)
* `totalRam`: Total RAM in MB
* `availableRam`: Available RAM in MB
* `usedRam`: Used RAM in MB (calculated as `totalRam - availableRam`)


### Device Info

```dart
import 'package:device_util_plus/device_util_plus.dart';

DeviceUtils.info().then((DeviceInfo data) {
  print('Device Info => ${data.toString()}');
});
```

The `DeviceInfo` class provides detailed information about a device’s **identity and specifications**, including manufacturer, brand, OS version, and more.

#### Properties

* `deviceId`: A unique identifier for the device (String)
* `name`: The name of the device (String)
* `manufacturer`: Device manufacturer (String)
* `osVersion`: Operating system version (String)
* `brand`: Device brand (String)
