
package com.appodeal.appodeal_flutter

import android.util.Log
import com.appodeal.ads.RewardedVideoCallbacks
import io.flutter.plugin.common.MethodChannel

fun RewardedVideoCallbacks(channel: MethodChannel): RewardedVideoCallbacks {
    return object : RewardedVideoCallbacks {
        override fun onRewardedVideoLoaded(isPrecache: Boolean) {
            channel.invokeMethod("onRewardedVideoLoaded", mapOf(
                    "isPrecache" to isPrecache
            ))
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
            if (reward!=null){
                channel.invokeMethod("onRewardedVideoFinished", mapOf(
                    "amount" to amount,
                    "reward" to reward
                ))
            }else {
                channel.invokeMethod("onRewardedVideoFinished", mapOf(
                    "amount" to amount,
                    "reward" to "empty"
                ))
            }
        }

        override fun onRewardedVideoClosed(isFinished: Boolean) {
            channel.invokeMethod("onRewardedVideoClosed", mapOf(
                    "isFinished" to isFinished
            ))
        }

        override fun onRewardedVideoExpired() {
            channel.invokeMethod("onRewardedVideoExpired", null)
        }

        override fun onRewardedVideoClicked() {
            channel.invokeMethod("onRewardedVideoClicked", null)
        }
    }
}