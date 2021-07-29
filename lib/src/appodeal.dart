import 'dart:async';

import 'package:flutter/services.dart';

class Appodeal {
  static const BANNER = 1;
  static const BANNER_RIGHT = 2;
  static const BANNER_TOP = 3;
  static const BANNER_LEFT = 4;
  static const BANNER_BOTTOM = 5;
  static const NATIVE = 6;
  static const INTERSTITIAL = 7;
  static const REWARDED_VIDEO = 8;
  static const NON_SKIPPABLE = 9;

  static const LogLevelNone = 0;
  static const LogLevelDebug = 1;
  static const LogLevelVerbose = 2;

  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');

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
    return _channel.invokeMethod('initialize', {'appKey': appKey, 'adTypes': adTypes, 'hasConsent': hasConsent});
  }

  /// <summary>
  /// Check if ad type is initialized
  /// See <see cref="Appodeal.isInitialized"/> for resulting triggered event.
  /// <param name="adType">adType type of advertising.</param>
  /// </summary>
  static Future<bool> isInitialized(int adType) async {
    return await _channel.invokeMethod('isInitialized', {
          'adType': adType,
        }) ??
        false;
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
    return _channel.invokeMethod('updateConsent', {'hasConsent': hasConsent});
  }

  /// <summary>
  /// Check if auto cache enabled for  this ad type
  /// See <see cref="Appodeal.isAutoCacheEnabled"/> for resulting triggered event.
  /// <param name="adType">adType type of advertising.</param>
  /// </summary>
  static Future<bool> isAutoCacheEnabled(int adType) async {
    return await _channel.invokeMethod('isAutoCacheEnabled', {
          'adType': adType,
        }) ??
        false;
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

  /// <summary>
  /// Show advertising.
  /// See <see cref="Appodeal.show"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising.</param>
  /// </summary>
  static Future<bool> show(int adType) async {
    return await _channel.invokeMethod('show', {
          'adType': adType,
        }) ??
        false;
  }

  static Future<bool> showWithPlacement(int adType, String placement) async {
    return await _channel.invokeMethod('showWithPlacement', {
          'adType': adType,
          'placement': placement,
        }) ??
        false;
  }

  /// <summary>
  /// Show banner view.
  /// See <see cref="Appodeal.showBannerView"/> for resulting triggered event.
  /// <param name="YAxis">y position for banner view.</param>
  /// <param name="XGravity">x position for banner view.</param>
  /// <param name="placement">type of advertising you want to show.</param>
  /// </summary>
  ///  TODO Need to implement
  //public static bool showBannerView(int YAxis, int XGravity, string placement)

  /// <summary>
  /// Show mrec view.
  /// See <see cref="Appodeal.showMrecView"/> for resulting triggered event.
  /// <param name="YAxis">y position for mrec view.</param>
  /// <param name="XGravity">x position for mrec view.</param>
  /// <param name="placement">type of advertising you want to show.</param>
  /// </summary>
  /// TODO Need to implement
  //public static bool showMrecView(int YAxis, int XGravity, string placement)

  /// <summary>
  /// Hide advertising.
  /// See <see cref="Appodeal.hide"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising  Appodeal.BANNER</param>
  /// </summary>
  static Future<void> hide(int adType) async {
    return _channel.invokeMethod('hide', {
      'adType': adType,
    });
  }

  /// <summary>
  /// Hide Banner View.
  /// See <see cref="Appodeal.hideBannerView"/> for resulting triggered event.
  /// </summary>
  /// TODO Need to implement
  //public static void hideBannerView()

  /// <summary>
  /// Hide Mrec view.
  /// See <see cref="Appodeal.hideMrecView"/> for resulting triggered event.
  /// </summary>
  /// TODO Need to implement
  //public static void hideMrecView()

  /// <summary>
  /// Start or stop auto caching new ads when current ads was shown..
  /// See <see cref="Appodeal.setAutoCache"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising </param>
  /// <param name="autoCache">true to use auto cache, false to not.</param>
  /// </summary>
  static Future<void> setAutoCache(int adType, bool autoCache) async {
    return _channel.invokeMethod('setAutoCache', {
      'adType': adType,
      'autoCache': autoCache,
    });
  }

  /// <summary>
  /// Triggering onLoaded callback when precache loaded.
  /// See <see cref="Appodeal.setTriggerOnLoadedOnPrecache"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising </param>
  /// <param name="onLoadedTriggerBoth">true - onLoaded will trigger when precache or normal ad were loaded.
  ///                         false - onLoaded will trigger only when normal ad was loaded (default).</param>
  /// </summary>
  static Future<void> setTriggerOnLoadedOnPrecache(int adType, bool onLoadedTriggerBoth) async {
    return _channel.invokeMethod('setTriggerOnLoadedOnPrecache', {
      'adType': adType,
      'onLoadedTriggerBoth': onLoadedTriggerBoth,
    });
  }

  /// <summary>
  /// Enabling shared ads instance across activities (disabled by default).
  /// See <see cref="Appodeal.setSharedAdsInstanceAcrossActivities"/> for resulting triggered event.
  /// <param name="sharedAdsInstanceAcrossActivities">enabling or disabling shared ads instance across activities.</param>
  /// </summary>
  static Future<void> setSharedAdsInstanceAcrossActivities(bool sharedAdsInstanceAcrossActivities) async {
    return _channel.invokeMethod('setSharedAdsInstanceAcrossActivities', {
      'sharedAdsInstanceAcrossActivities': sharedAdsInstanceAcrossActivities,
    });
  }

  /// <summary>
  /// Checking if ad is loaded. Return true if ads currently loaded and can be shown.
  /// See <see cref="Appodeal.isLoaded"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising </param>
  /// </summary>
  static Future<bool> isLoaded(int adType) async {
    return await _channel.invokeMethod('isLoaded', {
          'adType': adType,
        }) ??
        false;
  }

  /// <summary>
  /// Checking if loaded ad is precache. Return true if currently loaded ads is precache.
  /// See <see cref="Appodeal.isPrecache"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising. Currently supported only for interstitials. </param>
  /// </summary>
  static Future<bool> isPrecache(int adType) async {
    return await _channel.invokeMethod('isPrecache', {
      'adType': adType,
    }) ??
        false;
  }

  /// <summary>
  /// Enabling or disabling smart banners (Enabled by default).
  /// See <see cref="Appodeal.setSmartBanners"/> for resulting triggered event.
  /// <param name="enabled">enabled enabling or disabling loading smart banners.</param>
  /// </summary>
  static Future<void> setSmartBanners(bool smartBannerEnabled) async {
    return _channel.invokeMethod('setSmartBanners', {
      'smartBannerEnabled': smartBannerEnabled,
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
}
