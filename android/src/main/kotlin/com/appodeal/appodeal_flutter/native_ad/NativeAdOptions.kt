package com.appodeal.appodeal_flutter.native_ad

import com.appodeal.appodeal_flutter.native_ad.models.AdActionButtonConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdAdvertiserConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdDescriptionConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdIconConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdLayoutConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdMediaConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdPriceConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdStarsConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdStoreConfig
import com.appodeal.appodeal_flutter.native_ad.models.AdTitleConfig

internal class NativeAdOptions(
    val adMediaConfig: AdMediaConfig,
    val adStarsConfig: AdStarsConfig,
    val adPriceConfig: AdPriceConfig,
    val adStoreConfig: AdStoreConfig,
    val adTitleConfig: AdTitleConfig,
    val adAdvertiserConfig: AdAdvertiserConfig,
    val adIconConfig: AdIconConfig,
    val adDescriptionConfig: AdDescriptionConfig,
    val adActionButtonConfig: AdActionButtonConfig,
    val adLayoutConfig: AdLayoutConfig
) {
    companion object {
        fun toNativeAdOptions(args: Map<String, Any>): NativeAdOptions? = runCatching {
            NativeAdOptions(
                adMediaConfig = AdMediaConfig.toAdMediaConfig(args["adMediaConfig"] as Map<String, Any>),
                adStarsConfig = AdStarsConfig.toAdStarsConfig(args["adStarsConfig"] as Map<String, Any>),
                adPriceConfig = AdPriceConfig.toAdPriceConfig(args["adPriceConfig"] as Map<String, Any>),
                adStoreConfig = AdStoreConfig.toAdStoreConfig(args["adStoreConfig"] as Map<String, Any>),
                adTitleConfig = AdTitleConfig.toAdTitleConfig(args["adTitleConfig"] as Map<String, Any>),
                adAdvertiserConfig = AdAdvertiserConfig.toAdAdvertiserConfig(args["adAdvertiserConfig"] as Map<String, Any>),
                adIconConfig = AdIconConfig.toAdIconConfig(args["adIconConfig"] as Map<String, Any>),
                adDescriptionConfig = AdDescriptionConfig.toAdDescriptionConfig(args["adDescriptionConfig"] as Map<String, Any>),
                adActionButtonConfig = AdActionButtonConfig.toAdActionButtonConfig(args["adActionButtonConfig"] as Map<String, Any>),
                adLayoutConfig = AdLayoutConfig.toAdLayoutConfig(args["adLayoutConfig"] as Map<String, Any>)
            )
        }.getOrNull()
    }
}