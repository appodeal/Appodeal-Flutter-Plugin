import 'package:flutter/material.dart';

import '../../../../stack_appodeal_flutter.dart';
import 'utils.dart';

class DescriptionOptions extends TextStyle with AppodealPlatformArguments {
  final double margin;

  DescriptionOptions({
    double fontSize = 16.0,
    Color color = Colors.black,
    this.margin = 4.0,
  }) : super(fontSize: fontSize, color: color);

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': fontSize,
        'textColor': Utils.convertColorToInt(color),
      };
}
