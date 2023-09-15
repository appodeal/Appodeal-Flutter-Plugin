package com.appodeal.appodeal_flutter.native_params;

enum class NativeBannerViewPosition { ICON_START, CTA_START }

enum class MediaViewPosition { TOP, BOTTOM }

enum class AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }

enum class TemplateType { CONTENT_STREAM, APP_WALL, NEWS_FEED }

class NativeParams(
    val adChoicePosition: AdChoicePosition,
    val customOptions: CustomParams?,
    val templateOptions: TemplateParams?,
    val isTemplate: Boolean = customOptions == null,
)

class CustomParams(
    val viewHeight: Int,
    val mediaViewPosition: MediaViewPosition?,
    val viewPosition: NativeBannerViewPosition,
    val containerMargin: Int,
    val iconSize: Int,
    val iconMargin: Int,
    val titleTextSize: Int,
    val titleMargin: Int,
    val descriptionTextSize: Int,
    val descriptionMargin: Int,
    val ctaTextSize: Int,
    val ctaMargin: Int,
    val adAttributionMargin: Int,
    val mediaViewMargin: Int,
    val titleColor: Int?,
    val descriptionColor: Int?,
    val ctaBackground: Int?,
    val ctaTextColor: Int?,
    val ctaRadius: Int,
    val adAttributionBackgroundColor: Int?,
    val adAttributionTextColor: Int?,
)

class TemplateParams(
    val templateType: TemplateType,
    val iconSize: Int,
    val titleTextSize: Int,
    val ctaTextSize: Int,
    val descriptionTextSize: Int,
    val adAttributionBackgroundColor: Int?,
    val adAttributionTextColor: Int?,
)
