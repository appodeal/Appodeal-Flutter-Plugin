package com.appodeal.appodeal_flutter

import android.app.Activity
import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.appodeal.ads.Appodeal
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.appodeal_flutter.native_ad.NativeAdCustomOptions
import com.appodeal.appodeal_flutter.native_ad.NativeAdCustomView
import io.flutter.plugin.platform.PlatformView
import java.lang.ref.WeakReference

internal class AppodealNativeAdView(activity: Activity, arguments: HashMap<*, *>) : PlatformView {
    private val placement: String = arguments["placement"] as? String ?: "default"
    private val params: NativeAdCustomOptions? =
        NativeAdCustomOptions.toNativeAdCustomOptions(arguments["nativeAd"] as Map<String, Any>)

    private val adView: WeakReference<NativeAdView> = WeakReference(getAdView(activity))

    init {
        (adView.get()?.parent as? ViewGroup)?.removeView(adView.get())
    }

    private fun getAdView(context: Context): NativeAdView {
        val adView = NativeAdCustomView(context, params).bind()
        Appodeal.getNativeAds(1).firstOrNull()?.let {
            adView.registerView(it, placement)
        }
        return adView
    }

    override fun getView(): View? = adView.get()

    override fun dispose() {
        adView.get()?.destroy()
    }
}

