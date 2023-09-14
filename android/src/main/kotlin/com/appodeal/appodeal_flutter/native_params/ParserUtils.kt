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
    private const val defaultTitleTextSize = 16

    fun HashMap<*, *>?.parseNativeParams(context: Context): NativeParams {
        println("parseNativeParams: ${toString()}\n")
        return NativeParams(
            adChoicePosition = parseAdChoicePosition(this?.get("adChoicePosition") as String?),
            customOptions = parseCustomParams(context),
            templateOptions = parseTemplateParams(context)
        )
    }

    private fun HashMap<*, *>?.parseCustomParams(context: Context): CustomParams? {
        print("parseCustomParams: ${toString()}\n")
        (this?.get("customOptions") as? Map<*, *>)?.apply {
            return CustomParams(
                mediaViewPosition = parseMediaViewPosition(this["mediaViewPosition"] as String?),
                viewPosition = parseNativeBannerViewPosition(this["viewPosition"] as String?),
                containerMargin = convertToDp(context, this["containerMargin"] as Int? ?: defaultContainerMargin),
                iconSize = convertToDp(context,this["iconSize"] as Int? ?: defaultIconSize),
                iconMargin = convertToDp(context,this["iconMargin"] as Int? ?: defaultIconMargin),
                titleTextSize =  this["titleTextSize"] as Int? ?: defaultTitleTextSize,
                titleMargin = convertToDp(context,this["titleMargin"] as Int? ?: defaultTitleMargin),
                descriptionTextSize = this["descriptionTextSize"] as Int? ?: defaultDescriptionTextSize,
                descriptionMargin = convertToDp(context,this["descriptionMargin"] as Int? ?: defaultDescriptionMargin),
                ctaTextSize = this["ctaTextSize"] as Int? ?: defaultCtaTextSize,
                ctaMargin = convertToDp(context,this["ctaMargin"] as Int? ?: defaultCtaMargin),
                titleColor = convertColor(this["titleColor"] as Long?),
                descriptionColor = convertColor(this["descriptionColor"] as Long?),
                ctaBackground = convertColor(this["ctaBackground"] as Long?),
                ctaTextColor = convertColor(this["ctaTextColor"] as Long?),
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
                iconSize = convertToDp(context,this["iconSize"] as Int? ?: defaultIconSize),
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

    private fun convertColor(colorValue: Long?): Int? {
        colorValue ?: return null
        val red: Long = (colorValue shr 16) and 0xFF
        val green: Long = (colorValue shr 8) and 0xFF
        val blue: Long = colorValue and 0xFF
        return Color.rgb(red.toInt(), green.toInt(), blue.toInt())
    }

    private fun convertToDp(context: Context, size: Int): Int {
        val r = context.resources
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            size.toFloat(),
            r.displayMetrics
        ).toInt()
    }
}