package com.deepak.device_utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger

object BatteryEventChannel {
    private var batteryLevelReceiver: BroadcastReceiver? = null
    private var batteryStateReceiver: BroadcastReceiver? = null

    fun setupStatus(messenger: BinaryMessenger, context: Context) {
        val channel = EventChannel(messenger, "device_utils/battery-status-event")
        channel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                batteryStateReceiver = object : BroadcastReceiver() {
                    override fun onReceive(ctx: Context?, intent: Intent?) {
                        val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
                        val state = when (status) {
                            BatteryManager.BATTERY_STATUS_CHARGING -> "charging"
                            BatteryManager.BATTERY_STATUS_FULL -> "full"
                            BatteryManager.BATTERY_STATUS_DISCHARGING -> "discharging"
                            else -> "unknown"
                        }
                        events?.success(state)
                    }
                }
                context.registerReceiver(
                    batteryStateReceiver,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                )
            }

            override fun onCancel(arguments: Any?) {
                batteryStateReceiver?.let { context.unregisterReceiver(it) }
                batteryStateReceiver = null
            }
        })
    }

    fun setupLevel(messenger: BinaryMessenger, context: Context) {
        val channel = EventChannel(messenger, "device_utils/battery-level-event")
        channel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                batteryLevelReceiver = object : BroadcastReceiver() {
                    override fun onReceive(ctx: Context?, intent: Intent?) {
                        val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
                        events?.success(level)
                    }
                }
                context.registerReceiver(
                    batteryLevelReceiver,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                )
            }

            override fun onCancel(arguments: Any?) {
                batteryLevelReceiver?.let { context.unregisterReceiver(it) }
                batteryLevelReceiver = null
            }
        })
    }

    fun close(context: Context) {
        batteryStateReceiver?.let { context.unregisterReceiver(it) }
        batteryStateReceiver = null

        batteryLevelReceiver?.let { context.unregisterReceiver(it) }
        batteryLevelReceiver = null
    }
}