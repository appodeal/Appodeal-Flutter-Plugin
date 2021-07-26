
import 'dart:async';

import 'package:flutter/services.dart';

class Appodeal {

  static const BANNER = 1;
  static const NATIVE = 2;
  static const INTERSTITIAL = 3;
  static const REWARD = 4;
  static const NON_SKIPPABLE = 5;

  static const MethodChannel _channel =
  const MethodChannel('appodeal_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> setTesting(bool testMode) async {
    return _channel.invokeMethod('setTesting', {
      'testMode': testMode,
    });
  }

  static Future<void> setAutoCache(int adType, bool autoCache) async {
    return _channel.invokeMethod('setAutoCache', {
      'adType': adType,
      'autoCache': autoCache,
    });
  }
}