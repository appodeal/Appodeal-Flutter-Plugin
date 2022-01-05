package com.appodeal.appodeal_flutter

import com.appodeal.ads.BannerCallbacks
import io.flutter.plugin.common.MethodChannel

internal class BannerCallbacksImpl(
    private val channel: MethodChannel
) : BannerCallbacks {

    override fun onBannerLoaded(height: Int, isPrecache: Boolean) {
        channel.invokeMethod("onBannerLoaded", mapOf("isPrecache" to isPrecache))
    }

    override fun onBannerFailedToLoad() {
        channel.invokeMethod("onBannerFailedToLoad", null)
    }

    override fun onBannerShown() {
        channel.invokeMethod("onBannerShown", null)
    }

    override fun onBannerShowFailed() {
        channel.invokeMethod("onBannerShowFailed", null)
    }

    override fun onBannerClicked() {
        channel.invokeMethod("onBannerClicked", null)
    }

    override fun onBannerExpired() {
        channel.invokeMethod("onBannerExpired", null)
    }
}