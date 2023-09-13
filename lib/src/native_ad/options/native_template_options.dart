import 'dart:ui';

import 'native_custom_options.dart';

class NativeTemplateOptions {
  final int? iconSize;
  final int? titleTextSize;
  final int? ctaTextSize;
  final int? descriptionTextSize;
  final Color? adAttributionBackgroundColor;
  final Color? adAttributionTextColor;

  const NativeTemplateOptions({
    this.iconSize,
    this.titleTextSize,
    this.ctaTextSize,
    this.descriptionTextSize,
    this.adAttributionBackgroundColor,
    this.adAttributionTextColor,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
    'iconSize' : iconSize,
    'titleTextSize': titleTextSize,
    'ctaTextSize': ctaTextSize,
    'ctaTextSize': ctaTextSize,
    'descriptionTextSize': descriptionTextSize,
    'adAttributionBackgroundColor': convertColorToInt(adAttributionBackgroundColor),
    'adAttributionTextColor': convertColorToInt(adAttributionTextColor),
  };
}
