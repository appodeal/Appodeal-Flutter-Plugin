package com.appodeal.appodeal_flutter

import android.app.Activity
import android.content.Context
import android.view.View
import android.view.ViewGroup
import com.appodeal.ads.nativead.NativeAdView
import io.flutter.plugin.platform.PlatformView
import java.lang.ref.WeakReference

class AppodealNativeAdView(activity: Activity, arguments: HashMap<*, *>)  : PlatformView {
    private val placement: String = arguments["placement"] as? String ?: "default"
    private val adView: View = getAdView(activity)

    init {
        (adView.parent as? ViewGroup)?.removeView(adView)
    }

    private fun getAdView(context: Context): NativeAdView {

        return NativeAdView(context)
    }

    override fun getView(): View = adView

    override fun dispose() {}
}

private var refNativeAdView = WeakReference<View>(null)