package com.appodeal.appodeal_flutter.native_params

import android.graphics.Color

object ParserUtils {
    private const val defaultContainerMargin = 4
    private const val defaultIconSize = 70
    private const val defaultIconMargin = 4
    private const val defaultTitleMargin = 4
    private const val defaultDescriptionTextSize = 14
    private const val defaultDescriptionMargin = 4
    private const val defaultCtaTextSize = 16
    private const val defaultCtaMargin = 4
    private const val defaultTitleTextSize = 16

    fun HashMap<*, *>?.parseNativeParams(): NativeParams {
        println("parseNativeParams: ${toString()}\n")
        return NativeParams(
            adChoicePosition = parseAdChoicePosition(this?.get("adChoicePosition") as String?),
            customOptions = parseCustomParams(),
            templateOptions = parseTemplateParams()
        )
    }

    private fun HashMap<*, *>?.parseCustomParams(): CustomParams? {
        print("parseCustomParams: ${toString()}\n")
        (this?.get("customOptions") as? Map<*, *>)?.apply {
            return CustomParams(
                mediaViewPosition = parseMediaViewPosition(this["mediaViewPosition"] as String?),
                viewPosition = parseNativeBannerViewPosition(this["viewPosition"] as String?),
                containerMargin = this["containerMargin"] as Int? ?: defaultContainerMargin,
                iconSize = this["iconSize"] as Int? ?: defaultIconSize,
                iconMargin = this["iconMargin"] as Int? ?: defaultIconMargin,
                titleTextSize = this["titleTextSize"] as Int? ?: defaultTitleTextSize,
                titleMargin = this["titleMargin"] as Int? ?: defaultTitleMargin,
                descriptionTextSize = this["descriptionTextSize"] as Int? ?: defaultDescriptionTextSize,
                descriptionMargin = this["descriptionMargin"] as Int? ?: defaultDescriptionMargin,
                ctaTextSize = this["ctaTextSize"] as Int? ?: defaultCtaTextSize,
                ctaMargin = this["ctaMargin"] as Int? ?: defaultCtaMargin,
                titleColor = convertColor(this["titleColor"] as Int?),
                descriptionColor = convertColor(this["descriptionColor"] as Int?),
                ctaBackground = convertColor(this["ctaBackground"] as Int?),
                ctaTextColor = convertColor(this["ctaTextColor"] as Int?),
            )
        }
        return null
    }

    private fun HashMap<*, *>?.parseTemplateParams(): TemplateParams? {
        print("parseTemplateParams: ${toString()}\n")
        (this?.get("templateOptions") as? Map<*, *>)?.apply {
            return TemplateParams(
                templateType = parseTemplateType(this["templateType"] as String?),
                iconSize = this["iconSize"] as Int? ?: defaultIconSize,
                titleTextSize = this["titleTextSize"] as Int? ?: defaultTitleTextSize,
                ctaTextSize = this["ctaTextSize"] as Int? ?: defaultCtaTextSize,
                descriptionTextSize = convertColor(this["descriptionTextSize"] as Int?) ?: defaultDescriptionTextSize,
                adAttributionBackgroundColor = convertColor(this["adAttributionBackgroundColor"] as Int?),
                adAttributionTextColor = convertColor(this["adAttributionTextColor"] as Int?),
            )
        }
        return null
    }

    private fun parseTemplateType(templateType: String?): TemplateType {
        return when (templateType) {
            "TemplateType.APP_WALL" -> TemplateType.APP_WALL
            "TemplateType.CONTENT_STREAM" -> TemplateType.CONTENT_STREAM
            else -> TemplateType.NEWS_FEED
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

    private fun parseMediaViewPosition(mediaViewPosition: String?): MediaViewPosition {
        return when (mediaViewPosition) {
            "MediaViewPosition.TOP" -> MediaViewPosition.TOP
            else -> MediaViewPosition.BOTTOM
        }
    }

    private fun parseNativeBannerViewPosition(viewPosition: String?): NativeBannerViewPosition {
        return when (viewPosition) {
            "NativeBannerViewPosition.CTA_START" -> NativeBannerViewPosition.CTA_START
            else -> NativeBannerViewPosition.ICON_START
        }
    }

    private fun convertColor(colorValue: Int?): Int? {
        colorValue ?: return null
        val red: Int = (colorValue shr 16) and 0xFF
        val green: Int = (colorValue shr 8) and 0xFF
        val blue: Int = colorValue and 0xFF
        return Color.rgb(red, green, blue)
    }
}