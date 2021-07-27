import 'dart:async';

import 'package:flutter/services.dart';

class Appodeal {

  static const BANNER = 1;
  static const NATIVE = 2;
  static const INTERSTITIAL = 3;
  static const REWARDED_VIDEO = 4;
  static const NON_SKIPPABLE = 5;

  static const LogLevelNone = 0;
  static const LogLevelDebug = 1;
  static const LogLevelVerbose = 2;

  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// <summary>
  /// Initializes the relevant (Android or iOS) Appodeal SDK.
  /// See <see cref="Appodeal.initialize"/> for resulting triggered event.
  /// <param name="appKey">Appodeal app key you received when you created an app.</param>
  /// <param name="adTypes">Type of advertising you want to initialize.</param>
  /// <param name="hasConsent">User has given consent to the processing of personal data relating to him or her. https://www.eugdpr.org/.</param>
  ///
  ///  To initialize only interstitials use <see cref="Appodeal.initialize(appKey, Appodeal.INTERSTITIAL, hasConsent);"/>
  ///  To initialize only banners use <see cref="Appodeal.initialize(appKey, Appodeal.BANNER, hasConsent);"/>
  ///  To initialize only rewarded video use <see cref="Appodeal.initialize(appKey, Appodeal.REWARDED_VIDEO, hasConsent);"/>
  ///  To initialize only non-skippable video use <see cref="Appodeal.initialize(appKey, Appodeal.NON_SKIPPABLE_VIDEO, hasConsent);"/>
  ///  To initialize only 300*250 banners use <see cref="Appodeal.initialize(appKey, Appodeal.MREC, hasConsent);"/>
  /// </summary>
  static Future<void> initialize(String appKey, List<int> adTypes, bool hasConsent) async {
    return _channel.invokeMethod('initialize', {
      'appKey': appKey,
      'adTypes': adTypes,
      'hasConsent': hasConsent
    });
  }

  /// <summary>
  /// Check if ad type is initialized
  /// See <see cref="Appodeal.isInitialized"/> for resulting triggered event.
  /// <param name="adType">adType type of advertising.</param>
  /// </summary>
  static Future<bool> isInitialized(int adType) async {
    return await _channel.invokeMethod('isInitialized', {
      'adType': adType,
    }) ?? false;
  }

  //**
  /// <summary>
  /// Initializes the relevant (Android or iOS) Appodeal SDK.
  /// See <see cref="Appodeal.initialize"/> for resulting triggered event.
  /// <param name="appKey">Appodeal app key you received when you created an app.</param>
  /// <param name="adTypes">Type of advertising you want to initialize.</param>
  /// <param name="consent">Consent info object from Stack ConsentManager SDK.</param>
  ///
  ///  To initialize only interstitials use <see cref="Appodeal.initialize(appKey, Appodeal.INTERSTITIAL, consent);"/>
  ///  To initialize only banners use <see cref="Appodeal.initialize(appKey, Appodeal.BANNER, consent);"/>
  ///  To initialize only rewarded video use <see cref="Appodeal.initialize(appKey, Appodeal.REWARDED_VIDEO, consent);"/>
  ///  To initialize only non-skippable video use <see cref="Appodeal.initialize(appKey, Appodeal.NON_SKIPPABLE_VIDEO, consent);"/>
  ///  To initialize only 300*250 banners use <see cref="Appodeal.initialize(appKey, Appodeal.MREC, consent);"/>
  /// </summary>
  // TODO Need to implement
  // public static void initialize(string appKey, int adTypes, Consent consent)
  // */

  /// <summary>
  /// Update consent value for ad networks in Appodeal SDK
  /// See <see cref="Appodeal.updateConsent"/> for resulting triggered event.
  /// <param name="hasConsent"> this param user has given consent to the processing of personal data relating to him or her. https://www.eugdpr.org/.</param>
  /// </summary>
  static Future<void> updateConsent(bool hasConsent) async {
    return _channel.invokeMethod('updateConsent', {
      'hasConsent': hasConsent
    });
  }

  /// <summary>
  /// Check if auto cache enabled for  this ad type
  /// See <see cref="Appodeal.isAutoCacheEnabled"/> for resulting triggered event.
  /// <param name="adType">adType type of advertising.</param>
  /// </summary>
  static Future<bool> isAutoCacheEnabled(int adType) async {
    return await _channel.invokeMethod('isAutoCacheEnabled', {
      'adType': adType,
    }) ?? false;
  }

  /// <summary>
  /// Set Interstitial ads callbacks
  /// See <see cref="Appodeal.setInterstitialCallbacks"/> for resulting triggered event.
  /// <param name="listener">callbacks implementation of Appodeal/Common/Appodeal/IInterstitialAdListener.</param>
  /// </summary>
  /// TODO Need to implement
  //public static void setInterstitialCallbacks(IInterstitialAdListener listener)

  /// <summary>
  /// Set Interstitial ads callbacks
  /// See <see cref="Appodeal.setNonSkippableVideoCallbacks"/> for resulting triggered event.
  /// <param name="listener">callbacks implementation of Appodeal/Common/Appodeal/INonSkippableVideoAdListener.</param>
  /// </summary>
  /// TODO Need to implement
  //public static void setNonSkippableVideoCallbacks(INonSkippableVideoAdListener listener)

  /// <summary>
  /// Set Interstitial ads callbacks
  /// See <see cref="Appodeal.setRewardedVideoCallbacks"/> for resulting triggered event.
  /// <param name="listener">callbacks implementation of Appodeal/Common/Appodeal/IRewardedVideoAdListener.</param>
  /// </summary>
  ///  TODO Need to implement
  //public static void setRewardedVideoCallbacks(IRewardedVideoAdListener listener)


  /// <summary>
  /// Set Interstitial ads callbacks
  /// See <see cref="Appodeal.setBannerCallbacks"/> for resulting triggered event.
  /// <param name="listener">callbacks implementation of Appodeal/Common/Appodeal/IBannerAdListener.</param>
  /// </summary>
  ///  TODO Need to implement
  //public static void setBannerCallbacks(IBannerAdListener listener)

  /// <summary>
  /// Set Interstitial ads callbacks
  /// See <see cref="Appodeal.setMrecCallbacks"/> for resulting triggered event.
  /// <param name="listener">callbacks implementation of Appodeal/Common/Appodeal/IMrecAdListener.</param>
  /// </summary>
  /// TODO Need to implement
  //public static void setMrecCallbacks(IMrecAdListener listener)

  /// <summary>
  /// Start caching ads.
  /// See <see cref="Appodeal.cache"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising.</param>
  /// </summary>
  static Future<void> cache(int adType) async {
    return _channel.invokeMethod('cache', {
      'adType': adType,
    });
  }

  static Future<void> setTesting(bool testMode) async {
    return _channel.invokeMethod('setTesting', {
      'testMode': testMode,
    });
  }

  static Future<void> setLogLevel(int logLevel) async {
    return _channel.invokeMethod('setLogLevel', {
      'logLevel': logLevel,
    });
  }

  static Future<void> setAutoCache(int adType, bool autoCache) async {
    return _channel.invokeMethod('setAutoCache', {
      'adType': adType,
      'autoCache': autoCache,
    });
  }
}
