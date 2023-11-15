package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdStoreConfig {
    companion object {
        fun toAdStoreConfig(map: Map<String, Any>): AdStoreConfig {
            apdLog("toAdStoreConfig: $map")
            return AdStoreConfig(
            )
        }
    }
}