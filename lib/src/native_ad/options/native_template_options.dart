import 'dart:ui';

class NativeTemplateOptions {
  final int? iconSize;
  final int? titleTextSize;
  final int? ctaTextSize;
  final int? descriptionViewTextSize;
  final Color? adAttributionBackgroundColor;
  final Color? adAttributionTextColor;

  const NativeTemplateOptions({
    this.iconSize,
    this.titleTextSize,
    this.ctaTextSize,
    this.descriptionViewTextSize,
    this.adAttributionBackgroundColor,
    this.adAttributionTextColor,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
    'iconSize' : iconSize,
    'titleTextSize': titleTextSize,
    'ctaTextSize': ctaTextSize,
    'ctaTextSize': ctaTextSize,
    'descriptionViewTextSize': descriptionViewTextSize,
    'adAttributionBackgroundColor': adAttributionBackgroundColor?.value,
    'adAttributionTextColor': adAttributionTextColor?.value,
  };
}
