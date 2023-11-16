import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_color_apis.dart';

import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of ad attribution text.
class AdAttributionConfig with AppodealPlatformArguments {
  final bool visible;
  final int fontSize;
  final Color textColor;
  final Color backgroundColor;
  final int margin;

  AdAttributionConfig({
    this.visible = true,
    this.fontSize = 12,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.margin = 4,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'fontSize': fontSize,
        'textColor': textColor.toHex(),
        'backgroundColor': backgroundColor.toHex(),
        'margin': margin,
      };
}
