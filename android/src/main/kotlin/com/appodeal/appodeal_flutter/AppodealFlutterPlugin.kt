package com.appodeal.appodeal_flutter

import com.appodeal.ads.Appodeal
import com.appodeal.ads.inapp.InAppPurchase
import com.appodeal.ads.inapp.InAppPurchase.Type
import com.appodeal.ads.inapp.InAppPurchaseValidateCallback
import com.appodeal.ads.initializing.ApdInitializationCallback
import com.appodeal.ads.initializing.ApdInitializationError
import com.appodeal.ads.initializing.ApdInitializationError.*
import com.appodeal.ads.regulator.CCPAUserConsent
import com.appodeal.ads.regulator.GDPRUserConsent
import com.appodeal.ads.service.ServiceError
import com.appodeal.ads.utils.Log.LogLevel
import com.appodeal.consent.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

internal class AppodealFlutterPlugin : AppodealBaseFlutterPlugin() {

    private var _channel: MethodChannel? = null
    private val channel get() = checkNotNull(_channel)

    private var _pluginBinding: FlutterPlugin.FlutterPluginBinding? = null
    private val pluginBinding get() = checkNotNull(_pluginBinding)

    @Deprecated("Will be removed in future releases.")
    private var _consentForm: ConsentForm? = null

    @Deprecated("Will be removed in future releases.")
    private val consentForm get() = checkNotNull(_consentForm)

    private val adRevenueCallback by lazy { AppodealAdRevenueCallback(pluginBinding) }

    private val interstitial by lazy { AppodealInterstitial(pluginBinding) }
    private val rewardedVideo by lazy { AppodealRewarded(pluginBinding) }
    private val banner by lazy { AppodealBanner(pluginBinding) }
    private val mrec by lazy { AppodealMrec(pluginBinding) }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        super.onAttachedToEngine(binding)
        _pluginBinding = binding
        _channel = MethodChannel(binding.binaryMessenger, "appodeal_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        adRevenueCallback.adChannel.setMethodCallHandler(null)
        interstitial.adChannel.setMethodCallHandler(null)
        rewardedVideo.adChannel.setMethodCallHandler(null)
        banner.adChannel.setMethodCallHandler(null)
        mrec.adChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setTestMode" -> setTestMode(call, result)
            "isTestMode" -> isTestMode(call, result)
            "setLogLevel" -> setLogLevel(call, result)
            "updateGDPRUserConsent" -> updateGDPRUserConsent(call, result)
            "updateCCPAUserConsent" -> updateCCPAUserConsent(call, result)
            "initialize" -> initialize(call, result)
            "isInitialized" -> isInitialized(call, result)
            "setAutoCache" -> setAutoCache(call, result)
            "isAutoCacheEnabled" -> isAutoCacheEnabled(call, result)
            "cache" -> cache(call, result)
            "isLoaded" -> isLoaded(call, result)
            "isPrecache" -> isPrecache(call, result)
            "canShow" -> canShow(call, result)
            "getPredictedEcpm" -> getPredictedEcpm(call, result)
            "show" -> show(call, result)
            "hide" -> hide(call, result)
            "destroy" -> destroy(call, result)
            //Extra logic
            "setAdViewAutoResume" -> setAdViewAutoResume(call, result)
            "isAdViewAutoResume" -> isAdViewAutoResume(call, result)
            "setSmartBanners" -> setSmartBanners(call, result)
            "isSmartBanners" -> isSmartBanners(call, result)
            "setTabletBanners" -> setTabletBanners(call, result)
            "isTabletBanners" -> isTabletBanners(call, result)
            "setBannerAnimation" -> setBannerAnimation(call, result)
            "isBannerAnimation" -> isBannerAnimation(call, result)
            "setBannerRotation" -> setBannerRotation(call, result)
            "disableNetwork" -> disableNetwork(call, result)
            "muteVideosIfCallsMuted" -> muteVideosIfCallsMuted(call, result)
            "isMuteVideosIfCallsMuted" -> isMuteVideosIfCallsMuted(call, result)
            "setChildDirectedTreatment" -> setChildDirectedTreatment(call, result)
            "isChildDirectedTreatment" -> isChildDirectedTreatment(call, result)
            "setUseSafeArea" -> setUseSafeArea(call, result)
            "isUseSafeArea" -> isUseSafeArea(call, result)
            "setUserId" -> setUserId(call, result)
            "getUserId" -> getUserId(call, result)
            "setCustomFilter" -> setCustomFilter(call, result)
            "setExtraData" -> setExtraData(call, result)
            "getPlatformSdkVersion" -> getPlatformSdkVersion(call, result)
            //Services logic
            "logEvent" -> logEvent(call, result)
            "validateInAppPurchase" -> validateInAppPurchase(call, result)
            //Consent logic
            "loadConsentForm" -> loadConsentForm(call, result)
            "showConsentForm" -> showConsentForm(call, result)
            "setCustomVendor" -> setCustomVendor(call, result)
            else -> result.notImplemented()
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        super.onAttachedToActivity(binding)
        pluginBinding.platformViewRegistry.apply {
            registerViewFactory(
                "appodeal_flutter/banner_view",
                AppodealAdViewFactory(activity)
            )
        }
    }

    private fun setTestMode(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isTestMode = args["isTestMode"] as Boolean
        Appodeal.setTesting(isTestMode)
        result.success(null)
    }

    private fun isTestMode(call: MethodCall, result: Result) {
        result.success(isTestMode)
    }

    private fun setLogLevel(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        when (args["logLevel"] as Int) {
            1 -> Appodeal.setLogLevel(LogLevel.debug)
            2 -> Appodeal.setLogLevel(LogLevel.verbose)
            else -> Appodeal.setLogLevel(LogLevel.none)
        }
        result.success(null)
    }

    private fun updateGDPRUserConsent(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        when (args["gdprUserConsent"] as Int) {
            -1 -> Appodeal.updateGDPRUserConsent(GDPRUserConsent.NonPersonalized)
            0 -> Appodeal.updateGDPRUserConsent(GDPRUserConsent.Unknown)
            1 -> Appodeal.updateGDPRUserConsent(GDPRUserConsent.Personalized)
        }
        result.success(null)
    }

    private fun updateCCPAUserConsent(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        when (args["ccpaUserConsent"] as Int) {
            -1 -> Appodeal.updateCCPAUserConsent(CCPAUserConsent.OptOut)
            0 -> Appodeal.updateCCPAUserConsent(CCPAUserConsent.Unknown)
            1 -> Appodeal.updateCCPAUserConsent(CCPAUserConsent.OptIn)
        }
        result.success(null)
    }

    private fun initialize(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val appKey = args["appKey"] as String
        val sdkVersion = args["sdkVersion"] as String
        val adTypes = args["adTypes"] as Int
        Appodeal.setAdRevenueCallbacks(adRevenueCallback.adListener)
        Appodeal.setInterstitialCallbacks(interstitial.adListener)
        Appodeal.setRewardedVideoCallbacks(rewardedVideo.adListener)
        Appodeal.setBannerCallbacks(banner.adListener)
        Appodeal.setMrecCallbacks(mrec.adListener)
        Appodeal.setSmartBanners(isSmartBannersEnabled)
        Appodeal.set728x90Banners(isTabletBannerEnabled)
        Appodeal.setBannerRotation(90, -90) // for iOS platform behavior sync
        Appodeal.setSharedAdsInstanceAcrossActivities(true)
        Appodeal.setFramework("flutter", sdkVersion)
        Appodeal.initialize(activity, appKey, adTypes, object : ApdInitializationCallback {
            override fun onInitializationFinished(errors: List<ApdInitializationError>?) =
                channel.invokeMethod("onInitializationFinished", errors?.toArg())
        })
        result.success(null)
    }

    private fun isInitialized(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        result.success(Appodeal.isInitialized(adType))
    }

    private fun setAutoCache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        val isAutoCache = args["isAutoCache"] as Boolean
        Appodeal.setAutoCache(adType, isAutoCache)
        result.success(null)
    }

    private fun isAutoCacheEnabled(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        result.success(Appodeal.isAutoCacheEnabled(adType))
    }

    private fun cache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        Appodeal.cache(activity, adType)
        result.success(null)
    }

    private fun isLoaded(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        result.success(Appodeal.isLoaded(adType))
    }

    private fun isPrecache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        result.success(Appodeal.isPrecache(adType))
    }

    private fun canShow(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        val placement = args["placement"] as String
        result.success(Appodeal.canShow(adType, placement))
    }

    private fun getPredictedEcpm(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        result.success(Appodeal.getPredictedEcpm(adType))
    }

    private fun show(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        val placement = args["placement"] as String
        result.success(Appodeal.show(activity, adType, placement))
    }

    private fun hide(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        Appodeal.hide(activity, adType)
        result.success(null)
    }

    private fun destroy(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = args["adType"] as Int
        Appodeal.destroy(adType)
        result.success(null)
    }

    private fun setAdViewAutoResume(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val isAdViewAutoResumeEnabled = args["isAdViewAutoResume"] as Boolean
        Appodeal.setSharedAdsInstanceAcrossActivities(isAdViewAutoResumeEnabled)
        result.success(null)
    }

    private fun isAdViewAutoResume(call: MethodCall, result: Result) {
        result.success(Appodeal.isSharedAdsInstanceAcrossActivities())
    }

    private fun setSmartBanners(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isSmartBannersEnabled = args["isSmartBannersEnabled"] as Boolean
        Appodeal.setSmartBanners(isSmartBannersEnabled)
        result.success(null)
    }

    private fun isSmartBanners(call: MethodCall, result: Result) {
        result.success(isSmartBannersEnabled)
    }

    private fun setTabletBanners(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isTabletBannerEnabled = args["isTabletBannerEnabled"] as Boolean
        Appodeal.set728x90Banners(isTabletBannerEnabled)
        result.success(null)
    }

    private fun isTabletBanners(call: MethodCall, result: Result) {
        result.success(isTabletBannerEnabled)
    }

    private fun setBannerAnimation(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isBannerAnimationEnabled = args["isBannerAnimationEnabled"] as Boolean
        Appodeal.setBannerAnimation(isBannerAnimationEnabled)
        result.success(null)
    }

    private fun isBannerAnimation(call: MethodCall, result: Result) {
        result.success(isBannerAnimationEnabled)
    }

    private fun setBannerRotation(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val leftBannerRotation = args["leftBannerRotation"] as Int
        val rightBannerRotation = args["rightBannerRotation"] as Int
        Appodeal.setBannerRotation(leftBannerRotation, rightBannerRotation)
        result.success(null)
    }

    private fun disableNetwork(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val network = args["network"] as String
        val adType = args["adType"] as Int
        Appodeal.disableNetwork(network, adType)
        result.success(null)
    }

    private fun muteVideosIfCallsMuted(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isMuteVideosIfCallsMuted = args["isMuteVideosIfCallsMuted"] as Boolean
        Appodeal.muteVideosIfCallsMuted(isMuteVideosIfCallsMuted)
        result.success(null)
    }

    private fun isMuteVideosIfCallsMuted(call: MethodCall, result: Result) {
        result.success(isMuteVideosIfCallsMuted)
    }

    private fun setChildDirectedTreatment(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isChildDirectedTreatment = args["isChildDirectedTreatment"] as Boolean
        Appodeal.setChildDirectedTreatment(isChildDirectedTreatment)
        result.success(null)
    }

    private fun isChildDirectedTreatment(call: MethodCall, result: Result) {
        result.success(isChildDirectedTreatment)
    }

    private fun setUseSafeArea(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        isUseSafeArea = args["isUseSafeArea"] as Boolean
        Appodeal.setUseSafeArea(isUseSafeArea)
        result.success(null)
    }

    private fun isUseSafeArea(call: MethodCall, result: Result) {
        result.success(isUseSafeArea)
    }

    private fun setUserId(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        Appodeal.setUserId(args["userId"] as String)
        result.success(null)
    }

    private fun getUserId(call: MethodCall, result: Result) {
        result.success(Appodeal.getUserId())
    }

    private fun setCustomFilter(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val name = args["name"] as String
        when (val value = args["value"]) {
            is Int -> Appodeal.setCustomFilter(name, value)
            is Double -> Appodeal.setCustomFilter(name, value)
            else -> Appodeal.setCustomFilter(name, value)
        }
        result.success(null)
    }

    private fun setExtraData(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val key = args["key"] as String
        val value = args["value"]
        Appodeal.setExtraData(key, value)
        result.success(null)
    }

    private fun getPlatformSdkVersion(call: MethodCall, result: Result) {
        result.success(Appodeal.getVersion())
    }

    //Services logic
    private fun logEvent(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val eventName = args["eventName"] as String
        @Suppress("UNCHECKED_CAST") val params = args["params"] as Map<String, *>
        Appodeal.logEvent(eventName, params)
        result.success(null)
    }

    private fun validateInAppPurchase(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val type = args["type"] as Int
        val price = args["price"] as String
        val currency = args["currency"] as String
        val publicKey = args["publicKey"] as? String?
        val signature = args["signature"] as? String?
        val purchaseData = args["purchaseData"] as? String?
        val developerPayload = args["developerPayload"] as? String?
        val sku = args["sku"] as? String?
        val orderId = args["orderId"] as? String?
        val purchaseToken = args["purchaseToken"] as? String?
        val purchaseTimestamp = args["purchaseTimestamp"] as Int
        @Suppress("UNCHECKED_CAST") val additionalParameters =
            args["additionalParameters"] as Map<String, String>
        val purchase: InAppPurchase = when (type) {
            Type.InApp.ordinal -> InAppPurchase.newInAppBuilder()
            Type.Subs.ordinal -> InAppPurchase.newSubscriptionBuilder()
            else -> return channel.invokeMethod("onInAppPurchaseValidateFail", null)
        }.withPrice(price)
            .withCurrency(currency)
            .withPublicKey(publicKey)
            .withSignature(signature)
            .withPurchaseData(purchaseData)
            .withDeveloperPayload(developerPayload)
            .withSku(sku)
            .withOrderId(orderId)
            .withPurchaseToken(purchaseToken)
            .withPurchaseTimestamp(purchaseTimestamp.toLong())
            .withAdditionalParams(additionalParameters)
            .build()
        Appodeal.validateInAppPurchase(
            context,
            purchase,
            object : InAppPurchaseValidateCallback {
                override fun onInAppPurchaseValidateFail(
                    purchase: InAppPurchase,
                    errors: List<ServiceError>
                ) = channel.invokeMethod("onInAppPurchaseValidateFail", errors.toArg())

                override fun onInAppPurchaseValidateSuccess(
                    purchase: InAppPurchase,
                    errors: List<ServiceError>?
                ) = channel.invokeMethod("onInAppPurchaseValidateSuccess", errors?.toArg())
            })
        result.success(null)
    }

    // Consent Logic
    private fun loadConsentForm(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val appKey = args["appKey"] as String
        ConsentManager.requestConsentInfoUpdate(
            context,
            appKey,
            object : IConsentInfoUpdateListener {
                override fun onConsentInfoUpdated(consent: Consent) {
                    _consentForm = ConsentForm(
                        context,
                        object : IConsentFormListener {
                            override fun onConsentFormClosed(consent: Consent) =
                                channel.invokeMethod("onConsentFormClosed", null)

                            override fun onConsentFormError(error: ConsentManagerError) =
                                channel.invokeMethod("onConsentFormShowFailed", error.toArg())

                            override fun onConsentFormLoaded(consentForm: ConsentForm) =
                                channel.invokeMethod("onConsentFormLoaded", null)

                            override fun onConsentFormOpened() =
                                channel.invokeMethod("onConsentFormOpened", null)
                        }
                    )
                    consentForm.load()
                }

                override fun onFailedToUpdateConsentInfo(error: ConsentManagerError) {
                    channel.invokeMethod("onConsentFormLoadError", error.toArg())
                }
            }
        )
    }

    private fun showConsentForm(call: MethodCall, result: Result) {
        _consentForm = _consentForm ?: run {
            ConsentForm(
                context,
                object : IConsentFormListener {
                    override fun onConsentFormClosed(consent: Consent) =
                        channel.invokeMethod("onConsentFormClosed", null)

                    override fun onConsentFormError(error: ConsentManagerError) =
                        channel.invokeMethod("onConsentFormShowFailed", error.toArg())

                    override fun onConsentFormLoaded(consentForm: ConsentForm) =
                        channel.invokeMethod("onConsentFormLoaded", null)

                    override fun onConsentFormOpened() =
                        channel.invokeMethod("onConsentFormOpened", null)
                }
            )
        }
        consentForm.show()
        result.success(null)
    }

    private fun setCustomVendor(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val name = args["name"] as String
        val bundle = args["bundle"] as String
        val policyUrl = args["policyUrl"] as String
        @Suppress("UNCHECKED_CAST") val purposeIds: List<Int> =
            (args["purposeIds"] as? List<Int>).orEmpty()
        @Suppress("UNCHECKED_CAST") val featureIds: List<Int> =
            (args["featureIds"] as? List<Int>).orEmpty()
        @Suppress("UNCHECKED_CAST") val legitimateInterestPurposeIds =
            (args["legitimateInterestPurposeIds"] as? List<Int>).orEmpty()
        val vendor = Vendor.Builder(
            name = name,
            bundle = bundle,
            policyUrl = policyUrl,
            purposeIds = purposeIds,
            featureIds = featureIds,
            legitimateInterestPurposeIds = legitimateInterestPurposeIds
        ).build()
        ConsentManager.customVendors[name] = vendor
        result.success(null)
    }
}

private var isTestMode: Boolean = false
private var isSmartBannersEnabled: Boolean = false
private var isTabletBannerEnabled: Boolean = false
private var isBannerAnimationEnabled: Boolean = false
private var isMuteVideosIfCallsMuted: Boolean = false
private var isChildDirectedTreatment: Boolean = false
private var isUseSafeArea: Boolean = false

private fun ConsentManagerError.toArg(): Map<String, List<String>> =
    mapOf("errors" to listOf("${this.event}: ${this.message}"))

private fun List<ApdInitializationError>.toArg(): Map<String, List<String>> {
    val arg = this.map { error ->
        when (error) {
            is Critical -> "Critical: ${error::class.simpleName} ${error.description}"
            is NonCritical -> "NonCritical: ${error::class.simpleName} [${error.componentName}] ${error.description}"
            is InternalError -> "InternalError: ${error::class.simpleName} ${error.message}"
        }
    }
    return mapOf("errors" to arg)
}

@JvmName("toArgServiceError")
private fun List<ServiceError>.toArg(): Map<String, List<String>> {
    val arg = this.map { "${it::class.simpleName} [${it.componentName}] ${it.description}" }
    return mapOf("errors" to arg)
}
