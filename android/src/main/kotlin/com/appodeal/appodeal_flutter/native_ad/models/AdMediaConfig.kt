package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdMediaConfig(
    val visible: Boolean = true,
    val margin: Int = 4,
) {
    companion object {
        fun toAdMediaConfig(map: Map<String, Any>): AdMediaConfig {
            apdLog("toAdMediaConfig: $map")
            return AdMediaConfig(
                visible = map["visible"] as? Boolean ?: true,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}
