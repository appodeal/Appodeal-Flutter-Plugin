class NativeBannerOptions {
  final NativeBannerViewPosition? viewPosition;
  final int? containerMargin,
      iconSize,
      iconMargin,
      titleMargin,
      descriptionSize,
      descriptionMargin,
      ctaTextSize,
      ctaMargin;
  final double? titleColor, descriptionColor, ctaBackground, ctaTextColor;

  const NativeBannerOptions({
    this.viewPosition = NativeBannerViewPosition.ICON_START,
    this.containerMargin,
    this.iconSize,
    this.iconMargin,
    this.titleMargin,
    this.descriptionSize,
    this.descriptionMargin,
    this.ctaTextSize,
    this.ctaMargin,
    this.titleColor,
    this.descriptionColor,
    this.ctaBackground,
    this.ctaTextColor,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
        'viewPosition' : viewPosition,
        'containerMargin': containerMargin,
        'iconSize': iconSize,
        'iconMargin': iconMargin,
        'titleMargin': titleMargin,
        'descriptionSize': descriptionSize,
        'descriptionMargin': descriptionMargin,
        'ctaTextSize': ctaTextSize,
        'ctaMargin': ctaMargin,
        'titleColor': titleColor,
        'descriptionColor': descriptionColor,
        'ctaBackground': ctaBackground,
        'ctaTextColor': ctaTextColor,
      };
}

enum NativeBannerViewPosition { ICON_START, CTA_START }
