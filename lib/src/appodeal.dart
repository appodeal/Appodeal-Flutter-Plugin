import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stack_appodeal_flutter/src/consent_manager.dart';

/// Appodeal SDK Flutter Plugin main class.
///
/// This class declares a public API Appodeal SDK Flutter Plugin
///
class Appodeal {
  /// Rectangular ads that appear at the top/right/bottom/left or view of the device screen.
  static const BANNER = 1;
  static const BANNER_RIGHT = 2;
  static const BANNER_TOP = 3;
  static const BANNER_LEFT = 4;
  static const BANNER_BOTTOM = 5;

  /// Native ads are ad assets that are presented to users via UI components that are native to the platform.
  static const NATIVE = 6;

  /// Interstitial ads are full-screen ads that cover the interface of their host app.
  static const INTERSTITIAL = 7;

  /// Ads that reward users for watching short videos and interacting with playable ads and surveys.
  static const REWARDED_VIDEO = 8;

  /// Rectangular ads (with defined size 300x250 dp) that appear at the view of the device screen.
  static const MREC = 9;

  /// All types of advertising.
  static const ALL = 10;

  /// Log level none for [setLogLevel] method.
  static const LogLevelNone = 0;

  /// Log level debug for [setLogLevel] method.
  static const LogLevelDebug = 1;

  /// Log level verbose for [setLogLevel] method.
  static const LogLevelVerbose = 2;

  /// Gender other for [setUserGender] method.
  static const GENDER_OTHER = 0;

  /// Gender male for [setUserGender] method.
  static const GENDER_MALE = 1;

  /// Gender female for [setUserGender] method.
  static const GENDER_FEMALE = 2;

  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');
  static const MethodChannel _interstitialChannel =
      const MethodChannel('appodeal_flutter/interstitial');
  static const MethodChannel _rewardedVideoChannel =
      const MethodChannel('appodeal_flutter/rewarded');
  static const MethodChannel _bannerChannel =
      const MethodChannel('appodeal_flutter/banner');
  static const MethodChannel _mrecChannel =
      const MethodChannel('appodeal_flutter/mrec');

  /// Initialize the Appodeal SDK
  ///
  /// Initialize the Appodeal SDK with the [appKey] and List [adTypes] of the advertising you want to initialize.
  /// If you use [ConsentManager] you may not provide [boolConsent],
  /// otherwise provide if user has given or reject consent to the processing of personal data relating to him or her.
  static Future<void> initialize(String appKey,
                                 List<int> adTypes,
                                 {bool? boolConsent}) async {
    return _channel.invokeMethod('initialize', {
      'appKey': appKey,
      'adTypes': adTypes,
      'boolConsent': boolConsent,
    });
  }

  /// Update user [boolConsent] value for Appodeal SDK and Ad networks
  ///
  /// If you use [ConsentManager] you may not provide [boolConsent],
  /// otherwise provide if user has given or reject consent to the processing of personal data relating to him or her.
  static Future<void> updateConsent(bool? boolConsent) async {
    return _channel.invokeMethod('updateConsent', {'boolConsent': boolConsent});
  }

  /// Check if [adType] is initialized
  ///
  /// Returns `true` if ad type is initialized, otherwise `false`.
  static Future<bool> isInitialized(int adType) async {
    return await _channel.invokeMethod('isInitialized', {'adType': adType})
        ?? false;
  }

  /// Set [autoCache] new ads when current ads was shown for [adType].
  static Future<void> setAutoCache(int adType, bool autoCache) async {
    return await _channel.invokeMethod(
        'setAutoCache', {'adType': adType, 'autoCache': autoCache});
  }

  /// Check if auto cache enabled for [adType]
  ///
  /// Returns `true` if auto cache enabled, otherwise `false`.
  static Future<bool> isAutoCacheEnabled(int adType) async {
    return await _channel.invokeMethod('isAutoCacheEnabled', {'adType': adType})
        ?? false;
  }

  /// Start caching ads for [adType]
  static Future<void> cache(int adType) async {
    return _channel.invokeMethod('cache', {'adType': adType});
  }

  /// Check if ad is loaded. for [adType]
  ///
  /// Returns `true` if ads currently loaded and can be shown, otherwise `false`.
  static Future<bool> isLoaded(int adType) async {
    return await _channel.invokeMethod('isLoaded', {'adType': adType}) ?? false;
  }

  /// Check if loaded ad is precache for [adType]
  ///
  /// Returns `true` if currently loaded ads is precache, otherwise `false`.
  static Future<bool> isPrecache(int adType) async {
    return await _channel.invokeMethod('isPrecache', {'adType': adType})
        ?? false;
  }

  /// Check if ad with specific [adType] can be shown with [placement]
  ///
  /// Returns `true` if ad can be shown with this placement, otherwise `false`.
  static Future<bool> canShow(int adType, [String placement = "default"]) async {
    return await _channel.invokeMethod(
            'canShow', {'adType': adType, 'placement': placement})
        ?? false;
  }

  /// Get predicted ecpm for certain [adType]
  static Future<double> getPredictedEcpm(int adType) async {
    return await _channel.invokeMethod('getPredictedEcpm', {'adType': adType})
        ?? 0.0;
  }

  /// Show [adType] advertising with [placement]
  ///
  /// Returns `true` if ad can be shown with this placement, otherwise `false`.
  static Future<bool> show(int adType, [String placement = "default"]) async {
    return await _channel.invokeMethod(
        'show', {'adType': adType, 'placement': placement})
        ?? false;
  }

  /// Hide [adType] advertising
  ///
  /// Support only [BANNER] and [MREC]
  static Future<void> hide(int adType) async {
    return _channel.invokeMethod('hide', {'adType': adType});
  }

  /// Destroy [adType] advertising
  ///
  /// Support only [BANNER] and [MREC]
  static Future<void> destroy(int adType) async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod('destroy', {'adType': adType});
    }
  }

  /// Set triggering onLoaded callback when precache loaded for [adType]
  ///
  /// if [onLoadedTriggerBoth] `true` that onLoaded will trigger when precache or normal ad were loaded,
  /// otherwise `false` that onLoaded will trigger only when normal ad was loaded (default).
  static Future<void> setTriggerOnLoadedOnPrecache(int adType,
                                                   bool onLoadedTriggerBoth) async {
    return _channel.invokeMethod('setTriggerOnLoadedOnPrecache', {
      'adType': adType,
      'onLoadedTriggerBoth': onLoadedTriggerBoth,
    });
  }

  /// Set [sharedAdsInstanceAcrossActivities] for `Android` platform (`true` by default).
  ///
  /// If [sharedAdsInstanceAcrossActivities] `true` that the SDK will show AdView on all new activities without calling additional code from your side.
  /// If you want to control the display yourself, you can set [sharedAdsInstanceAcrossActivities] as `false` parameter.
  /// Support only for [BANNER] and [MREC]
  static Future<void> setSharedAdsInstanceAcrossActivities(
      bool sharedAdsInstanceAcrossActivities) async {
    if (Platform.isAndroid) {
      _channel.invokeMethod('setSharedAdsInstanceAcrossActivities', {
        'sharedAdsInstanceAcrossActivities': sharedAdsInstanceAcrossActivities,
      });
    }
  }

  /// Set [smartBannerEnabled] (`true` by default).
  static Future<void> setSmartBanners(bool smartBannerEnabled) async {
    return _channel.invokeMethod('setSmartBanners', {
      'smartBannerEnabled': smartBannerEnabled,
    });
  }

  /// Set [tabletBannerEnabled] (`false` by default).
  static Future<void> setTabletBanners(bool tabletBannerEnabled) async {
    return _channel.invokeMethod('setTabletBanners', {
      'tabletBannerEnabled': tabletBannerEnabled,
    });
  }

  /// Set [bannerAnimationEnabled] (`true` by default).
  static Future<void> setBannerAnimation(bool bannerAnimationEnabled) async {
    return _channel.invokeMethod('setBannerAnimation', {
      'bannerAnimationEnabled': bannerAnimationEnabled,
    });
  }

  /// Setting banners inverse rotation (by default: left = 90, right = -90).
  ///
  /// [leftBannerRotation] rotation for [BANNER_LEFT], [BANNER_RIGHT]
  static Future<void> setBannerRotation(int leftBannerRotation,
                                        int rightBannerRotation) async {
    return _channel.invokeMethod('setBannerRotation', {
      'leftBannerRotation': leftBannerRotation,
      'rightBannerRotation': rightBannerRotation,
    });
  }

  /// Tracks in-app purchase information ([amount] and [currency]) and sends info to our servers for analytics
  static Future<void> trackInAppPurchase(double amount, String currency) async {
    return _channel.invokeMethod('trackInAppPurchase', {
      'amount': amount,
      'currency': currency,
    });
  }

  /// Disabling specified [network] for [adType]
  static Future<void> disableNetwork(String network,
                                     [int adType = Appodeal.ALL]) async {
    return _channel.invokeMethod('disableNetwork', {
      'network': network,
      'adType': adType,
    });
  }

  /// Set [userId]
  static Future<void> setUserId(String userId) async {
    return _channel.invokeMethod('setUserId', {
      'userId': userId,
    });
  }

  /// Set [age]
  static Future<void> setUserAge(int age) async {
    return _channel.invokeMethod('setUserAge', {'age': age});
  }

  /// Set [gender]
  ///
  /// support genders: [GENDER_OTHER], [GENDER_MALE], [GENDER_FEMALE]
  static Future<void> setUserGender(int gender) async {
    return _channel.invokeMethod('setUserGender', {'gender': gender});
  }

  /// Set [testMode]
  static Future<void> setTesting(bool testMode) async {
    return _channel.invokeMethod('setTesting', {'testMode': testMode});
  }

  /// Set [logLevel]
  ///
  /// support log level: [LogLevelNone], [LogLevelDebug], [LogLevelVerbose]
  static Future<void> setLogLevel(int logLevel) async {
    return _channel.invokeMethod('setLogLevel', {'logLevel': logLevel});
  }

  /// Mute video if `true` for `Android` platform (`false` by default).
  static Future<void> muteVideosIfCallsMuted(bool value) async {
    if (Platform.isAndroid) {
      _channel.invokeMethod('muteVideosIfCallsMuted', {'value': value});
    }
  }

  /// Disables data collection for kids apps
  ///
  /// If [value] `true` that to disable data collection for kids apps
  static Future<void> setChildDirectedTreatment(bool value) async {
    return _channel.invokeMethod('setChildDirectedTreatment', {'value': value});
  }

  /// Set custom segment filter [name] to [value]
  static Future<void> setCustomFilter(String name, dynamic value) async {
    return _channel
        .invokeMethod('setCustomFilter', {'name': name, 'value': value});
  }

  /// Set custom extara data [name] to [value]
  static Future<void> setExtraData(String key, dynamic value) async {
    return _channel.invokeMethod('setExtraData', {'key': key, 'value': value});
  }

  /// Get SDK platform version.
  static Future<String> getNativeSDKVersion() async {
    return await _channel.invokeMethod('getNativeSDKVersion', {}) ?? "0";
  }

  /// Set use safe area [value] for `Android` platform (`false` by default).
  ///
  /// Appodeal SDK will consider safe area when ad shown
  /// Support only for [BANNER] and [MREC]
  static Future<void> setUseSafeArea(bool value) async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod('setUseSafeArea', {'value': value});
    }
  }

  /// Set Interstitial ads callbacks
  ///
  /// [onInterstitialLoaded] Called when interstitial was loaded, `isPrecache` - `true` if interstitial is precache.
  /// [onInterstitialFailedToLoad] Called when interstitial is fail to load. But if auto cache enabled for interstitials, loading will be continued.
  /// [onInterstitialShown] Called when interstitial was shown.
  /// [onInterstitialShowFailed] Called when interstitial show failed.
  /// [onInterstitialClicked] Called when interstitial was clicked.
  /// [onInterstitialClosed] Called when interstitial was closed.
  /// [onInterstitialExpired] Called when interstitial was expired by time.
  static void setInterstitialCallbacks(
      {Function(bool isPrecache)? onInterstitialLoaded,
      Function? onInterstitialFailedToLoad,
      Function? onInterstitialShown,
      Function? onInterstitialShowFailed,
      Function? onInterstitialClicked,
      Function? onInterstitialClosed,
      Function? onInterstitialExpired}) {
    _interstitialChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onInterstitialLoaded':
          onInterstitialLoaded?.call(call.arguments['isPrecache']);
          break;
        case 'onInterstitialFailedToLoad':
          onInterstitialFailedToLoad?.call();
          break;
        case 'onInterstitialShown':
          onInterstitialShown?.call();
          break;
        case 'onInterstitialShowFailed':
          onInterstitialShowFailed?.call();
          break;
        case 'onInterstitialClicked':
          onInterstitialClicked?.call();
          break;
        case 'onInterstitialClosed':
          onInterstitialClosed?.call();
          break;
        case 'onInterstitialExpired':
          onInterstitialExpired?.call();
          break;
      }
    });
  }

  /// Set Rewarded video ads callbacks
  ///
  /// [onRewardedVideoLoaded] Called when rewarded video was loaded, `isPrecache` - `true` if rewarded video is precache.
  /// [onRewardedVideoFailedToLoad] Called when rewarded video is fail to load. But if auto cache enabled for rewarded videos, loading will be continued.
  /// [onRewardedVideoShown] Called when rewarded video was shown.
  /// [onRewardedVideoShowFailed] Called when rewarded video show failed.
  /// [onRewardedVideoClicked] Called when rewarded video was clicked.
  /// [onRewardedVideoFinished] Called when rewarded video was finished with amount of reward and name of currency.
  /// [onRewardedVideoClosed] Called when rewarded video was closed, isFinished - `true` if video was finished
  /// [onRewardedVideoExpired] Called when rewarded video was expired by time.
  static void setRewardedVideoCallbacks(
      {Function(bool isPrecache)? onRewardedVideoLoaded,
      Function? onRewardedVideoFailedToLoad,
      Function? onRewardedVideoShown,
      Function? onRewardedVideoShowFailed,
      Function? onRewardedVideoClicked,
      Function(double amount, String reward)? onRewardedVideoFinished,
      Function(bool isFinished)? onRewardedVideoClosed,
      Function? onRewardedVideoExpired}) {
    _rewardedVideoChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onRewardedVideoLoaded':
          onRewardedVideoLoaded?.call(call.arguments['isPrecache']);
          break;
        case 'onRewardedVideoFailedToLoad':
          onRewardedVideoFailedToLoad?.call();
          break;
        case 'onRewardedVideoShown':
          onRewardedVideoShown?.call();
          break;
        case 'onRewardedVideoShowFailed':
          onRewardedVideoShowFailed?.call();
          break;
        case 'onRewardedVideoClicked':
          onRewardedVideoClicked?.call();
          break;
        case 'onRewardedVideoFinished':
          onRewardedVideoFinished?.call(
              call.arguments['amount'], call.arguments['reward']);
          break;
        case 'onRewardedVideoClosed':
          onRewardedVideoClosed?.call(call.arguments['isFinished']);
          break;
        case 'onRewardedVideoExpired':
          onRewardedVideoExpired?.call();
          break;
      }
    });
  }

  /// Set Banner ads callbacks
  ///
  /// [onBannerLoaded] Called when banner was loaded, `isPrecache` - `true` if banner is precache.
  /// [onBannerFailedToLoad] Called when banner is fail to load. But if auto cache enabled for banners, loading will be continued.
  /// [onBannerShown] Called when banner was shown.
  /// [onBannerShowFailed] Called when banner show failed.
  /// [onBannerClicked] Called when banner was clicked.
  /// [onBannerExpired] Called when banner was expired by time.
  static void setBannerCallbacks(
      {Function(bool isPrecache)? onBannerLoaded,
      Function? onBannerFailedToLoad,
      Function? onBannerShown,
      Function? onBannerShowFailed,
      Function? onBannerClicked,
      Function? onBannerExpired}) {
    _bannerChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onBannerLoaded':
          onBannerLoaded?.call(call.arguments['isPrecache']);
          break;
        case 'onBannerFailedToLoad':
          onBannerFailedToLoad?.call();
          break;
        case 'onBannerShown':
          onBannerShown?.call();
          break;
        case 'onBannerShowFailed':
          onBannerShowFailed?.call();
          break;
        case 'onBannerClicked':
          onBannerClicked?.call();
          break;
        case 'onBannerExpired':
          onBannerExpired?.call();
          break;
      }
    });
  }

  /// Set MREC ads callbacks
  ///
  /// [onMrecLoaded] Called when MREC was loaded, `isPrecache` - `true` if MREC is precache.
  /// [onMrecFailedToLoad] Called when MREC is fail to load. But if auto cache enabled for MRECs, loading will be continued.
  /// [onMrecShown]Called when MREC was shown.
  /// [onMrecShowFailed] Called when MREC show failed.
  /// [onMrecClicked] Called when MREC was clicked.
  /// [onMrecExpired] Called when MREC was expired by time.
  static void setMrecCallbacks(
      {Function(bool isPrecache)? onMrecLoaded,
      Function? onMrecFailedToLoad,
      Function? onMrecShown,
      Function? onMrecShowFailed,
      Function? onMrecClicked,
      Function? onMrecExpired}) {
    _mrecChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onMrecLoaded':
          onMrecLoaded?.call(call.arguments['isPrecache']);
          break;
        case 'onMrecFailedToLoad':
          onMrecFailedToLoad?.call();
          break;
        case 'onMrecShown':
          onMrecShown?.call();
          break;
        case 'onMrecShowFailed':
          onMrecShowFailed?.call();
          break;
        case 'onMrecClicked':
          onMrecClicked?.call();
          break;
        case 'onMrecExpired':
          onMrecExpired?.call();
          break;
      }
    });
  }
}
