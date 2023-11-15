package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.apdLog
import com.appodeal.appodeal_flutter.native_ad.parseColor

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
            apdLog("toAdActionButtonConfig: $map")
            return AdActionButtonConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 12,
                textColor = parseColor(map["textColor"] as? String) ?: Color.BLACK,
                buttonColor = parseColor(map["buttonColor"] as? String) ?: Color.TRANSPARENT,
                margin = map["margin"] as? Int ?: 4,
                radius = map["radius"] as? Int ?: 16,
            )
        }
    }
}