import 'dart:ui';

class NativeCustomOptions {
  final NativeBannerViewPosition? viewPosition;
  final MediaViewPosition? mediaViewPosition;
  final int? containerMargin,
      iconSize,
      iconMargin,
      titleTextSize,
      titleMargin,
      descriptionTextSize,
      descriptionMargin,
      ctaTextSize,
      ctaMargin;
  final Color? titleColor, descriptionColor, ctaBackground, ctaTextColor;

  const NativeCustomOptions({
    this.viewPosition = NativeBannerViewPosition.ICON_START,
    this.mediaViewPosition,
    this.containerMargin,
    this.iconSize,
    this.iconMargin,
    this.titleTextSize,
    this.titleMargin,
    this.descriptionTextSize,
    this.descriptionMargin,
    this.ctaTextSize,
    this.ctaMargin,
    this.titleColor,
    this.descriptionColor,
    this.ctaBackground,
    this.ctaTextColor,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
        'mediaViewPosition': mediaViewPosition?.toString(),
        'viewPosition': viewPosition?.toString(),
        'containerMargin': containerMargin,
        'iconSize': iconSize,
        'titleTextSize': titleTextSize,
        'iconMargin': iconMargin,
        'titleMargin': titleMargin,
        'descriptionTextSize': descriptionTextSize,
        'descriptionMargin': descriptionMargin,
        'ctaTextSize': ctaTextSize,
        'ctaMargin': ctaMargin,
        'titleColor': convertColorToInt(titleColor),
        'descriptionColor': convertColorToInt(descriptionColor),
        'ctaBackground': convertColorToInt(ctaBackground),
        'ctaTextColor': convertColorToInt(ctaTextColor),
      };
}

int? convertColorToInt(Color? color) {
  if (color == null) return null;
  final hexColor = color.value.toRadixString(16).toUpperCase();
  return int.parse('0xFF$hexColor');
}

enum NativeBannerViewPosition { ICON_START, CTA_START }

enum MediaViewPosition { TOP, BOTTOM }
