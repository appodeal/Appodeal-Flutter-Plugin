import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class AdAttributionOptions extends ViewOptions {
  final int? margin;
  final Color? backgroundColor, textColor;

  const AdAttributionOptions(
      {this.margin = 4, this.backgroundColor, this.textColor})
      : super(margin: margin);

  @override
  Map<String, dynamic>? toMap() => {
        'margin': margin,
        'background': Utils.convertColorToInt(backgroundColor),
        'textColor': Utils.convertColorToInt(textColor),
      };
}
