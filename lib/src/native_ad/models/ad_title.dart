import 'package:flutter/material.dart';

import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of title text.
class AdTitleConfig with AppodealPlatformArguments {
  final bool visible;
  final int fontSize;
  final Color textColor;

  final int margin;

  AdTitleConfig({
    this.visible = true,
    this.fontSize = 16,
    this.textColor = Colors.black,
    this.margin = 4,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'fontSize': fontSize,
        'textColor': textColor.value, // A 32 bit value representing this color.
        'margin': margin,
      };
}
