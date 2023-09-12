package com.appodeal.appodeal_flutter

import android.app.Activity
import android.content.Context
import com.appodeal.ads.Appodeal
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class AppodealAdViewFactory(
    private val activity: Activity,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return when (val adType = toAdType(args = args as HashMap<*, *>)) {
            Appodeal.NATIVE -> AppodealNativeAdView(activity, args)
            else -> AppodealAdView(activity, adType, args)
        }
    }

    private fun toAdType(args: HashMap<*, *>): Int {
        return when (args["adSize"]) {
            "BANNER" -> Appodeal.BANNER_VIEW
            "MEDIUM_RECTANGLE" -> Appodeal.MREC
            "NATIVE" -> Appodeal.NATIVE
            else -> error("Banner type doesn't support")
        }
    }
}