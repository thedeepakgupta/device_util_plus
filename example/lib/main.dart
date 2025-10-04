import 'package:flutter/material.dart';
import 'package:device_utils/device_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // BatteryUtils.getBatteryLevel().then((result) {
    //   print('_MyAppState.initState : getBatteryLevel : => $result');
    // });
    //
    // BatteryUtils.onBatteryLevelChanged.listen((level) {
    //   print('_MyAppState.initState:onBatteryLevelChanged => $level');
    // });
    //
    // BatteryUtils.onBatteryStateChanged.listen((status) {
    //   print('_MyAppState.initState:onBatteryLevelChanged => $status');
    // });
    //
    // NetworkUtils.isConnected().then((result) {
    //   print('_MyAppState.initState : isConnected : => $result');
    // });
    //
    // NetworkUtils.onNetworkChange.listen((result) {
    //   print('_MyAppState.initState : onNetworkChange : => $result');
    // });
    //
    // StorageUtils.info().then((data) {
    //   print('StorageUtils => ${data.toString()}');
    // });

    DeviceUtils.info().then((data) {
      print('DeviceUtils => ${data.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(appBar: AppBar(title: const Text('Plugin example app')), body: Center(child: Text('Running on:'))));
  }
}
