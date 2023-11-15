package com.appodeal.appodeal_flutter.native_ad

import android.graphics.Color

internal fun parseColorInt(colorIntValue: Int?): Int? {
    return if (colorIntValue == null) null
    else Color.parseColor("#${Integer.toHexString(colorIntValue)}")
}