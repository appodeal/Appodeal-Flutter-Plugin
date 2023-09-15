import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class DescriptionOptions extends ViewOptions {
  final int? margin, textSize;
  final Color? textColor;

  const DescriptionOptions(
      {this.margin = 4, this.textSize = 14, this.textColor})
      : super(margin: margin);

  @override
  Map<String, dynamic>? toMap() => {
        'margin': margin,
        'textSize': textSize,
        'textColor': Utils.convertColorToInt(textColor),
      };
}
