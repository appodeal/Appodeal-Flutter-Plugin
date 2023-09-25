import 'package:flutter/material.dart';

import '../../../../stack_appodeal_flutter.dart';
import 'utils.dart';

class AdAttributionOptions extends TextStyle with AppodealPlatformArguments {
  final double margin;
  final Color backgroundColor;

  AdAttributionOptions({
    Color color = Colors.black,
    this.margin = 4.0,
    this.backgroundColor = Colors.transparent,
  }) : super(color: color);

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'background': Utils.convertColorToInt(backgroundColor),
        'textColor': Utils.convertColorToInt(color),
      };
}
