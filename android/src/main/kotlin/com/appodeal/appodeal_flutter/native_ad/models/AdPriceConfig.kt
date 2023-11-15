package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdPriceConfig {
    companion object {
        fun toAdPriceConfig(map: Map<String, Any>): AdPriceConfig {
            apdLog("toAdPriceConfig: $map")
            return AdPriceConfig()
        }
    }

}
