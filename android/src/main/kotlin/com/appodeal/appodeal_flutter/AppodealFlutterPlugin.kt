package com.appodeal.appodeal_flutter

import androidx.annotation.NonNull
import com.appodeal.ads.Appodeal
import com.appodeal.ads.UserSettings
import com.explorestack.consent.Consent
import com.explorestack.consent.ConsentForm
import com.explorestack.consent.ConsentManager
import com.explorestack.consent.Vendor
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

internal class AppodealFlutterPlugin : AppodealBaseFlutterPlugin() {

    private var _channel: MethodChannel? = null
    private val channel get() = checkNotNull(_channel)

    private var _pluginBinding: FlutterPlugin.FlutterPluginBinding? = null
    private val pluginBinding get() = checkNotNull(_pluginBinding)

    private var consentForm: ConsentForm? = null

    private lateinit var interstitial: AppodealInterstitial
    private lateinit var rewardedVideo: AppodealRewarded
    private lateinit var banner: AppodealBanner
    private lateinit var mrec: AppodealMrec

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        super.onAttachedToEngine(binding)
        _pluginBinding = binding
        _channel = MethodChannel(binding.binaryMessenger, "appodeal_flutter")
        channel.setMethodCallHandler(this)

        interstitial = AppodealInterstitial(binding)
        rewardedVideo = AppodealRewarded(binding)
        banner = AppodealBanner(binding)
        mrec = AppodealMrec(binding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        interstitial.adChannel.setMethodCallHandler(null)
        rewardedVideo.adChannel.setMethodCallHandler(null)
        banner.adChannel.setMethodCallHandler(null)
        mrec.adChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "updateConsent" -> updateConsent(call, result)
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
            "setTriggerOnLoadedOnPrecache" -> setTriggerOnLoadedOnPrecache(call, result)
            "setSharedAdsInstanceAcrossActivities" -> setSharedAdsInstanceAcrossActivities(call, result)
            "setSmartBanners" -> setSmartBanners(call, result)
            "setTabletBanners" -> setTabletBanners(call, result)
            "setBannerAnimation" -> setBannerAnimation(call, result)
            "setBannerRotation" -> setBannerRotation(call, result)
            "trackInAppPurchase" -> trackInAppPurchase(call, result)
            "disableNetwork" -> disableNetwork(call, result)
            "setUserId" -> setUserId(call, result)
            "setUserAge" -> setUserAge(call, result)
            "setUserGender" -> setUserGender(call, result)
            "setTesting" -> setTesting(call, result)
            "setLogLevel" -> setLogLevel(call, result)
            "muteVideosIfCallsMuted" -> muteVideosIfCallsMuted(call, result)
            "setChildDirectedTreatment" -> setChildDirectedTreatment(call, result)
            "setCustomFilter" -> setCustomFilter(call, result)
            "setExtraData" -> setExtraData(call, result)
            "getNativeSDKVersion" -> getNativeSDKVersion(result)
            "setUseSafeArea" -> setUseSafeArea(call, result)
            //Consent logic
            "setStorage" -> setStorage(call, result)
            "setCustomVendor" -> setCustomVendor(call, result)
            "requestConsentInfoUpdate" -> requestConsentInfoUpdate(call, result)
            "getCustomVendor" -> getCustomVendor(call, result)
            "getStorage" -> getStorage(result)
            "shouldShowConsentDialog" -> shouldShowConsentDialog(result)
            "getConsentZone" -> getConsentZone(result)
            "getConsentStatus" -> getConsentStatus(result)
            "getConsent" -> getConsent(result)
            "loadConsentForm" -> loadConsentForm(result)
            "showAsActivityConsentForm" -> showAsActivityConsentForm(result)
            "showAsDialogConsentForm" -> showAsDialogConsentForm(result)
            "consentFormIsLoaded" -> consentFormIsLoaded(result)
            "consentFormIsShowing" -> consentFormIsShowing(result)
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

    private fun getAdType(adId: Int): Int {
        return when (adId) {
            1 -> Appodeal.BANNER
            2 -> Appodeal.BANNER_RIGHT
            3 -> Appodeal.BANNER_TOP
            4 -> Appodeal.BANNER_LEFT
            5 -> Appodeal.BANNER_BOTTOM
            6 -> Appodeal.NATIVE
            7 -> Appodeal.INTERSTITIAL
            8 -> Appodeal.REWARDED_VIDEO
            9 -> Appodeal.MREC

            else -> Appodeal.NONE
        }
    }

    private fun updateConsent(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val hasConsent: Boolean? = args["boolConsent"] as? Boolean
        Appodeal.updateConsent(hasConsent)
        result.success(null)
    }

    private fun initialize(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val appKey = args["appKey"] as String
        @Suppress("UNCHECKED_CAST") val adTypes = args["adTypes"] as List<Int>
        val ads = adTypes.fold(0) { acc, value -> acc or getAdType(value) }
        setCallbacks()
        Appodeal.setSharedAdsInstanceAcrossActivities(true)
        Appodeal.setFramework("flutter", "1.0.5")

        val managerConsent: Consent? = ConsentManager.getInstance(applicationContext).consent
        val booleanConsent: Boolean? = args["boolConsent"] as? Boolean
        when {
            managerConsent != null -> Appodeal.initialize(activity, appKey, ads, managerConsent)
            booleanConsent != null -> Appodeal.initialize(activity, appKey, ads, booleanConsent)
            else -> Appodeal.initialize(activity, appKey, ads)
        }
        result.success(null)
    }

    private fun isInitialized(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.isInitialized(adType))
    }

    private fun setAutoCache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        val autoCache = args["autoCache"] as Boolean
        Appodeal.setAutoCache(adType, autoCache)
        result.success(null)
    }

    private fun isAutoCacheEnabled(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.isAutoCacheEnabled(adType))
    }

    private fun cache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        Appodeal.cache(activity, adType)
        result.success(null)
    }

    private fun isLoaded(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.isLoaded(adType))
    }

    private fun isPrecache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.isPrecache(adType))
    }

    private fun canShow(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        val placement = args["placement"] as String
        result.success(Appodeal.canShow(adType, placement))
    }

    private fun getPredictedEcpm(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.getPredictedEcpm(adType))
    }

    private fun show(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        result.success(Appodeal.show(activity, adType))
    }

    private fun hide(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        Appodeal.hide(activity, adType)
        result.success(null)
    }

    private fun destroy(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        Appodeal.destroy(adType)
        result.success(null)
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

    private fun setTriggerOnLoadedOnPrecache(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val adType = getAdType(args["adType"] as Int)
        val onLoadedTriggerBoth = args["onLoadedTriggerBoth"] as Boolean
        Appodeal.setTriggerOnLoadedOnPrecache(adType, onLoadedTriggerBoth)
        result.success(null)
    }

    private fun setSharedAdsInstanceAcrossActivities(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val onLoadedTriggerBoth = args["sharedAdsInstanceAcrossActivities"] as Boolean
        Appodeal.setSharedAdsInstanceAcrossActivities(onLoadedTriggerBoth)
        result.success(null)
    }

    private fun setSmartBanners(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val smartBannerEnabled = args["smartBannerEnabled"] as Boolean
        Appodeal.setSmartBanners(smartBannerEnabled)
        result.success(null)
    }

    private fun setTabletBanners(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val tabletBannerEnabled = args["tabletBannerEnabled"] as Boolean
        Appodeal.set728x90Banners(tabletBannerEnabled)
        result.success(null)
    }

    private fun setBannerAnimation(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val bannerAnimationEnabled = args["bannerAnimationEnabled"] as Boolean
        Appodeal.setBannerAnimation(bannerAnimationEnabled)
        result.success(null)
    }

    private fun setBannerRotation(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val leftBannerRotation = getAdType(args["leftBannerRotation"] as Int)
        val rightBannerRotation = getAdType(args["rightBannerRotation"] as Int)
        Appodeal.setBannerRotation(leftBannerRotation, rightBannerRotation)
        result.success(null)
    }

    private fun trackInAppPurchase(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val amount = args["amount"] as Double
        val currency = args["currency"] as String
        Appodeal.trackInAppPurchase(activity, amount, currency)
        result.success(null)
    }

    private fun disableNetwork(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val network = args["network"] as String
        val adType = getAdType(args["adType"] as Int)
        Appodeal.disableNetwork(activity, network, adType)
        result.success(null)
    }

    private fun setUserId(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val userId = args["userId"] as String
        Appodeal.setUserId(userId)
        result.success(null)
    }

    private fun setUserAge(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val age = args["age"] as Int
        Appodeal.setUserAge(age)
        result.success(null)
    }

    private fun setUserGender(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        when (args["gender"] as Int) {
            0 -> Appodeal.setUserGender(UserSettings.Gender.OTHER)
            1 -> Appodeal.setUserGender(UserSettings.Gender.MALE)
            2 -> Appodeal.setUserGender(UserSettings.Gender.FEMALE)
        }
        result.success(null)
    }

    private fun muteVideosIfCallsMuted(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val value = args["value"] as Boolean
        if (value) {
            Appodeal.muteVideosIfCallsMuted(value)
        }
        result.success(null)
    }

    private fun setChildDirectedTreatment(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val value = args["value"] as Boolean
        if (value) {
            Appodeal.setChildDirectedTreatment(value)
        }
        result.success(null)
    }

    private fun setCustomFilter(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val name = args["name"] as String
        when (val value = args["value"]) {
            is String -> Appodeal.setCustomFilter(name, value)
            is Int -> Appodeal.setCustomFilter(name, value)
            is Double -> Appodeal.setCustomFilter(name, value)
            is Boolean -> Appodeal.setCustomFilter(name, value)
            is Any -> Appodeal.setCustomFilter(name, value)
        }
        result.success(null)
    }

    private fun setExtraData(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val key = args["key"] as String
        when (val value = args["value"]) {
            is String -> Appodeal.setExtraData(key, value)
            is Int -> Appodeal.setExtraData(key, value)
            is Double -> Appodeal.setExtraData(key, value)
            is Boolean -> Appodeal.setExtraData(key, value)
            is JSONObject -> Appodeal.setExtraData(key, value)
        }
        result.success(null)
    }

    private fun getNativeSDKVersion(result: Result) {
        result.success(Appodeal.getVersion())
    }

    private fun setUseSafeArea(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val value = args["value"] as Boolean
        Appodeal.setUseSafeArea(value)
        result.success(null)
    }

    private fun setCallbacks() {
        Appodeal.setInterstitialCallbacks(interstitial.adListener)
        Appodeal.setRewardedVideoCallbacks(rewardedVideo.adListener)
        Appodeal.setBannerCallbacks(banner.adListener)
        Appodeal.setMrecCallbacks(mrec.adListener)
    }

    // Consent Logic
    private fun shouldShowConsentDialog(result: Result) {
        val shouldShowType: Int =
            when (ConsentManager.getInstance(activity).shouldShowConsentDialog().toString()) {
                Consent.ShouldShow.UNKNOWN.toString() -> 0
                Consent.ShouldShow.TRUE.toString() -> 1
                Consent.ShouldShow.FALSE.toString() -> 2
                else -> 0
            }
        result.success(shouldShowType)
    }

    private fun getConsentZone(result: Result) {
        val consentZoneType: Int = when (ConsentManager.getInstance(activity).consentZone) {
            Consent.Zone.UNKNOWN -> 0
            Consent.Zone.GDPR -> 1
            Consent.Zone.CCPA -> 2
            else -> 0
        }
        result.success(consentZoneType)
    }

    private fun getConsentStatus(result: Result) {
        val consentStatusType: Int = when (ConsentManager.getInstance(activity).consentStatus) {
            Consent.Status.UNKNOWN -> 0
            Consent.Status.PERSONALIZED -> 1
            Consent.Status.PARTLY_PERSONALIZED -> 2
            Consent.Status.NON_PERSONALIZED -> 3
            else -> 0
        }
        result.success(consentStatusType)
    }

    private fun getConsent(result: Result) {
        result.success(ConsentManager.getInstance(activity).consent?.toJSONObject().toString())
    }

    private fun consentFormIsShowing(result: Result) {
        if (consentForm != null) {
            result.success(consentForm?.isShowing)
        } else {
            result.success(false)
        }
    }

    private fun consentFormIsLoaded(result: Result) {
        if (consentForm != null) {
            result.success(consentForm?.isLoaded)
        } else {
            result.success(false)
        }
    }

    private fun showAsDialogConsentForm(result: Result) {
        consentForm?.showAsDialog()
        result.success(null)
    }

    private fun showAsActivityConsentForm(result: Result) {
        consentForm?.showAsActivity()
        result.success(null)
    }

    private fun loadConsentForm(result: Result) {
        consentForm = ConsentForm.Builder(activity)
            .withListener(ConsentFormListenerImpl(channel))
            .build()
        consentForm?.load()
        result.success(null)
    }

    private fun requestConsentInfoUpdate(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        ConsentManager.getInstance(activity)
            .requestConsentInfoUpdate(
                args["appKey"] as String,
                ConsentInfoUpdateListenerImpl(channel)
            )
        result.success(null)
    }

    private fun getStorage(result: Result) {
        val storageType: Int = when (ConsentManager.getInstance(activity).storage) {
            ConsentManager.Storage.NONE -> 0
            ConsentManager.Storage.SHARED_PREFERENCE -> 1
            else -> 0
        }
        result.success(storageType)
    }

    private fun setStorage(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        when (args["storage"] as Int) {
            0 -> ConsentManager.getInstance(activity).storage = ConsentManager.Storage.NONE
            1 -> ConsentManager.getInstance(activity).storage =
                ConsentManager.Storage.SHARED_PREFERENCE
        }
        result.success(null)
    }

    private fun getCustomVendor(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        result.success(
            ConsentManager.getInstance(activity).getCustomVendor(args["bundle"] as String)
                ?.toJSONObject().toString()
        )
    }

    private fun setCustomVendor(call: MethodCall, result: Result) {
        val args = call.arguments as Map<*, *>
        val name = args["name"] as String
        val bundle = args["bundle"] as String
        val policyUrl = args["policyUrl"] as String
        val purposeIds = listOf(args["purposeIds"])
        val featureIds = listOf(args["featureIds"])
        val legitimateInterestPurposeIds = listOf(args["legitimateInterestPurposeIds"])

        ConsentManager.getInstance(activity)
            .setCustomVendor(
                Vendor.Builder(name, bundle, policyUrl)
                    .setPurposeIds(purposeIds as MutableList<Int>)
                    .setFeatureIds(featureIds as MutableList<Int>)
                    .setLegitimateInterestPurposeIds(legitimateInterestPurposeIds as MutableList<Int>)
                    .build()
            )

        result.success(null)
    }
}
