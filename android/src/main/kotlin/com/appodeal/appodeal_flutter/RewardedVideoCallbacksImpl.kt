package com.appodeal.appodeal_flutter

import com.appodeal.ads.RewardedVideoCallbacks
import io.flutter.plugin.common.MethodChannel

internal class RewardedVideoCallbacksImpl(
    private val channel: MethodChannel
) : RewardedVideoCallbacks {

    override fun onRewardedVideoLoaded(isPrecache: Boolean) {
        channel.invokeMethod("onRewardedVideoLoaded", mapOf("isPrecache" to isPrecache))
    }

    override fun onRewardedVideoFailedToLoad() {
        channel.invokeMethod("onRewardedVideoFailedToLoad", null)
    }

    override fun onRewardedVideoShown() {
        channel.invokeMethod("onRewardedVideoShown", null)
    }

    override fun onRewardedVideoShowFailed() {
        channel.invokeMethod("onRewardedVideoShowFailed", null)
    }

    override fun onRewardedVideoFinished(amount: Double, reward: String?) {
        channel.invokeMethod(
            "onRewardedVideoFinished",
            mapOf("amount" to amount, "reward" to (reward ?: "empty"))
        )
    }

    override fun onRewardedVideoClosed(isFinished: Boolean) {
        channel.invokeMethod("onRewardedVideoClosed", mapOf("isFinished" to isFinished))
    }

    override fun onRewardedVideoExpired() {
        channel.invokeMethod("onRewardedVideoExpired", null)
    }

    override fun onRewardedVideoClicked() {
        channel.invokeMethod("onRewardedVideoClicked", null)
    }
}