import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class CTAOptions extends ViewOptions {
  final int? textSize, margin, radius;
  final Color? background, textColor;

  CTAOptions(
      {this.textSize = 16,
      this.margin = 4,
      this.radius = 16,
      this.background,
      this.textColor});

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': textSize,
        'textColor': Utils.convertColorToInt(textColor),
        'background': Utils.convertColorToInt(background),
        'radius': radius,
      };
}
