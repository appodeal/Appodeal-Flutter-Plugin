package com.appodeal.appodeal_flutter.native_params

import android.content.Context
import android.graphics.drawable.GradientDrawable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT
import android.view.ViewGroup.MarginLayoutParams
import android.widget.Button
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView
import com.appodeal.ads.nativead.NativeAdView
import com.appodeal.ads.nativead.NativeAdViewAppWall
import com.appodeal.ads.nativead.NativeAdViewContentStream
import com.appodeal.ads.nativead.NativeAdViewNewsFeed
import com.appodeal.ads.nativead.NativeIconView
import com.appodeal.ads.nativead.NativeMediaView
import com.appodeal.ads.nativead.Position
import com.appodeal.appodeal_flutter.R


object ViewBuilder {

    private const val defaultCtaPadding = 40

    fun buildNewsFeed(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: TemplateParams,
    ): NativeAdViewNewsFeed {
        return NativeAdViewNewsFeed(context).apply {
            setAdChoicesPosition(adChoicePosition.toAppodealPosition())
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
            layoutParams = FrameLayout.LayoutParams(MATCH_PARENT, params.viewHeight)
        }
    }

    fun buildAppWall(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: TemplateParams,
    ): NativeAdViewAppWall {
        return NativeAdViewAppWall(context).apply {
            setAdChoicesPosition(adChoicePosition.toAppodealPosition())
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
            layoutParams = FrameLayout.LayoutParams(MATCH_PARENT, params.viewHeight)
        }
    }

    fun buildContentStream(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: TemplateParams,
    ): NativeAdViewContentStream {
        return NativeAdViewContentStream(context).apply {
            setAdChoicesPosition(adChoicePosition.toAppodealPosition())
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
            layoutParams = FrameLayout.LayoutParams(MATCH_PARENT, params.viewHeight)
        }
    }

    fun buildCustomAdView(
        context: Context,
        adChoicePosition: AdChoicePosition,
        params: CustomParams,
    ): NativeAdView {
        val nativeAdView: NativeAdView =
            LayoutInflater.from(context)
                .inflate(R.layout.custom_native_ad, null, false) as NativeAdView
        nativeAdView.layoutParams = FrameLayout.LayoutParams(MATCH_PARENT, params.viewHeight)
        val nativeBannerId = when (params.viewPosition) {
            NativeBannerViewPosition.ICON_START -> R.layout.native_banner_icon_start
            NativeBannerViewPosition.CTA_START -> R.layout.native_banner_cta_start
        }

        val container = nativeAdView.findViewById<LinearLayout>(R.id.native_container).apply {
            layoutParams = FrameLayout.LayoutParams(MATCH_PARENT, params.viewHeight)
                .apply {
                    setMargins(
                        params.containerMargin,
                        params.containerMargin,
                        params.containerMargin,
                        params.containerMargin,
                    )
                }
        }

        val nativeBanner = LayoutInflater.from(context).inflate(nativeBannerId, null, false)

        if (params.mediaViewPosition == null) {
            container.addView(nativeBanner)
        } else {
            val mediaView = NativeMediaView(context).apply {
                id = View.generateViewId()
                layoutParams = FrameLayout.LayoutParams(MATCH_PARENT, WRAP_CONTENT).apply {
                    setMargins(
                        params.mediaViewMargin,
                        params.mediaViewMargin,
                        params.mediaViewMargin,
                        params.mediaViewMargin
                    )
                }
            }
            when (params.mediaViewPosition) {
                MediaViewPosition.TOP -> {
                    container.addView(mediaView)
                    container.addView(nativeBanner)
                }

                MediaViewPosition.BOTTOM -> {
                    container.addView(nativeBanner)
                    container.addView(mediaView)
                }
            }
            nativeAdView.mediaView = mediaView
        }

        nativeAdView.descriptionView =
            nativeBanner.findViewById<TextView>(R.id.descriptionView).apply {
                (layoutParams as MarginLayoutParams)?.let {
                    it.setMargins(
                        params.descriptionMargin,
                        params.descriptionMargin,
                        params.descriptionMargin,
                        params.descriptionMargin,
                    )
                }
                params.descriptionColor?.let {
                    setTextColor(it)
                }
                textSize = params.descriptionTextSize.toFloat()
            }

        nativeAdView.titleView = nativeBanner.findViewById<TextView>(R.id.titleView).apply {
            (layoutParams as MarginLayoutParams)?.let {
                it.setMargins(
                    params.titleMargin,
                    params.titleMargin,
                    params.titleMargin,
                    params.titleMargin,
                )
            }
            params.titleColor?.let {
                setTextColor(it)
            }
            textSize = params.titleTextSize.toFloat()
        }

        nativeAdView.callToActionView =
            nativeBanner.findViewById<Button>(R.id.callToActionView).apply {
                setPadding(defaultCtaPadding, 0, defaultCtaPadding, 0)

                (layoutParams as MarginLayoutParams)?.let {
                    it.setMargins(
                        params.ctaMargin,
                        params.ctaMargin,
                        params.ctaMargin,
                        params.ctaMargin,
                    )
                }
                val shape = GradientDrawable()
                shape.cornerRadius = params.ctaRadius.toFloat()
                params.ctaBackground?.let {
                    shape.setColor(it)
                }
                textSize = params.ctaTextSize.toFloat()
                background = shape
                params.ctaTextColor?.let {
                    setTextColor(it)
                }
            }

        nativeAdView.adAttributionView =
            nativeBanner.findViewById<TextView>(R.id.adAttributionView).apply {
                (layoutParams as MarginLayoutParams)?.let {
                    it.setMargins(
                        params.adAttributionMargin,
                        params.adAttributionMargin,
                        params.adAttributionMargin,
                        params.adAttributionMargin,
                    )
                }
                params.adAttributionTextColor?.let {
                    setTextColor(it)
                }
                params.adAttributionBackgroundColor?.let {
                    setBackgroundColor(it)
                }
            }

        nativeAdView.iconView =
            nativeBanner.findViewById<NativeIconView>(R.id.nativeIconView).apply {
                layoutParams.width = params.iconSize
                layoutParams.height = params.iconSize
                (layoutParams as MarginLayoutParams)?.let {
                    it.setMargins(
                        params.iconMargin,
                        params.iconMargin,
                        params.iconMargin,
                        params.iconMargin,
                    )
                }
            }

        nativeAdView.setAdChoicesPosition(adChoicePosition.toAppodealPosition())

        return nativeAdView
    }
}

private fun AdChoicePosition.toAppodealPosition(): Position {
    return Position.values().find {
        it.name == this.name
    } ?: Position.START_TOP
}