import 'dart:async';
import 'dart:io';

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
  static const MREC = 9;
  static const ALL = 10;

  static const LogLevelNone = 0;
  static const LogLevelDebug = 1;
  static const LogLevelVerbose = 2;

  static const GENDER_OTHER = 0;
  static const GENDER_MALE = 1;
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

  static Future<void> initialize(String appKey,
                                 List<int> adTypes,
                                 {bool? boolConsent}) async {
    return _channel.invokeMethod('initialize', {
      'appKey': appKey,
      'adTypes': adTypes,
      'boolConsent': boolConsent,
    });
  }

  static Future<void> updateConsent(bool? boolConsent) async {
    return _channel.invokeMethod('updateConsent', {'boolConsent': boolConsent});
  }

  static Future<bool> isInitialized(int adType) async {
    return await _channel.invokeMethod('isInitialized', {'adType': adType})
        ?? false;
  }

  static Future<void> setAutoCache(int adType, bool autoCache) async {
    return await _channel.invokeMethod(
        'setAutoCache', {'adType': adType, 'autoCache': autoCache});
  }

  static Future<bool> isAutoCacheEnabled(int adType) async {
    return await _channel.invokeMethod('isAutoCacheEnabled', {'adType': adType})
        ?? false;
  }

  static Future<void> cache(int adType) async {
    return _channel.invokeMethod('cache', {'adType': adType});
  }

  static Future<bool> isLoaded(int adType) async {
    return await _channel.invokeMethod('isLoaded', {'adType': adType}) ?? false;
  }

  static Future<bool> isPrecache(int adType) async {
    return await _channel.invokeMethod('isPrecache', {'adType': adType})
        ?? false;
  }

  static Future<bool> canShow(int adType, [String placement = "default"]) async {
    return await _channel.invokeMethod(
            'canShow', {'adType': adType, 'placement': placement})
        ?? false;
  }

  static Future<double> getPredictedEcpm(int adType) async {
    return await _channel.invokeMethod('getPredictedEcpm', {'adType': adType})
        ?? 0.0;
  }

  static Future<bool> show(int adType, [String placement = "default"]) async {
    return await _channel.invokeMethod(
        'show', {'adType': adType, 'placement': placement})
        ?? false;
  }

  static Future<void> hide(int adType) async {
    return _channel.invokeMethod('hide', {'adType': adType});
  }

  static Future<void> destroy(int adType) async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod('destroy', {'adType': adType});
    }
  }

  static Future<void> setTriggerOnLoadedOnPrecache(
      int adType, bool onLoadedTriggerBoth) async {
    return _channel.invokeMethod('setTriggerOnLoadedOnPrecache', {
      'adType': adType,
      'onLoadedTriggerBoth': onLoadedTriggerBoth,
    });
  }

  static Future<void> setSharedAdsInstanceAcrossActivities(
      bool sharedAdsInstanceAcrossActivities) async {
    if (Platform.isAndroid) {
      _channel.invokeMethod('setSharedAdsInstanceAcrossActivities', {
        'sharedAdsInstanceAcrossActivities': sharedAdsInstanceAcrossActivities,
      });
    }
  }

  static Future<void> setSmartBanners(bool smartBannerEnabled) async {
    return _channel.invokeMethod('setSmartBanners', {
      'smartBannerEnabled': smartBannerEnabled,
    });
  }

  static Future<void> setTabletBanners(bool tabletBannerEnabled) async {
    return _channel.invokeMethod('setTabletBanners', {
      'tabletBannerEnabled': tabletBannerEnabled,
    });
  }

  static Future<void> setBannerAnimation(bool bannerAnimationEnabled) async {
    return _channel.invokeMethod('setBannerAnimation', {
      'bannerAnimationEnabled': bannerAnimationEnabled,
    });
  }

  static Future<void> setBannerRotation(
      int leftBannerRotation, int rightBannerRotation) async {
    return _channel.invokeMethod('setBannerRotation', {
      'leftBannerRotation': leftBannerRotation,
      'rightBannerRotation': rightBannerRotation,
    });
  }

  static Future<void> trackInAppPurchase(double amount, String currency) async {
    return _channel.invokeMethod('trackInAppPurchase', {
      'amount': amount,
      'currency': currency,
    });
  }

  static Future<void> disableNetwork(String network,
                                     [int adType = Appodeal.ALL]) async {
    return _channel.invokeMethod('disableNetwork', {
      'network': network,
      'adType': adType,
    });
  }

  static Future<void> setUserId(String userId) async {
    return _channel.invokeMethod('setUserId', {
      'userId': userId,
    });
  }

  static Future<void> setUserAge(int age) async {
    return _channel.invokeMethod('setUserAge', {'age': age});
  }

  static Future<void> setUserGender(int gender) async {
    return _channel.invokeMethod('setUserGender', {'gender': gender});
  }

  static Future<void> setTesting(bool testMode) async {
    return _channel.invokeMethod('setTesting', {'testMode': testMode});
  }

  static Future<void> setLogLevel(int logLevel) async {
    return _channel.invokeMethod('setLogLevel', {'logLevel': logLevel});
  }

  static Future<void> muteVideosIfCallsMuted(bool value) async {
    if (Platform.isAndroid) {
      _channel.invokeMethod('muteVideosIfCallsMuted', {'value': value});
    }
  }

  static Future<void> setChildDirectedTreatment(bool value) async {
    return _channel.invokeMethod('setChildDirectedTreatment', {'value': value});
  }

  static Future<void> setCustomFilter(String name, dynamic value) async {
    return _channel
        .invokeMethod('setCustomFilter', {'name': name, 'value': value});
  }

  static Future<void> setExtraData(String key, dynamic value) async {
    return _channel.invokeMethod('setExtraData', {'key': key, 'value': value});
  }

  static Future<String> getNativeSDKVersion() async {
    return await _channel.invokeMethod('getNativeSDKVersion', {}) ?? "0";
  }

  static Future<void> setUseSafeArea(bool value) async {
    if (Platform.isAndroid) {
      return _channel.invokeMethod('setUseSafeArea', {'value': value});
    }
  }

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
