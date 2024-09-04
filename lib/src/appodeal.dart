import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

/// Appodeal SDK Flutter Plugin main class.
///
/// This class declares the public API for the Appodeal SDK Flutter Plugin.
///
class Appodeal {
  Appodeal._();

  /// Rectangular ads that appear at the top/right/bottom/left or view of the device screen.
  static const BANNER = AppodealAdType.Banner;
  static const BANNER_RIGHT = AppodealAdType.BannerRight;
  static const BANNER_TOP = AppodealAdType.BannerTop;
  static const BANNER_LEFT = AppodealAdType.BannerLeft;
  static const BANNER_BOTTOM = AppodealAdType.BannerBottom;

  /// Interstitial ads are full-screen ads that cover the interface of their host app.
  static const INTERSTITIAL = AppodealAdType.Interstitial;

  /// Ads that reward users for watching short videos and interacting with playable ads and surveys.
  static const REWARDED_VIDEO = AppodealAdType.RewardedVideo;

  /// Rectangular ads (with defined size 300x250 dp) that appear at the view of the device screen.
  static const MREC = AppodealAdType.MREC;

  /// Log level none for [setLogLevel] method.
  static const LogLevelNone = 0;

  /// Log level debug for [setLogLevel] method.
  static const LogLevelDebug = 1;

  /// Log level verbose for [setLogLevel] method.
  static const LogLevelVerbose = 2;

  static final _functions = Map<String, Function(MethodCall call)?>();

  // Handler for processing method calls.
  static final Future<dynamic> Function(MethodCall call) _handler =
      (call) async {
    _functions[call.method]?.call(call);
    _functions.remove(call.method);
  };

  static AppodealConsentForm? _ConsentForm;

  /// Appodeal Consent form logic for iAB TCFv2 and Google UMP.
  static AppodealConsentForm get ConsentForm =>
      _ConsentForm ??= AppodealConsentForm();

  static MethodChannel _channel = _defaultChannel(_handler);
  static const MethodChannel _adrevenueChannel =
      const MethodChannel('appodeal_flutter/adrevenue');
  static const MethodChannel _interstitialChannel =
      const MethodChannel('appodeal_flutter/interstitial');
  static const MethodChannel _rewardedVideoChannel =
      const MethodChannel('appodeal_flutter/rewarded');
  static const MethodChannel _bannerChannel =
      const MethodChannel('appodeal_flutter/banner');
  static const MethodChannel _mrecChannel =
      const MethodChannel('appodeal_flutter/mrec');

  // Set [isTestMode] for getting test advertising.
  static setTesting(bool isTestMode) {
    _channel.invokeMethod('setTestMode', {'isTestMode': isTestMode});
  }

  /// Check if test mode is enabled
  ///
  /// Returns `true` if test mode is enabled, otherwise `false`.
  static Future<bool> isTesting() async {
    return await _channel.invokeMethod('isTestMode');
  }

  /// Set [logLevel]
  ///
  /// Support log level: [LogLevelNone], [LogLevelDebug], [LogLevelVerbose]
  static setLogLevel(int logLevel) {
    _channel.invokeMethod('setLogLevel', {'logLevel': logLevel});
  }

  /// Initialize the Appodeal SDK
  ///
  /// Initialize the Appodeal SDK with the [appKey] and List [adTypes] of the advertising you want to initialize.
  /// To find out about the end of initialization, use the [onInitializationFinished] callback
  static initialize({
    required String appKey,
    required List<AppodealAdType> adTypes,
    Function(List<ApdInitializationError>? errors)? onInitializationFinished,
  }) {
    _functions["onInitializationFinished"] = (call) {
      final errors = call.arguments?['errors'] ?? <String>[];
      final error = List<ApdInitializationError>.from(
          errors.map((e) => ApdInitializationError._(e)));
      onInitializationFinished?.call(error);
    };
    _channel.invokeMethod('initialize', {
      'appKey': appKey,
      'sdkVersion': getSDKVersion(),
      'adTypes': adTypes.fold<int>(
          0, (previousValue, element) => previousValue | element.platformType),
    });
  }

  /// Checks if [adType] is initialized.
  ///
  /// Returns `true` if the ad type is initialized, otherwise `false`.
  static Future<bool> isInitialized(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isInitialized', {'adType': adType.platformType});
  }

  /// Sets [isAutoCache] for new ads when current ads were shown for [adType].
  static setAutoCache(AppodealAdType adType, bool isAutoCache) {
    _channel.invokeMethod('setAutoCache',
        {'adType': adType.platformType, 'isAutoCache': isAutoCache});
  }

  /// Checks if auto cache is enabled for [adType].
  ///
  /// Returns `true` if auto cache is enabled, otherwise `false`.
  static Future<bool> isAutoCacheEnabled(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isAutoCacheEnabled', {'adType': adType.platformType});
  }

  /// Starts caching ads for [adType].
  static cache(AppodealAdType adType) {
    _channel.invokeMethod('cache', {'adType': adType.platformType});
  }

  /// Checks if an ad is loaded for [adType].
  ///
  /// Returns `true` if ads are currently loaded and can be shown, otherwise `false`.
  static Future<bool> isLoaded(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isLoaded', {'adType': adType.platformShowType});
  }

  /// Checks if the loaded ad is a precache for [adType].
  ///
  /// Returns `true` if the currently loaded ads are precache, otherwise `false`.
  static Future<bool> isPrecache(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isPrecache', {'adType': adType.platformType});
  }

  /// Checks if an ad with a specific [adType] can be shown with [placement].
  ///
  /// Returns `true` if the ad can be shown with this placement, otherwise `false`.
  static Future<bool> canShow(AppodealAdType adType,
      [String placement = "default"]) async {
    return await _channel.invokeMethod(
        'canShow', {'adType': adType.platformType, 'placement': placement});
  }

  /// Gets predicted eCPM for a certain [adType].
  static Future<double> getPredictedEcpm(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('getPredictedEcpm', {'adType': adType.platformType});
  }

  /// Shows [adType] advertising with [placement].
  ///
  /// Returns `true` if the ad can be shown with this placement, otherwise `false`.
  static Future<bool> show(AppodealAdType adType,
      [String placement = "default"]) async {
    return await _channel.invokeMethod(
        'show', {'adType': adType.platformShowType, 'placement': placement});
  }

  /// Hides [adType] advertising.
  ///
  /// Supports only [AppodealAdType.Banner] and [AppodealAdType.MREC].
  static hide(AppodealAdType adType) {
    _channel.invokeMethod('hide', {'adType': adType.platformShowType});
  }

  /// Destroys [adType] advertising.
  ///
  /// Supports only [AppodealAdType.Banner] and [AppodealAdType.MREC].
  static destroy(AppodealAdType adType) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('destroy', {'adType': adType.platformType});
    }
  }

  /// Sets [isAdViewAutoResume] for the `Android` platform (default is `true`).
  ///
  /// If [isAdViewAutoResume] is `true`, the SDK will show AdView on all new activities without calling additional code from your side.
  /// If you want to control the display yourself, you can set [isAdViewAutoResume] to `false`.
  /// Supports only [AppodealAdType.Banner] and [AppodealAdType.MREC].
  static setAdViewAutoResume(bool isAdViewAutoResume) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('setAdViewAutoResume', {
        'isAdViewAutoResume': isAdViewAutoResume,
      });
    }
  }

  /// Checks if ad view auto resume is enabled for the `Android` platform (default is `true`).
  ///
  /// Returns `true` if ad view auto resume is enabled, otherwise `false`.
  static Future<bool> isAdViewAutoResume() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('isAdViewAutoResume');
    }
    return false;
  }

  /// Sets [isSmartBannersEnabled] (`false` by default).
  static setSmartBanners(bool isSmartBannersEnabled) {
    print('Smart banners are disabled for Flutter framework');
  }

  /// Checks if smart banners are enabled (`false` by default).
  ///
  /// Returns `true` if smart banners are enabled, otherwise `false`.
  static Future<bool> isSmartBanners() async {
    return await _channel.invokeMethod('isSmartBanners');
  }

  /// Sets [isTabletBannerEnabled] (`false` by default).
  static setTabletBanners(bool isTabletBannerEnabled) {
    _channel.invokeMethod('setTabletBanners', {
      'isTabletBannerEnabled': isTabletBannerEnabled,
    });
  }

  /// Checks if tablet banners are enabled (`false` by default).
  ///
  /// Returns `true` if tablet banners are enabled, otherwise `false`.
  static Future<bool> isTabletBanners() async {
    return await _channel.invokeMethod('isTabletBanners');
  }

  /// Sets [isBannerAnimationEnabled] (`true` by default).
  static setBannerAnimation(bool isBannerAnimationEnabled) {
    _channel.invokeMethod('setBannerAnimation', {
      'isBannerAnimationEnabled': isBannerAnimationEnabled,
    });
  }

  /// Checks if banner animation is enabled (`false` by default).
  ///
  /// Returns `true` if banner animation is enabled, otherwise `false`.
  static Future<bool> isBannerAnimation() async {
    return await _channel.invokeMethod('isBannerAnimation');
  }

  /// Sets banners inverse rotation (by default: left = 90, right = -90).
  ///
  /// [leftBannerRotation] rotation for [AppodealAdType.BannerLeft], [AppodealAdType.BannerRight]
  static setBannerRotation(int leftBannerRotation, int rightBannerRotation) {
    _channel.invokeMethod('setBannerRotation', {
      'leftBannerRotation': leftBannerRotation,
      'rightBannerRotation': rightBannerRotation,
    });
  }

  /// Disables specified [network] for [adType].
  static disableNetwork(String network,
      [AppodealAdType adType = AppodealAdType.All]) {
    _channel.invokeMethod('disableNetwork', {
      'network': network,
      'adType': adType.platformType,
    });
  }

  /// Mutes video if [isMuteVideosIfCallsMuted] is `true` for `Android` platform (`false` by default).
  static muteVideosIfCallsMuted(bool isMuteVideosIfCallsMuted) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('muteVideosIfCallsMuted',
          {'isMuteVideosIfCallsMuted': isMuteVideosIfCallsMuted});
    }
  }

  /// Checks if muting videos when calls are muted is enabled for `Android` platform (`false` by default).
  ///
  /// Returns `true` if muting videos when calls are muted, otherwise `false`.
  static Future<bool> isMuteVideosIfCallsMuted() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('isMuteVideosIfCallsMuted');
    }
    return false;
  }

  /// Disables data collection for kids' apps.
  ///
  /// If [isChildDirectedTreatment] is `true`, it disables data collection for kids' apps.
  static setChildDirectedTreatment(bool isChildDirectedTreatment) {
    _channel.invokeMethod('setChildDirectedTreatment',
        {'isChildDirectedTreatment': isChildDirectedTreatment});
  }

  /// Checks if data collection for kids' apps is disabled (`false` by default).
  ///
  /// Returns `true` if data collection for kids' apps is disabled, otherwise `false`.
  static Future<bool> isChildDirectedTreatment() async {
    return await _channel.invokeMethod('isChildDirectedTreatment');
  }

  /// Sets use safe area [isUseSafeArea] for `Android` platform (`false` by default).
  ///
  /// Appodeal SDK will consider safe area when an ad is shown.
  /// Support only for [AppodealAdType.Banner] and [AppodealAdType.MREC]
  static setUseSafeArea(bool isUseSafeArea) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('setUseSafeArea', {'isUseSafeArea': isUseSafeArea});
    }
  }

  /// Checks if using safe area is enabled for `Android` platform (`false` by default).
  ///
  /// Returns `true` if using safe area is enabled, otherwise `false`.
  static Future<bool> isUseSafeArea() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('isUseSafeArea');
    }
    return false;
  }

  /// Sets [userId].
  static setUserId(String userId) {
    _channel.invokeMethod('setUserId', {'userId': userId});
  }

  /// Gets user Id.
  static Future<String?> getUserId() async {
    return await _channel.invokeMethod('getUserId');
  }

  /// Sets custom segment filter [name] to [value].
  static setCustomFilter(String name, dynamic value) {
    _channel.invokeMethod('setCustomFilter', {'name': name, 'value': value});
  }

  /// Sets custom extra data [key] to [value].
  static setExtraData(String key, dynamic value) {
    _channel.invokeMethod('setExtraData', {'key': key, 'value': value});
  }

  /// Gets SDK version.
  static String getSDKVersion() {
    return "3.3.2";
  }

  /// Gets SDK platform version.
  static Future<String> getPlatformSdkVersion() async {
    return await _channel.invokeMethod('getPlatformSdkVersion');
  }

  /// Logs an event with [eventName] and [params] in all connected services.
  static logEvent(String eventName, Map<String, dynamic> params) {
    _channel
        .invokeMethod('logEvent', {"eventName": eventName, "params": params});
  }

  /// Validates in-app [purchase] in one of the connected attribution services.
  static validateInAppPurchase({
    required AppodealPurchase purchase,
    Function(AppodealPurchase purchase, List<ApdValidationError>? errors)?
        onInAppPurchaseValidateSuccess,
    Function(AppodealPurchase purchase, List<ApdValidationError>? errors)?
        onInAppPurchaseValidateFail,
  }) {
    _functions["onInAppPurchaseValidateSuccess"] = (call) {
      final error = List<String>.from(call.arguments['errors'])
          .map((e) => ApdValidationError._(e))
          .toList();
      onInAppPurchaseValidateSuccess?.call(purchase, error);
    };
    _functions["onInAppPurchaseValidateFail"] = (call) {
      final error = List<String>.from(call.arguments['errors'])
          .map((e) => ApdValidationError._(e))
          .toList();
      onInAppPurchaseValidateFail?.call(purchase, error);
    };
    _channel.invokeMethod('validateInAppPurchase', purchase.toMap);
  }

  /// Sets Interstitial ads callbacks.
  ///
  /// [onInterstitialLoaded] Called when interstitial was loaded, `isPrecache` - `true` if interstitial is precache.
  /// [onInterstitialFailedToLoad] Called when interstitial fails to load. But if auto cache is enabled for interstitials, loading will be continued.
  /// [onInterstitialShown] Called when interstitial was shown.
  /// [onInterstitialShowFailed] Called when interstitial show fails.
  /// [onInterstitialClicked] Called when interstitial was clicked.
  /// [onInterstitialClosed] Called when interstitial was closed.
  /// [onInterstitialExpired] Called when interstitial was expired by time.
  static void setInterstitialCallbacks({
    Function(bool isPrecache)? onInterstitialLoaded,
    Function? onInterstitialFailedToLoad,
    Function? onInterstitialShown,
    Function? onInterstitialShowFailed,
    Function? onInterstitialClicked,
    Function? onInterstitialClosed,
    Function? onInterstitialExpired,
  }) {
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

  /// Sets Rewarded video ads callbacks.
  ///
  /// [onRewardedVideoLoaded] Called when rewarded video was loaded, `isPrecache` - `true` if rewarded video is precache.
  /// [onRewardedVideoFailedToLoad] Called when rewarded video fails to load. But if auto cache is enabled for rewarded videos, loading will be continued.
  /// [onRewardedVideoShown] Called when rewarded video was shown.
  /// [onRewardedVideoShowFailed] Called when rewarded video show fails.
  /// [onRewardedVideoClicked] Called when rewarded video was clicked.
  /// [onRewardedVideoFinished] Called when rewarded video was finished with the amount of reward and name of currency.
  /// [onRewardedVideoClosed] Called when rewarded video was closed, isFinished - `true` if video was finished.
  /// [onRewardedVideoExpired] Called when rewarded video was expired by time.
  static void setRewardedVideoCallbacks({
    Function(bool isPrecache)? onRewardedVideoLoaded,
    Function? onRewardedVideoFailedToLoad,
    Function? onRewardedVideoShown,
    Function? onRewardedVideoShowFailed,
    Function? onRewardedVideoClicked,
    Function(double amount, String reward)? onRewardedVideoFinished,
    Function(bool isFinished)? onRewardedVideoClosed,
    Function? onRewardedVideoExpired,
  }) {
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

  /// Sets Banner ads callbacks.
  ///
  /// [onBannerLoaded] Called when banner was loaded, `isPrecache` - `true` if banner is precache.
  /// [onBannerFailedToLoad] Called when banner fails to load. But if auto cache is enabled for banners, loading will be continued.
  /// [onBannerShown] Called when banner was shown.
  /// [onBannerShowFailed] Called when banner show fails.
  /// [onBannerClicked] Called when banner was clicked.
  /// [onBannerExpired] Called when banner was expired by time.
  static void setBannerCallbacks({
    Function(bool isPrecache)? onBannerLoaded,
    Function? onBannerFailedToLoad,
    Function? onBannerShown,
    Function? onBannerShowFailed,
    Function? onBannerClicked,
    Function? onBannerExpired,
  }) {
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

  /// Sets MREC ads callbacks.
  ///
  /// [onMrecLoaded] Called when MREC was loaded, `isPrecache` - `true` if MREC is precache.
  /// [onMrecFailedToLoad] Called when MREC fails to load. But if auto cache is enabled for MRECs, loading will be continued.
  /// [onMrecShown]Called when MREC was shown.
  /// [onMrecShowFailed] Called when MREC show fails.
  /// [onMrecClicked] Called when MREC was clicked.
  /// [onMrecExpired] Called when MREC was expired by time.
  static void setMrecCallbacks({
    Function(bool isPrecache)? onMrecLoaded,
    Function? onMrecFailedToLoad,
    Function? onMrecShown,
    Function? onMrecShowFailed,
    Function? onMrecClicked,
    Function? onMrecExpired,
  }) {
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

  /// Set ad revenue callbacks.
  ///
  /// [onAdRevenueReceive] Called every time when SDK receives a revenue information for an ad.
  static void setAdRevenueCallbacks({
    Function(AppodealAdRevenue adRevenue)? onAdRevenueReceive,
  }) {
    _adrevenueChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onAdRevenueReceive':
          onAdRevenueReceive?.call(AppodealAdRevenue.fromArgs(call.arguments));
          break;
      }
    });
  }
}

MethodChannel _defaultChannel(final Future Function(MethodCall call) handler) {
  const channel = MethodChannel('appodeal_flutter');
  channel.setMethodCallHandler(handler);
  return channel;
}

/// Appodeal SDK Initialization Error class.
///
/// This class declares errors during initialization.
///
class ApdInitializationError {
  final String description;

  ApdInitializationError._(this.description);
}

/// Appodeal SDK In-App Validation Error class.
///
/// This class declares errors during in-app validation.
///
class ApdValidationError {
  final String description;

  ApdValidationError._(this.description);
}
