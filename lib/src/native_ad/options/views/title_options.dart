import 'package:flutter/material.dart';

import '../../../../stack_appodeal_flutter.dart';
import 'utils.dart';

class TitleOptions extends TextStyle with AppodealPlatformArguments {
  final int margin;

  TitleOptions({
    int fontSize = 16,
    Color color = Colors.black,
    this.margin = 4,
  }) : super(fontSize: fontSize.toDouble(), color: color);

  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'textSize': fontSize?.toInt(),
        'textColor': Utils.convertColorToInt(color),
      };
}