package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.native_ad.parseColorInt

internal class AdActionButtonConfig(
    val visible: Boolean = true,
    val fontSize: Int = 12,
    val textColor: Int = Color.BLACK,
    val buttonColor: Int = Color.TRANSPARENT,
    val margin: Int = 4,
    val radius: Int = 16,
) {
    companion object {
        fun toAdActionButtonConfig(map: Map<String, Any>): AdActionButtonConfig {
            return AdActionButtonConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 12,
                textColor = parseColorInt(map["textColor"] as? Int) ?: Color.BLACK,
                buttonColor = parseColorInt(map["buttonColor"] as? Int) ?: Color.TRANSPARENT,
                margin = map["margin"] as? Int ?: 4,
                radius = map["radius"] as? Int ?: 16,
            )
        }
    }
}