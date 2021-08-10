package com.appodeal.appodeal_flutter

import com.appodeal.ads.NonSkippableVideoCallbacks
import io.flutter.plugin.common.MethodChannel

fun NonSkippableVideoCallbacks(channel: MethodChannel): NonSkippableVideoCallbacks {
    return object : NonSkippableVideoCallbacks {
        override fun onNonSkippableVideoLoaded(isPrecache: Boolean) {
            channel.invokeMethod("onNonSkippableVideoLoaded",  mapOf(
                    "isPrecache" to isPrecache
            ))
        }

        override fun onNonSkippableVideoFailedToLoad() {
            channel.invokeMethod("onNonSkippableVideoFailedToLoad", null)
        }

        override fun onNonSkippableVideoShown() {
            channel.invokeMethod("onNonSkippableVideoShown", null)
        }

        override fun onNonSkippableVideoShowFailed() {
            channel.invokeMethod("onNonSkippableVideoShowFailed", null)
        }

        override fun onNonSkippableVideoFinished() {
            channel.invokeMethod("onNonSkippableVideoFinished", null)
        }

        override fun onNonSkippableVideoClosed(isFinished: Boolean) {
            channel.invokeMethod("onNonSkippableVideoLoaded",  mapOf(
                    "isFinished" to isFinished
            ))
        }

        override fun onNonSkippableVideoExpired() {
            channel.invokeMethod("onNonSkippableVideoExpired", null)
        }

    }
}