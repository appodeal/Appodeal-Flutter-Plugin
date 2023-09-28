import 'package:flutter/material.dart';

import '../../../../stack_appodeal_flutter.dart';
import 'utils.dart';

class CTAOptions extends TextStyle with AppodealPlatformArguments {
  final int margin;
  final int radius;
  final Color backgroundColor;

  CTAOptions({
    final int fontSize = 16,
    final Color color = Colors.black,
    this.margin = 4,
    this.radius = 16,
    this.backgroundColor = Colors.transparent,
  }) : super(fontSize: fontSize.toDouble(), color: color);

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': fontSize?.toInt(),
        'textColor': Utils.convertColorToInt(color),
        'background': Utils.convertColorToInt(backgroundColor),
        'radius': radius,
      };
}