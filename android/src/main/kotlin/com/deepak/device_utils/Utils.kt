package com.deepak.device_utils

//Comman
import android.os.Build
import android.provider.Settings
import android.content.Context
//Battery
import android.os.BatteryManager
//Network
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
//Storage
import java.io.File
import android.os.StatFs
import android.os.Environment
import android.app.ActivityManager


object Utils {

    fun getBatteryLevel(context: Context): Int {
        val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        val level = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        return level.takeIf { it >= 0 } ?: -1
    }

    fun isConnected(context: Context): Boolean {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork ?: return false
        val capabilities = connectivityManager.getNetworkCapabilities(network) ?: return false

        return capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) ||
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) ||
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)
    }

    fun networkType(context: Context): String {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork ?: return "unknown"
        val capabilities = connectivityManager.getNetworkCapabilities(network) ?: return "unknown"

        return when {
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "wifi"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "mobile"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ethernet"
            else -> "unknown"
        }
    }

    fun storageInfo(context: Context): Map<String, Any> {
        val path: File = Environment.getDataDirectory()
        val stat = StatFs(path.path)

        val blockSize: Long
        val totalBlocks: Long
        val availableBlocks: Long

        blockSize = stat.blockSizeLong
        totalBlocks = stat.blockCountLong
        availableBlocks = stat.availableBlocksLong

        val total = totalBlocks * blockSize
        val available = availableBlocks * blockSize

        var storage = mapOf(
            "storage_total" to total,
            "storage_available" to available
        )

        var ram = getRamInfo(context);

        return storage + ram;
    }

    private fun getRamInfo(context: Context): Map<String, Any> {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)

        val total = memoryInfo.totalMem
        val available = memoryInfo.availMem

        return mapOf(
            "ram_total" to total,
            "ram_available" to available
        )
    }

    fun getDeviceInfo(context: Context): Map<String, String> {
        val androidId =
            Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)

        return mapOf(
            "deviceId" to androidId,
            "name" to "${Build.MODEL}",
            "manufacturer" to "${Build.MANUFACTURER}",
            "osVersion" to "${Build.VERSION.SDK_INT}",
            "brand" to "${Build.BRAND}"
        )
    }


}