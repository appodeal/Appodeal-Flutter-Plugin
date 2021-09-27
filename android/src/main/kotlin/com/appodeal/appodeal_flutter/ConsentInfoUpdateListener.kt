package com.appodeal.appodeal_flutter

import com.explorestack.consent.Consent
import com.explorestack.consent.ConsentInfoUpdateListener
import com.explorestack.consent.exception.ConsentManagerException
import io.flutter.plugin.common.MethodChannel

fun ConsentInfoUpdateListener(channel: MethodChannel): ConsentInfoUpdateListener {
    return object : ConsentInfoUpdateListener {
        override fun onConsentInfoUpdated(consent: Consent?) {
            channel.invokeMethod("onConsentInfoUpdated", mapOf(
                    "consent" to consent?.toJSONObject().toString()
            ))
        }

        override fun onFailedToUpdateConsentInfo(error: ConsentManagerException?) {
            channel.invokeMethod("onFailedToUpdateConsentInfo", mapOf(
                    "consent" to error?.toString()
            ))
        }
    }
}