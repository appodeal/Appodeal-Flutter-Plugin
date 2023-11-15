package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.apdLog
import com.appodeal.appodeal_flutter.native_ad.parseColor

internal class AdDescriptionConfig(
    val visible: Boolean = true,
    val fontSize: Int = 12,
    val textColor: Int = Color.BLACK,
    val margin: Int = 4,
) {
    companion object {
        fun toAdDescriptionConfig(map: Map<String, Any>): AdDescriptionConfig {
            apdLog("toAdDescriptionConfig: $map")
            return AdDescriptionConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 12,
                textColor = parseColor(map["textColor"] as? String) ?: Color.BLACK,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}