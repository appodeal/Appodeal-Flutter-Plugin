package com.appodeal.appodeal_flutter

import com.explorestack.consent.Consent
import com.explorestack.consent.ConsentFormListener
import com.explorestack.consent.exception.ConsentManagerException
import io.flutter.plugin.common.MethodChannel

fun ConsentFormListener(channel: MethodChannel): ConsentFormListener {
    return object : ConsentFormListener {
        override fun onConsentFormLoaded() {
            channel.invokeMethod("onConsentFormLoaded", null)
        }

        override fun onConsentFormError(error: ConsentManagerException?) {
            channel.invokeMethod("onConsentFormError",
                    "error" to error?.toString())

        }

        override fun onConsentFormOpened() {
            channel.invokeMethod("onConsentFormOpened", null)
        }

        override fun onConsentFormClosed(consent: Consent?) {
            channel.invokeMethod("onConsentFormClosed",
                    "consent" to consent.toString())
        }
    }
}