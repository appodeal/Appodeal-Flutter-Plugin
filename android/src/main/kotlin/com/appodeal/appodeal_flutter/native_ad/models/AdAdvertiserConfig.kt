package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.native_ad.parseColorInt

internal class AdAdvertiserConfig(
    val visible: Boolean = true,
    val fontSize: Int = 14,
    val textColor: Int = Color.BLACK,
    val backgroundColor: Int = Color.TRANSPARENT,
    val margin: Int = 4,
) {
    companion object {
        fun toAdAdvertiserConfig(map: Map<String, Any>): AdAdvertiserConfig {
            return AdAdvertiserConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 14,
                textColor = parseColorInt(map["textColor"] as? Int) ?: Color.BLACK,
                backgroundColor = parseColorInt(map["backgroundColor"] as? Int)
                    ?: Color.TRANSPARENT,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}