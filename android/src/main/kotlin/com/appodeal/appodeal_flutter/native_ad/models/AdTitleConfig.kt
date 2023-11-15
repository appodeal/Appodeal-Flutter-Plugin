package com.appodeal.appodeal_flutter.native_ad.models

import android.graphics.Color
import com.appodeal.appodeal_flutter.apdLog
import com.appodeal.appodeal_flutter.native_ad.parseColor

internal class AdTitleConfig(
    val visible: Boolean = true,
    val fontSize: Int = 16,
    val textColor: Int = Color.BLACK,
    val margin: Int = 4,
) {
    companion object {
        fun toAdTitleConfig(map: Map<String, Any>): AdTitleConfig {
            apdLog("toAdTitleConfig: $map")
            return AdTitleConfig(
                visible = map["visible"] as? Boolean ?: true,
                fontSize = map["fontSize"] as? Int ?: 16,
                textColor = parseColor(map["textColor"] as? String) ?: Color.BLACK,
                margin = map["margin"] as? Int ?: 4,
            )
        }
    }
}