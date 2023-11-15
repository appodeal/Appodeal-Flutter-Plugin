package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.apdLog
import com.appodeal.appodeal_flutter.native_ad.parseColor

internal class AdAdvertiserConfig(
    val visible: Boolean = true,
    val fontSize: Int = 14,
    val textColor: Int = Color.BLACK,
    val backgroundColor: Int = Color.TRANSPARENT,
    val margin: Int = 4,
) {
    companion object {
        fun toAdAdvertiserConfig(map: Map<String, Any>): AdAdvertiserConfig {
            apdLog("toAdAdvertiserConfig: $map")
            return AdAdvertiserConfig(
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