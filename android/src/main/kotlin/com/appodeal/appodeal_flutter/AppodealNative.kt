package com.appodeal.appodeal_flutter

import com.appodeal.ads.NativeAd
import com.appodeal.ads.NativeCallbacks
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class AppodealNative(
    private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding,
) : MethodChannel.MethodCallHandler {

    val adChannel: MethodChannel by lazy {
        MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "appodeal_flutter/native"
        ).apply { setMethodCallHandler(this@AppodealNative) }
    }

    val adListener: Listener = Listener(adChannel)

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {}

    internal class Listener(private val adChannel: MethodChannel) : NativeCallbacks {

        override fun onNativeLoaded() {
            adChannel.invokeMethod("onNativeLoaded", null)
        }


        override fun onNativeFailedToLoad() {
            adChannel.invokeMethod("onNativeFailedToLoad", null)
        }


        override fun onNativeShown(nativeAd: NativeAd?) {
            adChannel.invokeMethod("onNativeShown", mapOf("nativeAd" to nativeAd))
        }


        override fun onNativeShowFailed(nativeAd: NativeAd?) {
            adChannel.invokeMethod("onNativeShowFailed", mapOf("nativeAd" to nativeAd))
        }


        override fun onNativeClicked(nativeAd: NativeAd?) {
            adChannel.invokeMethod("onNativeClicked", mapOf("nativeAd" to nativeAd))
        }

        override fun onNativeExpired() {
            adChannel.invokeMethod("onNativeExpired", null)
        }
    }
}
