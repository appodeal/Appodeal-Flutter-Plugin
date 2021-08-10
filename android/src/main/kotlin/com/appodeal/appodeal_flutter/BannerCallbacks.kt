package com.example.appodeal_flutter

import com.appodeal.ads.BannerCallbacks
import io.flutter.plugin.common.MethodChannel

fun BannerCallbacks(channel: MethodChannel): BannerCallbacks {
    return object : BannerCallbacks {
        override fun onBannerLoaded(height: Int, isPrecache: Boolean) {
            channel.invokeMethod("onBannerLoaded",  mapOf(
                    "height" to height,
                    "isPrecache" to isPrecache
            ))
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
}