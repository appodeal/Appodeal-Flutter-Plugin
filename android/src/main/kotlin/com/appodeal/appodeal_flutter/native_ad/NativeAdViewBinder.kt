package com.appodeal.appodeal_flutter.native_ad

import android.annotation.SuppressLint
import android.app.Activity
import android.widget.Button
import android.widget.TextView
import androidx.annotation.Keep
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.ads.nativead.NativeAdViewAppWall
import com.appodeal.ads.nativead.NativeAdViewContentStream
import com.appodeal.ads.nativead.NativeAdViewNewsFeed
import com.appodeal.appodeal_flutter.R

@Keep
fun interface NativeAdViewBinder {
    fun bind(activity: Activity, nativeAdOptions: NativeAdOptions): NativeAdView
}

internal object TemplateNativeAdViewBinder : NativeAdViewBinder {
    override fun bind(activity: Activity, nativeAdOptions: NativeAdOptions): NativeAdView {
        val context = activity.applicationContext
        // Create the NativeAdView
        val nativeAdView = when (val nativeAdViewType = nativeAdOptions.nativeAdViewType) {
            NativeAdViewType.ContentStream -> NativeAdViewContentStream(context)
            NativeAdViewType.AppWall -> NativeAdViewAppWall(context)
            NativeAdViewType.NewsFeed -> NativeAdViewNewsFeed(context)
            else -> throw IllegalArgumentException("Unknown NativeAdViewType: $nativeAdViewType")
        }

        // set ad choices config
        val adChoicePosition = nativeAdOptions.adChoiceConfig.position
        nativeAdView.setAdChoicesPosition(adChoicePosition)

        // set ad attribution config
        val adAttributionBackgroundColor = nativeAdOptions.adAttributionConfig.backgroundColor
        nativeAdView.setAdAttributionBackground(adAttributionBackgroundColor)
        val adAttributionTextColor = nativeAdOptions.adAttributionConfig.textColor
        nativeAdView.setAdAttributionTextColor(adAttributionTextColor)

        // set ad title config
        val adTitleConfigFontSize = nativeAdOptions.adTitleConfig.fontSize.toFloat()
        (nativeAdView.titleView as? TextView)?.textSize = adTitleConfigFontSize

        // set ad description config
        val adDescriptionFontSize = nativeAdOptions.adDescriptionConfig.fontSize.toFloat()
        (nativeAdView.descriptionView as? TextView)?.textSize = adDescriptionFontSize

        // set ad action button config
        val adActionButtonFontSize = nativeAdOptions.adActionButtonConfig.fontSize.toFloat()
        (nativeAdView.callToActionView as? Button)?.textSize = adActionButtonFontSize

        // TODO: 17/11/2023 [glavatskikh] think about icon size in template
//        val adIconConfigWidth = nativeAdOptions.adIconConfig.width
//        val adIconConfigHeight = nativeAdOptions.adIconConfig.height
//        (nativeAdView.iconView)?.layoutParams =
//            RelativeLayout.LayoutParams(adIconConfigWidth, adIconConfigHeight)

        return nativeAdView
    }
}

internal object DefaultNativeAdViewBinder : NativeAdViewBinder {
    @SuppressLint("InflateParams")
    override fun bind(activity: Activity, nativeAdOptions: NativeAdOptions): NativeAdView {
        val layoutInflater = activity.layoutInflater
        return layoutInflater.inflate(R.layout.apd_native_ad_view_custom, null) as NativeAdView
    }
}