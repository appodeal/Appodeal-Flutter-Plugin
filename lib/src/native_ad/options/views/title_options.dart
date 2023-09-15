import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class TitleOptions extends ViewOptions {
  final int? margin, textSize;
  final Color? textColor;

  TitleOptions({
    this.margin = 4,
    this.textSize = 16,
    this.textColor,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': textSize,
        'textColor': Utils.convertColorToInt(textColor),
      };
}
