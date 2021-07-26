package com.example.appodeal_flutter

import android.app.Activity
import androidx.annotation.NonNull
import com.appodeal.ads.Appodeal
import com.appodeal.ads.utils.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AppodealFlutterPlugin */
class AppodealFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "appodeal_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }

    when (call.method) {
      "setTesting" -> setTesting(call, result)
      "getPlatformVersion" -> getPlatformVersion(call, result)
      "setAutoCache" -> setAutoCache(call, result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun setTesting(call: MethodCall, result: Result) {
    val args = call.arguments as Map<*, *>
    val value = args["testMode"] as Boolean
    if (value){
      Appodeal.setTesting(value)
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
