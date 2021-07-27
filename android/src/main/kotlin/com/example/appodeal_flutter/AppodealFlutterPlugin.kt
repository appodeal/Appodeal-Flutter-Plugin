package com.example.appodeal_flutter

import android.app.Activity
import androidx.annotation.NonNull
import com.appodeal.ads.Appodeal
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class AppodealFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "appodeal_flutter")
        channel.setMethodCallHandler(this)
        Appodeal.setSharedAdsInstanceAcrossActivities(true)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "initialize" -> initialize(call, result)
            "updateConsent" -> updateConsent(call, result)
            "isInitialized" -> isInitialized(call, result)
            "isAutoCacheEnabled" -> isAutoCacheEnabled(call, result)
            "cache" -> cache(call, result)

            "setTesting" -> setTesting(call, result)
            "getPlatformVersion" -> getPlatformVersion(call, result)
            "setAutoCache" -> setAutoCache(call, result)
            "setLogLevel" -> setLogLevel(call, result)

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
    override fun onDetachedFromActivity() {

    }

    private fun initialize(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val appKey = args["appKey"] as String
        @Suppress("UNCHECKED_CAST") val adTypes = args["adTypes"] as List<Int>
        val hasConsent = args["hasConsent"] as Boolean

        if (appKey.isEmpty()) {
            android.util.Log.d("[AF Plugin]: ", "argument appKey can't be empty or null")
        }

        if (adTypes.isEmpty()) {
            android.util.Log.d("[AF Plugin]: ", "argument adTypes can't be empty or null")
        }
        val ads = adTypes.fold(0) { acc, value -> acc or getAdType(value) }

        Appodeal.initialize(activity, "appKey", ads, hasConsent)

        result.success(null)
    }

    private fun updateConsent(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val hasConsent = args["hasConsent"] as Boolean
        if (hasConsent) {
            Appodeal.updateConsent(hasConsent)
        }

        result.success(null)
    }


    private fun isInitialized(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.isInitialized(adType))
    }

    private fun isAutoCacheEnabled(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.isAutoCacheEnabled(adType))
    }


    private fun setTesting(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val value = args["testMode"] as Boolean
        if (value) {
            Appodeal.setTesting(value)
        }
        result.success(null)
    }

    private fun setLogLevel(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        when (args["logLevel"] as Int) {
            1 -> Appodeal.setLogLevel(com.appodeal.ads.utils.Log.LogLevel.debug)
            2 -> Appodeal.setLogLevel(com.appodeal.ads.utils.Log.LogLevel.verbose)
            else -> Appodeal.setLogLevel(com.appodeal.ads.utils.Log.LogLevel.none)
        }

        result.success(null)
    }

    private fun setAutoCache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        val autoCache = args["autoCache"] as Boolean

        Appodeal.setAutoCache(adType, autoCache)
        result.success(null)
    }

    private fun cache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        Appodeal.cache(activity, adType)
        result.success(null)
    }

    private fun getPlatformVersion(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    private fun getAdType(adId: Int): Int {
        return when (adId) {
            1 -> Appodeal.BANNER
            2 -> Appodeal.NATIVE
            3 -> Appodeal.INTERSTITIAL
            4 -> Appodeal.REWARDED_VIDEO
            5 -> Appodeal.NON_SKIPPABLE_VIDEO
            else -> Appodeal.NONE
        }
    }
}
