package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.native_ad.parseColorInt

internal class AdTitleConfig(
    val visible: Boolean = true,
    val fontSize: Int = 16,
    val textColor: Int = Color.BLACK,
    val margin: Int = 4,
) {
    companion object {
        fun toAdTitleConfig(map: Map<String, Any>): AdTitleConfig {
            return AdTitleConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 16,
                textColor = parseColorInt(map["textColor"] as? Int) ?: Color.BLACK,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}