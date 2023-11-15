package com.appodeal.appodeal_flutter.native_ad.models

internal class AdIconConfig(
    val visible: Boolean = true,
    val height: Int = 50,
    val width: Int = 50,
    val margin: Int = 4,
) {
    companion object {
        fun toAdIconConfig(map: Map<String, Any>): AdIconConfig {
            return AdIconConfig(
                visible = map["visible"] as? Boolean ?: true,
                height = map["height"] as? Int ?: 50,
                width = map["width"] as? Int ?: 50,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}