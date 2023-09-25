import 'package:flutter/material.dart';

import '../../../../stack_appodeal_flutter.dart';
import 'utils.dart';

class CTAOptions extends TextStyle with AppodealPlatformArguments {
  final double margin;
  final double radius;
  final Color backgroundColor;

  CTAOptions({
    double fontSize = 16.0,
    Color color = Colors.black,
    this.margin = 4.0,
    this.radius = 16.0,
    this.backgroundColor = Colors.transparent,
  }) : super(fontSize: fontSize, color: color);

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': fontSize,
        'textColor': Utils.convertColorToInt(color),
        'background': Utils.convertColorToInt(backgroundColor),
        'radius': radius,
      };
}
