package com.appodeal.appodeal_flutter

import com.appodeal.ads.Appodeal
import com.appodeal.consent.ConsentForm
import com.appodeal.consent.ConsentInfoUpdateCallback
import com.appodeal.consent.ConsentManager
import com.appodeal.consent.ConsentManagerError
import com.appodeal.consent.ConsentStatus
import com.appodeal.consent.ConsentUpdateRequestParameters
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

internal class AppodealConsentManager(
    private val flutterPlugin: AppodealFlutterPlugin,
    private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
) : MethodChannel.MethodCallHandler {

    val adChannel: MethodChannel by lazy {
        MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "appodeal_flutter/consent_manager"
        ).apply { setMethodCallHandler(this@AppodealConsentManager) }
    }

    private var consentForm: ConsentForm? = null

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "load" -> load(call, result)
            "show" -> show(call, result)
            "loadAndShowConsentFormIfRequired" -> loadAndShowConsentFormIfRequired(call, result)
            "revoke" -> revoke(call, result)
        }
    }

    private fun requestConsentInfoUpdate(call: MethodCall) {
        if (ConsentManager.status != ConsentStatus.Unknown) return

        val args = call.arguments as Map<*, *>
        val appKey = args["appKey"] as String
        val tagForUnderAgeOfConsent = args["tagForUnderAgeOfConsent"] as Boolean

        val parameters = ConsentUpdateRequestParameters(
            activity = flutterPlugin.activity,
            key = appKey,
            tagForUnderAgeOfConsent = tagForUnderAgeOfConsent,
            sdk = "appodeal",
            sdkVersion = Appodeal.getVersion(),
        )

        ConsentManager.requestConsentInfoUpdate(
            parameters = parameters,
            callback = object : ConsentInfoUpdateCallback {
                override fun onFailed(error: ConsentManagerError): Unit =
                    TODO("Not yet implemented")

                override fun onUpdated(): Unit = TODO("Not yet implemented")
            }
        )
    }

    private fun load(call: MethodCall, result: MethodChannel.Result) {
        requestConsentInfoUpdate(call)
        ConsentManager.load(
            context = flutterPlugin.context,
            successListener = { consentForm ->
                this@AppodealConsentManager.consentForm = consentForm
                adChannel.invokeMethod("onConsentFormLoadSuccess", null)
            },
            failureListener = { error ->
                adChannel.invokeMethod("onConsentFormLoadFailure", error.toArg())
            }
        )
        result.success(null)
    }

    private fun show(call: MethodCall, result: MethodChannel.Result) {
        val consentForm = consentForm
        if (consentForm == null) {
            adChannel.invokeMethod(
                "onConsentFormDismissed",
                mapOf("error" to "Consent form is not loaded")
            )
        } else {
            consentForm.show(flutterPlugin.activity) { error ->
                adChannel.invokeMethod("onConsentFormDismissed", error.toArg())
            }
        }
        result.success(null)
    }

    private fun loadAndShowConsentFormIfRequired(call: MethodCall, result: MethodChannel.Result) {
        requestConsentInfoUpdate(call)
        ConsentManager.loadAndShowConsentFormIfRequired(flutterPlugin.activity) { error ->
            adChannel.invokeMethod("onConsentFormDismissed", error.toArg())
        }
        result.success(null)
    }

    private fun revoke(call: MethodCall, result: MethodChannel.Result) {
        ConsentManager.revoke(flutterPlugin.context)
        result.success(null)
    }
}

private fun ConsentManagerError?.toArg(): Map<String, String?> {
    return if (this == null) emptyMap() else mapOf("error" to this.message)
}
