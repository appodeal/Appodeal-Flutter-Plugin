import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class CTAOptions extends ViewOptions {
  final int? textSize, margin, radius;
  final Color? background, textColor;

  const CTAOptions(
      {this.textSize = 16,
      this.margin = 4,
      this.radius = 16,
      this.background,
      this.textColor})
      : super(margin: margin);

  @override
  Map<String, dynamic>? toMap() => {
        'margin': margin,
        'textSize': textSize,
        'textColor': Utils.convertColorToInt(textColor),
        'background': Utils.convertColorToInt(background),
        'radius': radius,
      };
}
