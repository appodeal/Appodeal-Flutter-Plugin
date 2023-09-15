package com.appodeal.appodeal_flutter.native_params

import android.content.Context
import android.graphics.Color
import android.util.TypedValue

object ParserUtils {
    private const val defaultContainerMargin = 4
    private const val defaultIconSize = 70
    private const val defaultIconMargin = 4
    private const val defaultTitleMargin = 4
    private const val defaultDescriptionTextSize = 14
    private const val defaultDescriptionMargin = 4
    private const val defaultCtaTextSize = 16
    private const val defaultCtaMargin = 4
    private const val defaultCtaRadius = 4
    private const val defaultTitleTextSize = 16
    private const val defaultAdAttributionMargin = 4
    private const val defaultMediaViewMargin = 4

    fun HashMap<*, *>?.parseNativeParams(context: Context): NativeParams {
        println("parseNativeParams: ${toString()}\n")
        val customOptions = parseCustomParams(context)
        val templateOptions = if (customOptions == null ) {
            parseTemplateParams(context)
        } else {
            null
        }
        return NativeParams(
            adChoicePosition = parseAdChoicePosition(this?.get("adChoicePosition") as String?),
            customOptions = customOptions,
            templateOptions = templateOptions
        )
    }

    private fun HashMap<*, *>?.parseCustomParams(context: Context): CustomParams? {
        print("parseCustomParams: ${toString()}\n")
        (this?.get("customOptions") as? Map<*, *>)?.apply {

            var iconSize: Int? = null
            var iconMargin: Int? = null
            var titleTextSize: Int? = null
            var titleMargin: Int? = null
            var descriptionTextSize: Int? = null
            var descriptionMargin: Int? = null
            var ctaTextSize: Int? = null
            var ctaMargin: Int? = null
            var ctaRadius: Int? = null
            var adAttributionMargin: Int? = null
            var mediaViewMargin: Int? = null
            var adAttributionBackgroundColor: Int? = null
            var adAttributionTextColor: Int? = null
            var ctaBackground: Int? = null
            var ctaTextColor: Int? = null
            var descriptionColor: Int? = null
            var titleColor: Int? = null

            (this["adAttributionOption"] as? Map<*, *>)?.apply {
                adAttributionMargin = convertToDp(context, this["margin"] as Int?)
                adAttributionBackgroundColor = convertColor(this["background"] as? Long?)
                adAttributionTextColor = convertColor(this["textColor"] as? Long?)
            }
            (this["ctaOptions"] as? Map<*, *>)?.apply {
                ctaTextSize = this["textSize"] as Int?
                ctaMargin = convertToDp(context, this["margin"] as Int?)
                ctaRadius = this["radius"] as Int?
                ctaBackground = convertColor(this["background"] as Long?)
                ctaTextColor = convertColor(this["textColor"] as Long?)
            }
            (this["descriptionOptions"] as? Map<*, *>)?.apply {
                descriptionTextSize = this["textSize"] as Int?
                descriptionMargin = convertToDp(context, this["margin"] as Int?)
                descriptionColor = convertColor(this["textColor"] as Long?)

            }
            (this["nativeIconOptions"] as? Map<*, *>)?.apply {
                iconSize = convertToDp(context, this["size"] as Int?)
                iconMargin = convertToDp(context, this["margin"] as Int?)
            }
            (this["nativeMediaOptions"] as? Map<*, *>)?.apply {
                mediaViewMargin = convertToDp(context, this["margin"] as Int?)
            }
            (this["titleOptions"] as? Map<*, *>)?.apply {
                titleTextSize = this["textSize"] as Int?
                titleMargin = convertToDp(context, this["margin"] as Int?)
                titleColor = convertColor(this["textColor"] as Long?)
            }
            return CustomParams(
                viewHeight = this["viewHeight"] as Int? ?:0,
                mediaViewPosition = parseMediaViewPosition(this["mediaViewPosition"] as String?),
                viewPosition = parseNativeBannerViewPosition(this["viewPosition"] as String?),

                containerMargin = convertToDp(context, this["containerMargin"] as Int?)
                    ?: defaultContainerMargin,

                iconSize = iconSize ?: defaultIconSize,
                iconMargin = iconMargin ?: defaultIconMargin,

                titleTextSize = titleTextSize ?: defaultTitleTextSize,
                titleMargin = titleMargin ?: defaultTitleMargin,
                titleColor = titleColor,

                descriptionTextSize = descriptionTextSize ?: defaultDescriptionTextSize,
                descriptionMargin = descriptionMargin ?: defaultDescriptionMargin,
                descriptionColor = descriptionColor,

                ctaTextSize = ctaTextSize ?: defaultCtaTextSize,
                ctaMargin = ctaMargin ?: defaultCtaMargin,
                ctaRadius = ctaRadius ?: defaultCtaRadius,
                ctaBackground = ctaBackground,
                ctaTextColor = ctaTextColor,

                mediaViewMargin = mediaViewMargin ?: defaultMediaViewMargin,

                adAttributionMargin = adAttributionMargin ?: defaultAdAttributionMargin,
                adAttributionBackgroundColor = adAttributionBackgroundColor,
                adAttributionTextColor = adAttributionTextColor,
            )
        }
        return null
    }

    private fun HashMap<*, *>?.parseTemplateParams(context: Context): TemplateParams? {
        print("parseTemplateParams: ${toString()}\n")
        val templateType = parseTemplateType(this?.get("templateType") as String?)
        (this?.get("templateOptions") as? Map<*, *>)?.apply {
            return TemplateParams(
                templateType = templateType,
                iconSize = convertToDp(context,this["iconSize"] as Int?) ?: defaultIconSize,
                titleTextSize = this["titleTextSize"] as Int? ?: defaultTitleTextSize,
                ctaTextSize = this["ctaTextSize"] as Int? ?: defaultCtaTextSize,
                descriptionTextSize = this["descriptionTextSize"] as Int? ?: defaultDescriptionTextSize,
                adAttributionBackgroundColor = convertColor(this["adAttributionBackgroundColor"] as? Long?),
                adAttributionTextColor = convertColor(this["adAttributionTextColor"] as? Long?),
            )
        }
        return null
    }

    private fun parseTemplateType(templateType: String?): TemplateType {
        return when (templateType) {
            "TemplateType.APP_WALL" -> TemplateType.APP_WALL
            "TemplateType.CONTENT_STREAM" -> TemplateType.CONTENT_STREAM
            "TemplateType.NEWS_FEED" -> TemplateType.NEWS_FEED
            else -> error("Template type doesn`t support")
        }
    }

    private fun parseAdChoicePosition(adChoicePosition: String?): AdChoicePosition {
        return when (adChoicePosition) {
            "AdChoicePosition.START_BOTTOM" -> AdChoicePosition.START_BOTTOM
            "AdChoicePosition.END_TOP" -> AdChoicePosition.END_TOP
            "AdChoicePosition.END_BOTTOM" -> AdChoicePosition.END_BOTTOM
            else -> AdChoicePosition.START_TOP
        }
    }

    private fun parseMediaViewPosition(mediaViewPosition: String?): MediaViewPosition? {
        return when (mediaViewPosition) {
            "MediaViewPosition.TOP" -> MediaViewPosition.TOP
            "MediaViewPosition.BOTTOM" -> MediaViewPosition.BOTTOM
            else -> null
        }
    }

    private fun parseNativeBannerViewPosition(viewPosition: String?): NativeBannerViewPosition {
        return when (viewPosition) {
            "NativeBannerViewPosition.CTA_START" -> NativeBannerViewPosition.CTA_START
            else -> NativeBannerViewPosition.ICON_START
        }
    }

    private fun convertColor(colorValue: Long?): Int? {
        colorValue ?: return null
        val red: Long = (colorValue shr 16) and 0xFF
        val green: Long = (colorValue shr 8) and 0xFF
        val blue: Long = colorValue and 0xFF
        return Color.rgb(red.toInt(), green.toInt(), blue.toInt())
    }

    private fun convertToDp(context: Context, size: Int?): Int? {
        size?:return null
        val r = context.resources
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            size.toFloat(),
            r.displayMetrics
        ).toInt()
    }
}