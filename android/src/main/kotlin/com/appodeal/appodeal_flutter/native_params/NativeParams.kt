package com.appodeal.appodeal_flutter.native_params;

enum class NativeBannerViewPosition { ICON_START, CTA_START }

enum class MediaViewPosition { TOP, BOTTOM }

enum class AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }

enum class TemplateType { CONTENT_STREAM, APP_WALL, NEWS_FEED }

class NativeParams(
    val adChoicePosition: AdChoicePosition,
    val customOptions: CustomParams?,
    val templateOptions: TemplateParams?,
    val isTemplate: Boolean = customOptions == null
) {
    override fun toString(): String {
        return "NativeParams: \nadChoicePosition=$adChoicePosition, \ncustomOptions=${customOptions.toString()}, \ntemplateOptions=${templateOptions.toString()}, \nisTemplate=$isTemplate"
    }
}

class CustomParams(
    val mediaViewPosition: MediaViewPosition,
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
    val titleColor: Int?,
    val descriptionColor: Int?,
    val ctaBackground: Int?,
    val ctaTextColor: Int?
) {
    override fun toString(): String {
        return "CustomParams: \nmediaViewPosition=$mediaViewPosition, \nviewPosition=$viewPosition, \ncontainerMargin=$containerMargin, \niconSize=$iconSize, \niconMargin=$iconMargin, \ntitleTextSize=$titleTextSize, \ntitleMargin=$titleMargin, \ndescriptionTextSize=$descriptionTextSize, \ndescriptionMargin=$descriptionMargin, \nctaTextSize=$ctaTextSize, \nctaMargin=$ctaMargin, \ntitleColor=$titleColor, \ndescriptionColor=$descriptionColor, \nctaBackground=$ctaBackground, \nctaTextColor=$ctaTextColor"
    }
}

class TemplateParams(
    val templateType: TemplateType,
    val iconSize: Int,
    val titleTextSize: Int,
    val ctaTextSize: Int,
    val descriptionTextSize: Int?,
    val adAttributionBackgroundColor: Int?,
    val adAttributionTextColor: Int?
) {
    override fun toString(): String {
        return "TemplateParams: \ntemplateType=$templateType, \niconSize=$iconSize, \ntitleTextSize=$titleTextSize, \nctaTextSize=$ctaTextSize, \ndescriptionTextSize=$descriptionTextSize, \nadAttributionBackgroundColor=$adAttributionBackgroundColor, \nadAttributionTextColor=$adAttributionTextColor"
    }

}

