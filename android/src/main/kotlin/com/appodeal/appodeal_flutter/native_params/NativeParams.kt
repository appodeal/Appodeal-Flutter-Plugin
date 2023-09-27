package com.appodeal.appodeal_flutter.native_params;

enum class NativeBannerViewPosition { ICON_START, CTA_START }

enum class MediaViewPosition { TOP, BOTTOM }

enum class AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }

enum class TemplateType { CONTENT_STREAM, APP_WALL, NEWS_FEED }

sealed class NativeParams(
    val adChoicePosition: AdChoicePosition,
    val iconSize: Int,
    val titleTextSize: Int,
    val ctaTextSize: Int,
    val descriptionTextSize: Int,
    val adAttributionBackgroundColor: Int?,
    val adAttributionTextColor: Int?,
    val viewHeight: Int,
)

class CustomParams(
    iconSize: Int,
    titleTextSize: Int,
    descriptionTextSize: Int,
    ctaTextSize: Int,
    adAttributionBackgroundColor: Int?,
    adAttributionTextColor: Int?,
    adChoicePosition: AdChoicePosition,
    viewHeight: Int,
    val mediaViewPosition: MediaViewPosition?,
    val viewPosition: NativeBannerViewPosition,
    val containerMargin: Int,
    val iconMargin: Int,
    val titleMargin: Int,
    val descriptionMargin: Int,
    val ctaMargin: Int,
    val adAttributionMargin: Int,
    val mediaViewMargin: Int,
    val titleColor: Int?,
    val descriptionColor: Int?,
    val ctaBackground: Int?,
    val ctaTextColor: Int?,
    val ctaRadius: Int,

    ) : NativeParams(
    adChoicePosition = adChoicePosition,
    iconSize = iconSize,
    titleTextSize = titleTextSize,
    ctaTextSize = ctaTextSize,
    descriptionTextSize = descriptionTextSize,
    adAttributionBackgroundColor = adAttributionBackgroundColor,
    adAttributionTextColor = adAttributionTextColor,
    viewHeight = viewHeight,
)

class TemplateParams(
    val templateType: TemplateType,
    viewHeight: Int,
    iconSize: Int,
    titleTextSize: Int,
    ctaTextSize: Int,
    descriptionTextSize: Int,
    adAttributionBackgroundColor: Int?,
    adAttributionTextColor: Int?,
    adChoicePosition: AdChoicePosition,
) : NativeParams(
    adChoicePosition = adChoicePosition,
    iconSize = iconSize,
    titleTextSize = titleTextSize,
    ctaTextSize = ctaTextSize,
    descriptionTextSize = descriptionTextSize,
    adAttributionBackgroundColor = adAttributionBackgroundColor,
    adAttributionTextColor = adAttributionTextColor,
    viewHeight = viewHeight,
)
