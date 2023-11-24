import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

/// Appodeal SDK Flutter Plugin main class.
///
/// This class declares a public API Appodeal SDK Flutter Plugin
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
  static final Future<dynamic> Function(MethodCall call) _handler =
      (call) async {
    _functions[call.method]?.call(call);
    _functions.remove(call.method);
  };

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

  /// Set [isTestMode] for get test advertising.
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
  /// support log level: [LogLevelNone], [LogLevelDebug], [LogLevelVerbose]
  static setLogLevel(int logLevel) {
    _channel.invokeMethod('setLogLevel', {'logLevel': logLevel});
  }

  /// Update user consent for GDPR region [gdprUserConsent]
  ///
  /// support consents: [GDPRUserConsent.Personalized], [GDPRUserConsent.Unknown], [GDPRUserConsent.NonPersonalized]
  static updateGDPRUserConsent(GDPRUserConsent gdprUserConsent) {
    _channel.invokeMethod(
        'updateGDPRUserConsent', {'gdprUserConsent': gdprUserConsent.rawValue});
  }

  /// Update user consent for CCPA region [ccpaUserConsent]
  ///
  /// support consents: [CCPAUserConsent.OptIn], [CCPAUserConsent.Unknown], [CCPAUserConsent.OptOut]
  static updateCCPAUserConsent(CCPAUserConsent ccpaUserConsent) {
    _channel.invokeMethod(
        'updateCCPAUserConsent', {'ccpaUserConsent': ccpaUserConsent.rawValue});
  }

  /// Initialize the Appodeal SDK
  ///
  /// Initialize the Appodeal SDK with the [appKey] and List [adTypes] of the advertising you want to initialize.
  /// To find out about the end of initialization, use the [onInitializationFinished] callback
  static initialize(
      {required String appKey,
      required List<AppodealAdType> adTypes,
      Function(List<ApdInitializationError>? errors)?
          onInitializationFinished}) {
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

  /// Check if [adType] is initialized
  ///
  /// Returns `true` if ad type is initialized, otherwise `false`.
  static Future<bool> isInitialized(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isInitialized', {'adType': adType.platformType});
  }

  /// Set [isAutoCache] new ads when current ads was shown for [adType].
  static setAutoCache(AppodealAdType adType, bool isAutoCache) {
    _channel.invokeMethod('setAutoCache',
        {'adType': adType.platformType, 'isAutoCache': isAutoCache});
  }

  /// Check if auto cache enabled for [adType]
  ///
  /// Returns `true` if auto cache enabled, otherwise `false`.
  static Future<bool> isAutoCacheEnabled(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isAutoCacheEnabled', {'adType': adType.platformType});
  }

  /// Start caching ads for [adType]
  static cache(AppodealAdType adType) {
    _channel.invokeMethod('cache', {'adType': adType.platformType});
  }

  /// Check if ad is loaded. for [adType]
  ///
  /// Returns `true` if ads currently loaded and can be shown, otherwise `false`.
  static Future<bool> isLoaded(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isLoaded', {'adType': adType.platformShowType});
  }

  /// Check if loaded ad is precache for [adType]
  ///
  /// Returns `true` if currently loaded ads is precache, otherwise `false`.
  static Future<bool> isPrecache(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('isPrecache', {'adType': adType.platformType});
  }

  /// Check if ad with specific [adType] can be shown with [placement]
  ///
  /// Returns `true` if ad can be shown with this placement, otherwise `false`.
  static Future<bool> canShow(AppodealAdType adType,
      [String placement = "default"]) async {
    return await _channel.invokeMethod(
        'canShow', {'adType': adType.platformType, 'placement': placement});
  }

  /// Get predicted ecpm for certain [adType]
  static Future<double> getPredictedEcpm(AppodealAdType adType) async {
    return await _channel
        .invokeMethod('getPredictedEcpm', {'adType': adType.platformType});
  }

  /// Show [adType] advertising with [placement]
  ///
  /// Returns `true` if ad can be shown with this placement, otherwise `false`.
  static Future<bool> show(AppodealAdType adType,
      [String placement = "default"]) async {
    return await _channel.invokeMethod(
        'show', {'adType': adType.platformShowType, 'placement': placement});
  }

  /// Hide [adType] advertising
  ///
  /// Support only [AppodealAdType.Banner] and [AppodealAdType.MREC]
  static hide(AppodealAdType adType) {
    _channel.invokeMethod('hide', {'adType': adType.platformShowType});
  }

  /// Destroy [adType] advertising
  ///
  /// Support only [AppodealAdType.Banner] and [AppodealAdType.MREC]
  static destroy(AppodealAdType adType) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('destroy', {'adType': adType.platformType});
    }
  }

  /// Set [isAdViewAutoResume] for `Android` platform (`true` by default).
  ///
  /// If [isAdViewAutoResume] `true` that the SDK will show AdView on all new activities without calling additional code from your side.
  /// If you want to control the display yourself, you can set [isAdViewAutoResume] as `false` parameter.
  /// Support only for [AppodealAdType.Banner] and [AppodealAdType.MREC]
  static setAdViewAutoResume(bool isAdViewAutoResume) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('setAdViewAutoResume', {
        'isAdViewAutoResume': isAdViewAutoResume,
      });
    }
  }

  /// Check if ad view auto resume is enabled for `Android` platform (`true` by default).
  ///
  /// Returns `true` if ad view auto resume is enabled, otherwise `false`.
  static Future<bool> isAdViewAutoResume() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('isAdViewAutoResume');
    }
    return false;
  }

  /// Set [isSmartBannersEnabled] (`false` by default).
  static setSmartBanners(bool isSmartBannersEnabled) {
    _channel.invokeMethod('setSmartBanners', {
      'isSmartBannersEnabled': isSmartBannersEnabled,
    });
  }

  /// Check if smart banner is enabled (`false` by default).
  ///
  /// Returns `true` if smart banner is enabled, otherwise `false`.
  static Future<bool> isSmartBanners() async {
    return await _channel.invokeMethod('isSmartBanners');
  }

  /// Set [isTabletBannerEnabled] (`false` by default).
  static setTabletBanners(bool isTabletBannerEnabled) {
    _channel.invokeMethod('setTabletBanners', {
      'isTabletBannerEnabled': isTabletBannerEnabled,
    });
  }

  /// Check if tablet banner is enabled (`false` by default).
  ///
  /// Returns `true` if tablet banner is enabled, otherwise `false`.
  static Future<bool> isTabletBanners() async {
    return await _channel.invokeMethod('isTabletBanners');
  }

  /// Set [bannerAnimationEnabled] (`true` by default).
  static setBannerAnimation(bool isBannerAnimationEnabled) {
    _channel.invokeMethod('setBannerAnimation', {
      'isBannerAnimationEnabled': isBannerAnimationEnabled,
    });
  }

  /// Check if banner animation is enabled (`false` by default).
  ///
  /// Returns `true` if banner animation is enabled, otherwise `false`.
  static Future<bool> isBannerAnimation() async {
    return await _channel.invokeMethod('isBannerAnimation');
  }

  /// Setting banners inverse rotation (by default: left = 90, right = -90).
  ///
  /// [leftBannerRotation] rotation for [AppodealAdType.BannerLeft], [AppodealAdType.BannerRight]
  static setBannerRotation(int leftBannerRotation, int rightBannerRotation) {
    _channel.invokeMethod('setBannerRotation', {
      'leftBannerRotation': leftBannerRotation,
      'rightBannerRotation': rightBannerRotation,
    });
  }

  /// Disabling specified [network] for [adType]
  static disableNetwork(String network,
      [AppodealAdType adType = AppodealAdType.All]) {
    _channel.invokeMethod('disableNetwork', {
      'network': network,
      'adType': adType.platformType,
    });
  }

  /// Mute video if [isMuteVideosIfCallsMuted] is `true` for `Android` platform (`false` by default).
  static muteVideosIfCallsMuted(bool isMuteVideosIfCallsMuted) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('muteVideosIfCallsMuted',
          {'isMuteVideosIfCallsMuted': isMuteVideosIfCallsMuted});
    }
  }

  /// Check if mute videos when calls muted is enabled for `Android` platform (`false` by default).
  ///
  /// Returns `true` if mute videos when calls muted, otherwise `false`.
  static Future<bool> isMuteVideosIfCallsMuted() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('isMuteVideosIfCallsMuted');
    }
    return false;
  }

  /// Disables data collection for kids apps
  ///
  /// If [isChildDirectedTreatment] `true` that to disable data collection for kids apps
  static setChildDirectedTreatment(bool isChildDirectedTreatment) {
    _channel.invokeMethod('setChildDirectedTreatment',
        {'isChildDirectedTreatment': isChildDirectedTreatment});
  }

  /// Check if data collection for kids apps disabled (`false` by default).
  ///
  /// Returns `true` if data collection for kids apps disabled, otherwise `false`.
  static Future<bool> isChildDirectedTreatment() async {
    return await _channel.invokeMethod('isChildDirectedTreatment');
  }

  /// Set use safe area [isUseSafeArea] for `Android` platform (`false` by default).
  ///
  /// Appodeal SDK will consider safe area when ad shown
  /// Support only for [AppodealAdType.Banner] and [AppodealAdType.MREC]
  static setUseSafeArea(bool isUseSafeArea) {
    if (Platform.isAndroid) {
      _channel.invokeMethod('isUseSafeArea', {'isUseSafeArea': isUseSafeArea});
    }
  }

  /// Check if usage safe area is enabled for `Android` platform (`false` by default).
  ///
  /// Returns `true` usage safe area is enabled, otherwise `false`.
  static Future<bool> isUseSafeArea() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('isUseSafeArea');
    }
    return false;
  }

  /// Set [userId]
  static setUserId(String userId) {
    _channel.invokeMethod('setUserId', {'userId': userId});
  }

  /// Get user Id.
  static Future<String?> getUserId() async {
    return await _channel.invokeMethod('getUserId');
  }

  /// Set custom segment filter [name] to [value]
  static setCustomFilter(String name, dynamic value) {
    _channel.invokeMethod('setCustomFilter', {'name': name, 'value': value});
  }

  /// Set custom extara data [key] to [value].
  static setExtraData(String key, dynamic value) {
    _channel.invokeMethod('setExtraData', {'key': key, 'value': value});
  }

  /// Get SDK version.
  static String getSDKVersion() {
    return "3.2.0-beta.3";
  }

  /// Get SDK platform version.
  static Future<String> getPlatformSdkVersion() async {
    return await _channel.invokeMethod('getPlatformSdkVersion');
  }

  /// Logging event with [eventName] and [params] in all of connected service.
  static logEvent(String eventName, Map<String, dynamic> params) {
    _channel
        .invokeMethod('logEvent', {"eventName": eventName, "params": params});
  }

  /// Validate in-app [purchase] in one of connected attribution service.
  static validateInAppPurchase(
      {required AppodealPurchase purchase,
      Function(AppodealPurchase purchase, List<ApdValidationError>? errors)?
          onInAppPurchaseValidateSuccess,
      Function(AppodealPurchase purchase, List<ApdValidationError>? errors)?
          onInAppPurchaseValidateFail}) {
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

  /// Disable App Tracking Transparency authorization request for `iOS` platform
  static disableAppTrackingTransparencyRequest() {
    if (Platform.isIOS) {
      _channel.invokeMethod('disableAppTrackingTransparencyRequest');
    }
  }

  /// Load consent form
  static loadConsentForm(
      {required String appKey,
      Function? onLoaded,
      Function(List<ApdConsentError> error)? onLoadFailed}) {
    _functions["onConsentFormLoaded"] = (call) {
      onLoaded?.call();
    };
    _functions["onConsentFormLoadError"] = (call) {
      final error = List<ApdConsentError>.from(
          call.arguments['errors'].map((e) => ApdConsentError._(e)));
      onLoadFailed?.call(error);
    };
    _channel.invokeMethod('loadConsentForm', {'appKey': appKey});
  }

  /// Show the consent form to determine the user's consent
  static showConsentForm(
      {Function? onOpened,
      Function(List<ApdConsentError> error)? onShowFailed,
      Function? onClosed}) {
    _functions["onConsentFormOpened"] = (call) {
      onOpened?.call();
    };
    _functions["onConsentFormShowFailed"] = (call) {
      final error = List<ApdConsentError>.from(
          call.arguments['errors'].map((e) => ApdConsentError._(e)));
      onShowFailed?.call(error);
    };
    _functions["onConsentFormClosed"] = (call) {
      onClosed?.call();
    };
    _channel.invokeMethod('showConsentForm');
  }

  /// Set custom vendor for consent form
  static setCustomVendor(
      String vendorName,
      String vendorBundle,
      String vendorPolicyUrl,
      List<int> vendorPurposeIds,
      List<int> vendorFeatureIds,
      List<int> vendorLegitimateInterestPurposeIds) {
    _channel.invokeMethod('setCustomVendor', {
      'name': vendorName,
      'bundle': vendorBundle,
      'policyUrl': vendorPolicyUrl,
      'purposeIds': vendorPurposeIds,
      'featureIds': vendorFeatureIds,
      'legitimateInterestPurposeIds': vendorLegitimateInterestPurposeIds
    });
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

  /// Set ad revenue callbacks
  ///
  /// [onAdRevenueReceive] Called every time when SDK receives a revenue information for an ad.
  static void setAdRevenueCallbacks(
      {Function(AppodealAdRevenue adRevenue)? onAdRevenueReceive}) {
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
  final String desctiption;

  ApdInitializationError._(this.desctiption);
}

/// Appodeal SDK In-App Validation Error class.
///
/// This class declares errors during in-app validation.
///
class ApdValidationError {
  final String desctiption;

  ApdValidationError._(this.desctiption);
}

/// Appodeal SDK Consent Error class.
///
/// This class declares errors during consent behavor.
///
class ApdConsentError {
  final String desctiption;

  ApdConsentError._(this.desctiption);
}
