package com.appodeal.appodeal_flutter

import android.app.Activity
import android.view.View
import com.appodeal.ads.Appodeal
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.appodeal_flutter.native_ad.NativeAdOptions
import com.appodeal.appodeal_flutter.native_ad.NativeAdViewBinder
import com.appodeal.appodeal_flutter.native_ad.NativeAdViewType
import io.flutter.plugin.platform.PlatformView
import java.lang.ref.WeakReference

internal class AppodealNativeAdView(activity: Activity, arguments: HashMap<*, *>) : PlatformView {
    private val placement: String = arguments["placement"] as? String ?: "default"

    @Suppress("UNCHECKED_CAST")
    private val nativeAdOptions: NativeAdOptions? =
        NativeAdOptions.toNativeAdOptions(arguments["options"] as Map<String, Any>)

    private val adView: WeakReference<NativeAdView> by lazy {
        val nativeAd = Appodeal.getNativeAds(1).firstOrNull() ?: return@lazy WeakReference(null)
        val nativeAdOptions = nativeAdOptions ?: return@lazy WeakReference(null)

        val nativeAdBinder = NativeAdViewBinder(activity, nativeAdOptions)
        val adView = when (val nativeAdType = nativeAdOptions.nativeAdViewType) {
            NativeAdViewType.Custom -> nativeAdBinder.bindCustomAdView()
            else -> nativeAdBinder.bindTemplateAdView(nativeAdType)
        }
        adView.registerView(nativeAd, placement)
        WeakReference(adView)
    }

    override fun getView(): View? = adView.get()

    override fun dispose() {
        adView.get()?.destroy()
    }
}

