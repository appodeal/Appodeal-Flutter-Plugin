package com.appodeal.appodeal_flutter.native_params

import android.content.Context
import android.view.ViewGroup
import android.widget.Button
import android.widget.RelativeLayout
import android.widget.TextView
import com.appodeal.ads.nativead.NativeAdViewAppWall
import com.appodeal.ads.nativead.NativeAdViewContentStream
import com.appodeal.ads.nativead.NativeAdViewNewsFeed
import com.appodeal.ads.nativead.Position

object ViewBuilder {

    fun buildNewsFeed(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: TemplateParams,
    ): NativeAdViewNewsFeed {
        return NativeAdViewNewsFeed(context).apply {
            setAdChoicesPosition(adChoicePosition.toAppodealPosition() ?: Position.START_TOP)
            params.adAttributionBackgroundColor?.let {
                setAdAttributionBackground(it)
            }
            params.adAttributionTextColor?.let {
                setAdAttributionTextColor(it)
            }
            (titleView as? TextView)?.textSize = params.titleTextSize.toFloat()
            (callToActionView as? Button)?.textSize = params.ctaTextSize.toFloat()
            iconView?.layoutParams = RelativeLayout.LayoutParams(params.iconSize, params.iconSize)
            (descriptionView as? TextView)?.textSize = params.descriptionTextSize.toFloat()
        }
    }

    fun buildAppWall(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: TemplateParams,
    ): NativeAdViewAppWall {
        return NativeAdViewAppWall(context).apply {
            setAdChoicesPosition(adChoicePosition.toAppodealPosition() ?: Position.START_TOP)
            params.adAttributionBackgroundColor?.let {
                setAdAttributionBackground(it)
            }
            params.adAttributionTextColor?.let {
                setAdAttributionTextColor(it)
            }
            iconView?.layoutParams = RelativeLayout.LayoutParams(params.iconSize, params.iconSize)
            (titleView as? TextView)?.textSize = params.titleTextSize.toFloat()
            (callToActionView as? Button)?.textSize = params.ctaTextSize.toFloat()
            (descriptionView as? TextView)?.textSize = params.descriptionTextSize.toFloat()
        }
    }

    fun buildContentStream(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: TemplateParams,
    ): NativeAdViewContentStream {
        return NativeAdViewContentStream(context).apply {
            setAdChoicesPosition(adChoicePosition.toAppodealPosition() ?: Position.START_TOP)
            params.adAttributionBackgroundColor?.let {
                setAdAttributionBackground(it)
            }
            params.adAttributionTextColor?.let {
                setAdAttributionTextColor(it)
            }
            iconView?.layoutParams = RelativeLayout.LayoutParams(params.iconSize, params.iconSize)
            (titleView as? TextView)?.textSize = params.titleTextSize.toFloat()
            (callToActionView as? Button)?.textSize = params.ctaTextSize.toFloat()
            (descriptionView as? TextView)?.textSize = params.descriptionTextSize.toFloat()
        }
    }
}

private fun AdChoicePosition.toAppodealPosition(): Position? {
    return Position.values().find {
        it.name == this.name
    }
}