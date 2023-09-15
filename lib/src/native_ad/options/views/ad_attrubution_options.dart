import 'dart:ui';

import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

import 'utils.dart';

class AdAttributionOptions extends ViewOptions {
  final int? margin;
  final Color? backgroundColor, textColor;

  AdAttributionOptions({this.margin = 4, this.backgroundColor, this.textColor});

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'background': Utils.convertColorToInt(backgroundColor),
        'textColor': Utils.convertColorToInt(textColor),
      };
}
