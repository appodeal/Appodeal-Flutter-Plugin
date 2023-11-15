package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdStarsConfig {
    companion object {
        fun toAdStarsConfig(map: Map<String, Any>): AdStarsConfig {
            apdLog("toAdStarsConfig: $map")
            return AdStarsConfig()
        }
    }

}
