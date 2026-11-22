package com.crazypenguin.nshoptor

import android.content.Context
import android.os.Build
import android.provider.Settings
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest

internal object TrialDeviceChannel {
    fun register(context: Context, messenger: BinaryMessenger) {
        MethodChannel(messenger, "nshoptor/device_trial").setMethodCallHandler { call, result ->
            if (call.method == "getDeviceTrialId") {
                result.success(deviceId(context))
            } else {
                result.notImplemented()
            }
        }
    }

    private fun deviceId(context: Context): String? {
        // Before Android 8 the value is shared across apps, rather than scoped
        // to the signing key, device and Android user.
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return null
        val id = Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
            ?.takeIf { it.isNotBlank() } ?: return null
        val input = "${context.packageName}:trial:v1:$id".toByteArray(Charsets.UTF_8)
        val digest = MessageDigest.getInstance("SHA-256").digest(input)
        return digest.joinToString("") { "%02x".format(it.toInt() and 0xff) }
    }
}
