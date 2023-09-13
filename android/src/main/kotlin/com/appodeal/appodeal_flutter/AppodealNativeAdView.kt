package com.appodeal.appodeal_flutter

import android.app.Activity
import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.appodeal.ads.Appodeal
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.ads.nativead.NativeAdViewAppWall
import com.appodeal.ads.nativead.NativeAdViewContentStream
import com.appodeal.ads.nativead.NativeAdViewNewsFeed
import com.appodeal.appodeal_flutter.native_params.NativeParams
import com.appodeal.appodeal_flutter.native_params.ParserUtils.parseNativeParams
import com.appodeal.appodeal_flutter.native_params.TemplateType
import io.flutter.plugin.platform.PlatformView
import java.lang.ref.WeakReference

class AppodealNativeAdView(activity: Activity, arguments: HashMap<*, *>) : PlatformView {
    private val placement: String = arguments["placement"] as? String ?: "default"
    private val params: NativeParams = (arguments["nativeAd"] as HashMap<*, *>?).parseNativeParams().apply {
        println(toString())
    }
    private val adView: NativeAdView = getAdView(activity)

    init {
        (adView.parent as? ViewGroup)?.removeView(adView)
    }

    private fun getAdView(context: Context): NativeAdView {
        val adView = if (params.isTemplate) {
            when (params.templateOptions?.templateType) {
                TemplateType.CONTENT_STREAM -> NativeAdViewContentStream(context)
                TemplateType.APP_WALL -> NativeAdViewAppWall(context)
                TemplateType.NEWS_FEED -> NativeAdViewNewsFeed(context)
                else -> error("Native template type doesn't support")
            }
        } else {
            NativeAdView(context)
        }
        Appodeal.getNativeAds(1).firstOrNull()?.let {
            adView.registerView(it, placement)
        }
        return adView
    }

    override fun getView(): View = adView

    override fun dispose() {}
}


