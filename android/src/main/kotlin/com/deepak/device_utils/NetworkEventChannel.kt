package com.deepak.device_utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.NetworkCapabilities

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.BinaryMessenger

object NetworkEventChannel {
    private var networkReceiver: BroadcastReceiver? = null

    fun setupStatus(messenger: BinaryMessenger, context: Context) {
        val channel = EventChannel(messenger, "device_utils/network-status-event")
        channel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                networkReceiver = object : BroadcastReceiver() {
                    override fun onReceive(ctx: Context?, intent: Intent?) {
                        val status = Utils.networkType(context)
                        events?.success(status)
                    }
                }
                val filter = IntentFilter()
                filter.addAction(ConnectivityManager.CONNECTIVITY_ACTION)
                context.registerReceiver(networkReceiver, filter)
            }

            override fun onCancel(arguments: Any?) {
                networkReceiver?.let { context.unregisterReceiver(it) }
                networkReceiver = null
            }
        })
    }

    fun close(context: Context) {
        networkReceiver?.let { context.unregisterReceiver(it) }
        networkReceiver = null
    }
}