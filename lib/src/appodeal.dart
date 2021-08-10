import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class Appodeal {
  static const APPODEAL_FLUTTER_PLUGIN_VERSION = "1.0";

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

  static const GENDER_OTHER = 0;
  static const GENDER_MALE = 1;
  static const GENDER_FEMALE = 2;

  static Function(String, int, bool) ?_onBannerLoaded;
  static Function(String event) ?_onBannerFailedToLoad;
  static Function(String event) ?_onBannerShown;
  static Function(String event) ?_onBannerShowFailed;
  static Function(String event) ?_onBannerClicked;
  static Function(String event) ?_onBannerExpired;


  static Function(String) ?_interstitialCallback;
  static Function(String) ?_rewardCallback;
  static Function(String) ?_nonSkippableCallback;

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
    _setCallbacks();
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

  /// <summary>
  /// Show advertising.
  /// See <see cref="Appodeal.show"/> for resulting triggered event.
  /// <param name="adTypes">adType type of advertising.</param>
  /// <param name="placement">name of placement.</param>
  /// </summary>
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

  /// <summary>
  /// Enabling or disabling banners background (Enabled by default).
  /// See <see cref="Appodeal.setBannerBackground"/> for resulting triggered event.
  /// <param name="enabled">enabled enabling or disabling banners background (only for iOS platform)</param>
  /// </summary>
  /// TODO need to implement
  //public static void setBannerBackground(bool enabled)

  /// <summary>
  /// Enabling or disabling 728*90 banners (Disabled by default).
  /// See <see cref="Appodeal.setTabletBanners"/> for resulting triggered event.
  /// <param name="enabled">enabled enabling or disabling loading 728*90 banners.</param>
  /// </summary>
  static Future<void> setTabletBanners(bool tabletBannerEnabled) async {
    return _channel.invokeMethod('setTabletBanners', {
      'tabletBannerEnabled': tabletBannerEnabled,
    });
  }

  /// <summary>
  /// Enabling animation of banners (Enabled by default).
  /// See <see cref="Appodeal.setBannerAnimation"/> for resulting triggered event.
  /// <param name="enabled">animate enabling or disabling animations.</param>
  /// </summary>
  static Future<void> setBannerAnimation(bool bannerAnimationEnabled) async {
    return _channel.invokeMethod('setBannerAnimation', {
      'bannerAnimationEnabled': bannerAnimationEnabled,
    });
  }

  /// <summary>
  /// Setting banners inverse rotation (by default: left = -90, right = 90).
  /// See <see cref="Appodeal.setBannerRotation"/> for resulting triggered event.
  /// <param name="leftBannerRotation">leftBannerRotation rotation for Appodeal.BANNER_LEFT.</param>
  /// <param name="rightBannerRotation">leftBannerRotation rotation for Appodeal.BANNER_RIGHT.</param>
  /// </summary>
  static Future<void> setBannerRotation(int leftBannerRotation, int rightBannerRotation) async {
    return _channel.invokeMethod('setBannerRotation', {
      'leftBannerRotation': leftBannerRotation,
      'rightBannerRotation': rightBannerRotation,
    });
  }

  /// <summary>
  /// Tracks in-app purchase information and sends info to our servers for analytics.
  /// See <see cref="Appodeal.trackInAppPurchase"/> for resulting triggered event.
  /// <param name="amount">amount of purchase.</param>
  /// <param name="currency">currency of purchase.</param>
  /// </summary>
  static Future<void> trackInAppPurchase(double amount, String currency) async {
    return _channel.invokeMethod('trackInAppPurchase', {
      'amount': amount,
      'currency': currency,
    });
  }

  /// <summary>
  /// Disabling specified network for all ad types.
  /// See <see cref="Appodeal.disableNetwork"/> for resulting triggered event.
  /// <param name="network">network name.</param>
  /// </summary>
  static Future<void> disableNetwork(String network) async {
    return _channel.invokeMethod('disableNetwork', {
      'network': network,
    });
  }

  /// <summary>
  /// Disabling specified network for specified ad types.
  /// See <see cref="Appodeal.disableNetworkForSpecificAdType"/> for resulting triggered event.
  /// <param name="network">network name.</param>
  /// <param name="adTypes">adType type of advertising.</param>
  /// </summary>
  static Future<void> disableNetworkForSpecificAdType(String network, int adType) async {
    return _channel.invokeMethod('disableNetworkForSpecificAdType', {
      'network': network,
      'adType': adType,
    });
  }

  /// <summary>
  /// Disabling location permission check only for Android platform.
  /// See <see cref="Appodeal.disableLocationPermissionCheck"/> for resulting triggered event.
  /// </summary>
  static Future<void> disableLocationPermissionCheck() async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod('disableLocationPermissionCheck');
    }
  }

  /// <summary>
  /// Disabling write external storage permission check only for Android platform.
  /// See <see cref="Appodeal.disableWriteExternalStoragePermissionCheck"/> for resulting triggered event.
  /// </summary>
  static Future<void> disableWriteExternalStoragePermissionCheck() async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod('disableWriteExternalStoragePermissionCheck');
    }
  }

  /// <summary>
  /// Set user id.
  /// See <see cref="Appodeal.setUserId"/> for resulting triggered event.
  /// <param name="id">user id.</param>
  /// </summary>
  static Future<void> setUserId(String userId) async {
    return _channel.invokeMethod('setUserId', {
      'userId': userId,
    });
  }

  /// <summary>
  /// Set user age.
  /// See <see cref="Appodeal.setUserAge"/> for resulting triggered event.
  /// <param name="age">user gender.</param>
  /// </summary>
  static Future<void> setUserAge(int age) async {
    return _channel.invokeMethod('setUserAge', {
      'age': age,
    });
  }

  /// <summary>
  /// Set user gender.
  /// See <see cref="Appodeal.setUserGender"/> for resulting triggered event.
  /// <param name="gender">user gender.</param>
  /// </summary>
  static Future<void> setUserGender(int gender) async {
    return _channel.invokeMethod('setUserGender', {
      'gender': gender,
    });
  }

  /// <summary>
  /// Enabling test mode.
  //  In test mode test ads will be shown and debug data will be written to logcat.
  /// See <see cref="Appodeal.setTesting"/> for resulting triggered event.
  /// </summary>
  static Future<void> setTesting(bool testMode) async {
    return _channel.invokeMethod('setTesting', {
      'testMode': testMode,
    });
  }

  /// <summary>
  /// Set log level. All logs will be written with tag "Appodeal".
  /// See <see cref="Appodeal.setLogLevel"/> for resulting triggered event.
  /// <param name="log">logLevel log level .</param>
  /// </summary>
  static Future<void> setLogLevel(int logLevel) async {
    return _channel.invokeMethod('setLogLevel', {
      'logLevel': logLevel,
    });
  }

  /// <summary>
  /// Set custom segment filter.
  /// See <see cref="Appodeal.setCustomFilter"/> for resulting triggered event.
  /// <param name="name">name  name of the filter.</param>
  /// <param name="value">value filter value.</param>
  /// </summary>
  static Future<void> setCustomFilterBool(String name, bool value) async {
    return _channel.invokeMethod('setCustomFilterBool', {
      'name': name,
      'value': value,
    });
  }

  /// <summary>
  /// Set custom segment filter.
  /// See <see cref="Appodeal.setCustomFilter"/> for resulting triggered event.
  /// <param name="name">name  name of the filter.</param>
  /// <param name="value">value filter value.</param>
  /// </summary>
  static Future<void> setCustomFilterInt(String name, int value) async {
    return _channel.invokeMethod('setCustomFilterInt', {
      'name': name,
      'value': value,
    });
  }

  /// <summary>
  /// Set custom segment filter.
  /// See <see cref="Appodeal.setCustomFilter"/> for resulting triggered event.
  /// <param name="name">name  name of the filter.</param>
  /// <param name="value">value filter value.</param>
  /// </summary>
  static Future<void> setCustomFilterDouble(String name, double value) async {
    return _channel.invokeMethod('setCustomFilterDouble', {
      'name': name,
      'value': value,
    });
  }

  /// <summary>
  /// Set custom segment filter.
  /// See <see cref="Appodeal.setCustomFilter"/> for resulting triggered event.
  /// <param name="name">name  name of the filter.</param>
  /// <param name="value">value filter value.</param>
  /// </summary>
  static Future<void> setCustomFilterString(String name, String value) async {
    return _channel.invokeMethod('setCustomFilterString', {
      'name': name,
      'value': value,
    });
  }

  /// <summary>
  /// Check if ad with specific ad type can be shown with placement.
  /// See <see cref="Appodeal.canShow"/> for resulting triggered event.
  /// <param name="adTypes">type of advertising.</param>
  /// </summary>
  static Future<bool> canShow(int adType) async {
    return await _channel.invokeMethod('canShow', {
      'adType': adType,
    }) ??
        false;
  }

  /// <summary>
  /// Check if ad with specific ad type can be shown with placement.
  /// See <see cref="Appodeal.canShow"/> for resulting triggered event.
  /// <param name="adTypes">type of advertising.</param>
  /// <param name="placement">placement name.</param>
  /// </summary>
  static Future<bool> canShowWithPlacement(int adType, String placement) async {
    return await _channel.invokeMethod('canShowWithPlacement', {
      'adType': adType,
      'placement': placement,
    }) ??
        false;
  }

  /// <summary>
  /// Mute video if calls muted on device (supports only for Android platform).
  /// See <see cref="Appodeal.muteVideosIfCallsMuted"/> for resulting triggered event.
  /// <param name="value">true - mute videos if call volume is 0.</param>
  /// </summary>
  static Future<void> muteVideosIfCallsMuted(bool value) async {
    return _channel.invokeMethod('muteVideosIfCallsMuted', {
      'value': value,
    });
  }

  /// <summary>
  /// Disables data collection for kids apps.
  /// See <see cref="Appodeal.setChildDirectedTreatment"/> for resulting triggered event.
  /// <param name="value">value true to disable data collection for kids apps.</param>
  /// </summary>
  static Future<void> setChildDirectedTreatment(bool value) async {
    return _channel.invokeMethod('setChildDirectedTreatment', {
      'value': value,
    });
  }

  /// <summary>
  /// Destroy cached ad.
  /// See <see cref="Appodeal.destroy"/> for resulting triggered event.
  /// <param name="adTypes">adTypes ad types you want to destroy.</param>
  /// </summary>
  static Future<void> destroy(int adType) async {
    return _channel.invokeMethod('destroy', {
      'adType': adType,
    });
  }

  /// <summary>
  /// Add extra data to Appodeal.
  /// See <see cref="Appodeal.setExtraData"/> for resulting triggered event.
  /// <param name="key">associated with value.</param>
  /// <param name="value">value which will be saved in extra data by key.</param>
  /// </summary>
  static Future<void> setExtraDataString(String key, String value) async {
    return _channel.invokeMethod('setExtraDataString', {
      'key': key,
      'value': value,
    });
  }

  // <summary>
  /// Add extra data to Appodeal.
  /// See <see cref="Appodeal.setExtraData"/> for resulting triggered event.
  /// <param name="key">associated with value.</param>
  /// <param name="value">value which will be saved in extra data by key.</param>
  /// </summary>
  static Future<void> setExtraDataInt(String key, int value) async {
    return _channel.invokeMethod('setExtraDataInt', {
      'key': key,
      'value': value,
    });
  }

  /// <summary>
  /// Add extra data to Appodeal.
  /// See <see cref="Appodeal.setExtraData"/> for resulting triggered event.
  /// <param name="key">associated with value.</param>
  /// <param name="value">value which will be saved in extra data by key.</param>
  /// </summary>
  static Future<void> setExtraDataDouble(String key, double value) async {
    return _channel.invokeMethod('setExtraDataDouble', {
      'key': key,
      'value': value,
    });
  }

  /// <summary>
  /// Add extra data to Appodeal.
  /// See <see cref="Appodeal.setExtraData"/> for resulting triggered event.
  /// <param name="key">associated with value.</param>
  /// <param name="value">value which will be saved in extra data by key.</param>
  /// </summary>
  static Future<void> setExtraDataBool(String key, bool value) async {
    return _channel.invokeMethod('setExtraDataBool', {
      'key': key,
      'value': value,
    });
  }

  /// <summary>
  /// Get native SDK version
  /// See <see cref="Appodeal.getNativeSDKVersion"/> for resulting triggered event.
  /// </summary>
  ///
  static Future<String> getNativeSDKVersion() async {
    return await _channel.invokeMethod('getNativeSDKVersion', {}) ?? "0";
  }

  /// <summary>
  /// Get Flutter plugin version
  /// See <see cref="Appodeal.getPluginVersion"/> for resulting triggered event.
  /// </summary>
  static String getAppodealFlutterPluginVersion() {
    return APPODEAL_FLUTTER_PLUGIN_VERSION;
  }

  /// <summary>
  /// Get predicted ecpm for certain ad type.
  /// See <see cref="Appodeal.getPredictedEcpm"/> for resulting triggered event.
  /// <param name="adType">adType type of advertising.</param>
  /// </summary>
  static Future<double> getPredictedEcpm(int adType) async {
    return await _channel.invokeMethod('getPredictedEcpm', {
      'adType': adType,
    }) ??
        0.0;
  }

  /// <summary>
  /// Set use safe area.
  /// See <see cref="Appodeal.setUseSafeArea"/> for resulting triggered event.
  /// </summary>
  ///
  static Future<void> setUseSafeArea(bool value) async {
    return _channel.invokeMethod('setUseSafeArea', {
      'value': value,
    });
  }

  static void _setCallbacks() {
    _channel.setMethodCallHandler((call) async {
      if (call.method.startsWith('onBannerLoaded')) {
        _onBannerLoaded?.call(call.method, call.arguments['height'], call.arguments['isPrecache']);
      } else if (call.method.startsWith('onBannerFailedToLoad')) {
        _onBannerFailedToLoad?.call(call.method);
      } else if (call.method.startsWith('onBannerShown')) {
        _onBannerShown?.call(call.method);
      } else if (call.method.startsWith('onBannerShowFailed')) {
        _onBannerShowFailed?.call(call.method);
      } else if (call.method.startsWith('onBannerClicked')) {
        _onBannerClicked?.call(call.method);
      } else if (call.method.startsWith('onBannerExpired')) {
        _onBannerExpired?.call(call.method);
      }




      else if (call.method.startsWith('onInterstitial')) {
        _interstitialCallback?.call(call.method);
      } else if (call.method.startsWith('onRewarded')) {
        _rewardCallback?.call(call.method);
      } else if (call.method.startsWith('onNonSkippable')) {
        _nonSkippableCallback?.call(call.method);
      }
    });
  }

  static void setBannerCallback(
      Function(String event, int bannerHeight, bool isPrecache) onBannerLoaded,
      Function(String event) onBannerFailedToLoad,
      Function(String event) onBannerShown,
      Function(String event) onBannerShowFailed,
      Function(String event) onBannerClicked,
      Function(String event) onBannerExpired,
      ) {
    _onBannerLoaded = onBannerLoaded;
    _onBannerFailedToLoad = onBannerFailedToLoad;
    _onBannerShown = onBannerShown;
    _onBannerShowFailed = onBannerShowFailed;
    _onBannerClicked = onBannerClicked;
    _onBannerExpired = onBannerExpired;
  }

  static void setInterstitialCallback(Function(String event) callback) {
    _interstitialCallback = callback;
  }

  static void setRewardCallback(Function(String event) callback) {
    _rewardCallback = callback;
  }

  static void setNonSkippableCallback(Function(String event) callback) {
    _nonSkippableCallback = callback;
  }
}