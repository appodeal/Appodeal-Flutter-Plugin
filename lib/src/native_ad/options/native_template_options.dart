import 'dart:ui';

import 'native_options.dart';
import 'views/utils.dart';

class NativeTemplateOptions extends NativeOptions {
  final int? iconSize, titleTextSize, ctaTextSize, descriptionTextSize;
  final Color? adAttributionBackgroundColor, adAttributionTextColor;

  NativeTemplateOptions({
    this.iconSize,
    this.titleTextSize,
    this.ctaTextSize,
    this.descriptionTextSize,
    this.adAttributionBackgroundColor,
    this.adAttributionTextColor,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'iconSize': iconSize,
        'titleTextSize': titleTextSize,
        'ctaTextSize': ctaTextSize,
        'descriptionTextSize': descriptionTextSize,
        'adAttributionBackgroundColor': Utils.convertColorToInt(adAttributionBackgroundColor),
        'adAttributionTextColor': Utils.convertColorToInt(adAttributionTextColor),
      };
}
