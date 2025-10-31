# Device Utils

`device_util_plus` is a Flutter plugin that provides essential device information, network utilities, storage details, battery status, and vibration support for both Android and iOS platforms. It supports **real-time updates** for battery and network status using EventChannels.

---

## Platform Support

| Android | iOS |
|:-------:|:---:|
|    ✅    |  ✅  |

## Requirements

* Flutter >=3.29.0
* Dart >=3.7.0 <4.0.0
* iOS >=12.0
* Android >=21

---

## Features

### Storage Info

* Get **Total Storage** and **Available Storage**
* Get **Total RAM** and **Available RAM**

### Network Utils

* Check if the device is **connected** to the internet
* Receive **real-time network status changes** (WiFi, Mobile, Ethernet)

### Battery

* Get **current battery level**
* Receive **real-time battery level changes**
* Receive **real-time battery status changes** (charging, discharging, full, etc.)

### Device Info

* Get **device name**
* Get **manufacturer**
* Get **brand**
* Get **OS version**
* Get **device model**

### Vibration

* Trigger **device vibration** programmatically
* Works on both **Android** and **iOS**

---

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  device_util_plus: latest
```

Then run:

```bash
flutter pub get
```

Or add directly via command line:

```bash
flutter pub add device_util_plus
```

---

## Usage

Import `package:device_util_plus/device_util_plus.dart`, and use the provided utilities:

* `BatteryUtils`
* `NetworkUtils`
* `StorageUtils`
* `DeviceUtils`

Each utility provides access to platform-specific information and functionality.

---

## Examples

### 🔋 Battery

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

---

### 🌐 Network

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

---

### 💾 Storage

```dart
import 'package:device_util_plus/device_util_plus.dart';

StorageUtils.info().then((MemoryInfo data) {
  print('Storage Info => ${data.toString()}');
});
```

#### `MemoryInfo` Properties

* `totalStorage`: Total device storage in MB
* `availableStorage`: Available device storage in MB
* `usedStorage`: Used device storage in MB (`totalStorage - availableStorage`)
* `totalRam`: Total RAM in MB
* `availableRam`: Available RAM in MB
* `usedRam`: Used RAM in MB (`totalRam - availableRam`)

---

### 📱 Device Info

```dart
import 'package:device_util_plus/device_util_plus.dart';

DeviceUtils.info().then((DeviceInfo data) {
  print('Device Info => ${data.toString()}');
});
```

#### `DeviceInfo` Properties

* `deviceId`: A unique identifier for the device
* `name`: The name of the device
* `manufacturer`: Device manufacturer
* `osVersion`: Operating system version
* `brand`: Device brand

---

### 🔔 Vibrate

```dart
import 'package:device_util_plus/device_util_plus.dart';

// Vibrate the device
DeviceUtils.vibrate();
```

This method triggers a short vibration on the device.

> **Note:**
>
> * Works on both Android and iOS
> * On iOS, the vibration behavior depends on the system’s haptic feedback support and user settings.
