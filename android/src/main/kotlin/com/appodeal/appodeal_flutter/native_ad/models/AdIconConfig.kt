package com.appodeal.appodeal_flutter.native_ad.models

import com.appodeal.appodeal_flutter.apdLog

internal class AdIconConfig(
    val visible: Boolean = true,
    val height: Int = 50,
    val width: Int = 50,
    val position: Int = 0,
    val margin: Int = 4,
) {
    companion object {
        fun toAdIconConfig(map: Map<String, Any>): AdIconConfig {
            apdLog("toAdIconConfig: $map")
            return AdIconConfig(
                visible = map["visible"] as? Boolean ?: true,
                height = map["height"] as? Int ?: 50,
                width = map["width"] as? Int ?: 50,
                position = map["position"] as? Int ?: 0,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}