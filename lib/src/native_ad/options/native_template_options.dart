import 'dart:ui';

import 'native_custom_options.dart';

class NativeTemplateOptions {
  final int? iconSize, titleTextSize, ctaTextSize, descriptionTextSize;
  final Color? adAttributionBackgroundColor, adAttributionTextColor;

  const NativeTemplateOptions({
    this.iconSize,
    this.titleTextSize,
    this.ctaTextSize,
    this.descriptionTextSize,
    this.adAttributionBackgroundColor,
    this.adAttributionTextColor,
  });

  Map<String, dynamic> get toMap => <String, dynamic>{
        'iconSize': iconSize,
        'titleTextSize': titleTextSize,
        'ctaTextSize': ctaTextSize,
        'ctaTextSize': ctaTextSize,
        'descriptionTextSize': descriptionTextSize,
        'adAttributionBackgroundColor':
            convertColorToInt(adAttributionBackgroundColor),
        'adAttributionTextColor': convertColorToInt(adAttributionTextColor),
      };
}
