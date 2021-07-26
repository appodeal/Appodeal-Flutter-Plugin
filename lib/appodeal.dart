
import 'dart:async';

import 'package:flutter/services.dart';

class Appodeal {
  static const MethodChannel _channel =
      const MethodChannel('appodeal');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
