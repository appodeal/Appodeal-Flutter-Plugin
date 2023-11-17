package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.apdLog
import com.appodeal.appodeal_flutter.native_ad.parseColor

internal class AdAttributionConfig(
    val visible: Boolean = true,
    val fontSize: Int = 14,
    val textColor: Int = Color.BLACK,
    val backgroundColor: Int = Color.TRANSPARENT,
    val margin: Int = 4,
) {
    companion object {
        fun toAdAttributionConfig(map: Map<String, Any>): AdAttributionConfig {
            apdLog("toAdAttributionConfig: $map")
            return AdAttributionConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 14,
                textColor = parseColor(map["textColor"] as? String) ?: Color.BLACK,
                backgroundColor = parseColor(map["backgroundColor"] as? String)
                    ?: Color.TRANSPARENT,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}