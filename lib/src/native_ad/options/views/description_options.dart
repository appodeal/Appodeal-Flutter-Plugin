import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class DescriptionOptions extends ViewOptions {
  final int? margin, textSize;
  final Color? textColor;

  DescriptionOptions({this.margin = 4, this.textSize = 14, this.textColor});

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': textSize,
        'textColor': Utils.convertColorToInt(textColor),
      };
}
