package com.appodeal.appodeal_flutter

import com.appodeal.ads.AppodealRequestCallbacks
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class AppodealRequestCallback(
    private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
) : MethodChannel.MethodCallHandler {

    val adChannel: MethodChannel by lazy {
        MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "appodeal_flutter/request"
        ).apply { setMethodCallHandler(this@AppodealRequestCallback) }
    }

    val adListener: Listener = Listener(adChannel)

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {}

    internal class Listener(private val adChannel: MethodChannel) : AppodealRequestCallbacks {

        override fun onImpression(
            adType: String,
            networkName: String?,
            adUnitName: String?,
            loadedEcpm: Double
        ) {
            adChannel.invokeMethod(
                "onImpression",
                mapOf(
                    "adType" to adType,
                    "networkName" to networkName,
                    "adUnitName" to adUnitName,
                    "loadedEcpm" to loadedEcpm,
                )
            )
        }

        override fun onClick(
            adType: String,
            networkName: String?,
            adUnitName: String?,
            loadedEcpm: Double
        ) {
        }

        override fun onRequestStart(
            adType: String,
            networkName: String?,
            adUnitName: String?,
            predictedEcpm: Double
        ) {
        }

        override fun onRequestFinish(
            adType: String,
            networkName: String?,
            adUnitName: String?,
            loadedEcpm: Double,
            fill: Boolean
        ) {
        }

        override fun onWaterfallStart(adType: String) {}

        override fun onWaterfallFinish(adType: String, loadedEcpm: Double, fill: Boolean) {}
    }
}
