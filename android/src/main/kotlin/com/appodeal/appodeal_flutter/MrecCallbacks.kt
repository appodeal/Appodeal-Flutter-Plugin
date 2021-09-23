@file:Suppress("SpellCheckingInspection")

package com.appodeal.appodeal_flutter

import com.appodeal.ads.MrecCallbacks
import io.flutter.plugin.common.MethodChannel

fun MrecCallbacks(channel: MethodChannel): MrecCallbacks {
    return object : MrecCallbacks {

        override fun onMrecLoaded(isPrecache: Boolean) {
            channel.invokeMethod("onMrecLoaded", mapOf(
                    "isPrecache" to isPrecache
            ))
        }

        override fun onMrecFailedToLoad() {
            channel.invokeMethod("onMrecFailedToLoad", null)
        }

        override fun onMrecShown() {
            channel.invokeMethod("onMrecShown", null)
        }

        override fun onMrecShowFailed() {
            channel.invokeMethod("onMrecShowFailed", null)
        }

        override fun onMrecClicked() {
            channel.invokeMethod("onMrecClicked", null)
        }

        override fun onMrecExpired() {
            channel.invokeMethod("onMrecExpired", null)
        }

    }}