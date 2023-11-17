package com.appodeal.appodeal_flutter.native_ad

import com.appodeal.appodeal_flutter.native_ad.models.AdActionButtonConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdAttributionConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdChoiceConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdDescriptionConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdIconConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdLayoutConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdMediaConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdTitleConfig

internal class NativeAdOptions(
    val adActionButtonConfig: AdActionButtonConfig,
    val adAttributionConfig: AdAttributionConfig,
    val adChoiceConfig: AdChoiceConfig,
    val adDescriptionConfig: AdDescriptionConfig,
    val adIconConfig: AdIconConfig,
    val adLayoutConfig: AdLayoutConfig,
    val adMediaConfig: AdMediaConfig,
    val adTitleConfig: AdTitleConfig,
) {
    companion object {
        fun toNativeAdOptions(args: Map<String, Any>): NativeAdOptions? = runCatching {
            NativeAdOptions(
                adActionButtonConfig = AdActionButtonConfig.toAdActionButtonConfig(args["adActionButtonConfig"] as Map<String, Any>),
                adAttributionConfig = AdAttributionConfig.toAdAttributionConfig(args["adAttributionConfig"] as Map<String, Any>),
                adChoiceConfig = AdChoiceConfig.toAdChoiceConfig(args["adChoiceConfig"] as Map<String, Any>),
                adDescriptionConfig = AdDescriptionConfig.toAdDescriptionConfig(args["adDescriptionConfig"] as Map<String, Any>),
                adIconConfig = AdIconConfig.toAdIconConfig(args["adIconConfig"] as Map<String, Any>),
                adLayoutConfig = AdLayoutConfig.toAdLayoutConfig(args["adLayoutConfig"] as Map<String, Any>),
                adMediaConfig = AdMediaConfig.toAdMediaConfig(args["adMediaConfig"] as Map<String, Any>),
                adTitleConfig = AdTitleConfig.toAdTitleConfig(args["adTitleConfig"] as Map<String, Any>),
            )
        }.getOrNull()
    }
}