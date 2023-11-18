import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_color_apis.dart';

import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of call to action button that will do a action,
/// eg: INSTALL app, VISIT website, DOWNLOAD app.
class AdActionButtonConfig with AppodealPlatformArguments {
  final bool visible;
  final Color textColor;
  final Color backgroundColor;
  final int fontSize;
  final int margin;
  final int radius;

  AdActionButtonConfig({
    this.visible = true,
    this.fontSize = 14,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.margin = 0,
    this.radius = 8,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'fontSize': fontSize,
        'textColor': textColor.toHex(),
        'backgroundColor': backgroundColor.toHex(),
        'margin': margin,
        'radius': radius,
      };
}
