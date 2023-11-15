package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdLayoutConfig(

) {
    companion object {
        fun toAdLayoutConfig(map: Map<String, Any>): AdLayoutConfig {
            apdLog("toAdLayoutConfig: $map")
            return AdLayoutConfig(
            )
        }
    }

}
