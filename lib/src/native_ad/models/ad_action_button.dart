import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_color_apis.dart';

import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of call to action button that will do a action,
/// eg: INSTALL app, VISIT website, DOWNLOAD app.
class AdActionButtonConfig with AppodealPlatformArguments {
  final bool visible;
  final Color textColor;
  final Color buttonColor;
  final int fontSize;

  final int margin;
  final int radius;

  AdActionButtonConfig({
    this.visible = true,
    this.fontSize = 12,
    this.textColor = Colors.black,
    this.buttonColor = Colors.transparent,
    this.margin = 4,
    this.radius = 16,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'fontSize': fontSize,
        'textColor': textColor.toHex(),
        'buttonColor': buttonColor.toHex(),
        'margin': margin,
        'radius': radius,
      };
}
