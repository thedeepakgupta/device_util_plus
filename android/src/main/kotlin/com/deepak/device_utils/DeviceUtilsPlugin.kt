package com.deepak.device_utils

import android.content.*
import android.os.Build
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel

/** DeviceUtilsPlugin */
class DeviceUtilsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_utils")
        channel.setMethodCallHandler(this)

        BatteryEventChannel.setupStatus(flutterPluginBinding.binaryMessenger, context)
        BatteryEventChannel.setupLevel(flutterPluginBinding.binaryMessenger, context)
        NetworkEventChannel.setupStatus(flutterPluginBinding.binaryMessenger, context)

    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "battery-level") {
            val batteryLevel = Utils.getBatteryLevel(context)
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else if (call.method == "network-is-connected") {
            result.success(Utils.isConnected(context))
        } else if (call.method == "storage-info") {
            var temp = Utils.storageInfo(context);
            result.success(temp)
        } else if (call.method == "device-info") {
            var temp = Utils.getDeviceInfo(context);
            result.success(temp)
        } else {
            result.notImplemented()
        }
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        BatteryEventChannel.close(context)
        NetworkEventChannel.close(context)
    }
}
