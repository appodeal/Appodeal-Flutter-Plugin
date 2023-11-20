package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdIconConfig(
    val visible: Boolean = true,
    val size: Int = 50,
    val position: Int = 0, // TODO: 17/11/2023 [glavatskikh] fix position
    val margin: Int = 0,
) {
    companion object {
        fun toAdIconConfig(map: Map<String, Any>): AdIconConfig {
            apdLog("toAdIconConfig: $map")
            return AdIconConfig(
                visible = map["visible"] as? Boolean ?: true,
                size = map["size"] as? Int ?: 50,
                position = map["position"] as? Int ?: 0,
                margin = map["margin"] as? Int ?: 0,
            )
        }
    }
}