import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

enum Storage { NONE, SHARED_PREFERENCE }
enum Status { UNKNOWN, NON_PERSONALIZED, PARTLY_PERSONALIZED, PERSONALIZED }
enum Zone { UNKNOWN, NONE, GDPR, CCPA }
enum HasConsent { UNKNOWN, TRUE, FALSE }
enum ShouldShow { UNKNOWN, TRUE, FALSE }
enum AuthorizationStatus { NOT_DETERMINED, RESTRICTED, DENIED, AUTHORIZED }

class ConsentManager {
  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');

  static Function(String event, String consent)? _onConsentInfoUpdated;
  static Function(String event, String error)? _onFailedToUpdateConsentInfo;

  static Function(String event)? _onConsentFormLoaded;
  static Function(String event, String error)? _onConsentFormError;
  static Function(String event)? _onConsentFormOpened;
  static Function(String event, String consent)? _onConsentFormClosed;

  static Future<bool> consentFormIsShowing() async {
    return await _channel.invokeMethod('consentFormIsShowing');
  }

  static Future<bool> consentFormIsLoaded() async {
    return await _channel.invokeMethod('consentFormIsLoaded');
  }

  static Future<void> showAsDialogConsentForm() async {
    return _channel.invokeMethod('showAsDialogConsentForm');
  }

  static Future<void> showAsActivityConsentForm() async {
    return _channel.invokeMethod('showAsActivityConsentForm');
  }

  static Future<void> loadConsentForm() async {
    _setConsentFormListener();
    return _channel.invokeMethod('loadConsentForm');
  }

  static Future<void> requestConsentInfoUpdate(String appKey) async {
    _setConsentInfoUpdateListener();
    return _channel
        .invokeMethod('requestConsentInfoUpdate', {'appKey': appKey});
  }

  static Future<void> setCustomVendor(
      String vendorName,
      String vendorBundle,
      String vendorPolicyUrl,
      var vendorPurposeIds,
      var vendorFeatureIds,
      var vendorLegitimateInterestPurposeIds) async {
    return _channel.invokeMethod('setCustomVendor', {
      'name': vendorName,
      'bundle': vendorBundle,
      'policyUrl': vendorPolicyUrl,
      'purposeIds': vendorPurposeIds,
      'featureIds': vendorFeatureIds,
      'legitimateInterestPurposeIds': vendorLegitimateInterestPurposeIds
    });
  }

  static Future<void> disableAppTrackingTransparencyRequest() async {
    if (Platform.isIOS) {
      return _channel.invokeMethod('disableAppTrackingTransparencyRequest');
    }
  }

  static Future<void> setStorage(Storage storage) async {
    int storageInt = 0;
    switch (storage) {
      case Storage.NONE:
        storageInt = 0;
        break;
      case Storage.SHARED_PREFERENCE:
        storageInt = 1;
        break;
    }
    return _channel.invokeMethod('setStorage', {'storage': storageInt});
  }

  static Future<String> getCustomVendor(String bundle) async {
    return await _channel.invokeMethod('getCustomVendor', {'bundle': bundle});
  }

  static Future<Storage> getStorage() async {
    int getStorageType = await _channel.invokeMethod('getStorage');
    Storage storage;
    switch (getStorageType) {
      case 0:
        storage = Storage.NONE;
        break;
      case 1:
        storage = Storage.SHARED_PREFERENCE;
        break;
      default:
        storage = Storage.NONE;
        break;
    }
    return storage;
  }

  static Future<ShouldShow> shouldShowConsentDialog() async {
    var getShouldShowType =
        await _channel.invokeMethod('shouldShowConsentDialog');
    ShouldShow shouldShow = ShouldShow.UNKNOWN;
    switch (getShouldShowType) {
      case 0:
        shouldShow = ShouldShow.UNKNOWN;
        break;
      case 1:
        shouldShow = ShouldShow.TRUE;
        break;
      case 2:
        shouldShow = ShouldShow.FALSE;
        break;
      default:
        shouldShow = ShouldShow.UNKNOWN;
        break;
    }
    return shouldShow;
  }

  static Future<Zone> getConsentZone() async {
    var consentZoneType = await _channel.invokeMethod('getConsentZone');
    Zone zone = Zone.UNKNOWN;
    switch (consentZoneType) {
      case 0:
        zone = Zone.UNKNOWN;
        break;
      case 1:
        zone = Zone.GDPR;
        break;
      case 2:
        zone = Zone.CCPA;
        break;
      default:
        zone = Zone.UNKNOWN;
        break;
    }
    return zone;
  }

  static Future<Status> getConsentStatus() async {
    var consentZoneType = await _channel.invokeMethod('getConsentStatus');
    Status status = Status.UNKNOWN;
    switch (consentZoneType) {
      case 0:
        status = Status.UNKNOWN;
        break;
      case 1:
        status = Status.PERSONALIZED;
        break;
      case 2:
        status = Status.PARTLY_PERSONALIZED;
        break;
      case 3:
        status = Status.NON_PERSONALIZED;
        break;
      default:
        status = Status.UNKNOWN;
        break;
    }
    return status;
  }

  static Future<String> getConsent() async {
    return await _channel.invokeMethod('getConsent');
  }

  static void _setConsentFormListener() {
    _channel.setMethodCallHandler((call) async {
      if (call.method.startsWith('onConsentFormLoaded')) {
        _onConsentFormLoaded?.call(call.method);
      } else if (call.method.startsWith('onConsentFormError')) {
        _onConsentFormError?.call(call.method, call.arguments['error']);
      } else if (call.method.startsWith('onConsentFormOpened')) {
        _onConsentFormOpened?.call(call.method);
      } else if (call.method.startsWith('onConsentFormClosed')) {
        _onConsentFormClosed?.call(call.method, call.arguments['consent']);
      }
    });
  }

  static void setConsentFormListener(
      Function(String event) onConsentFormLoaded,
      Function(String event, String error) onConsentFormError,
      Function(String event) onConsentFormOpened,
      Function(String event, String consent) onConsentFormClosed) {
    _onConsentFormLoaded = onConsentFormLoaded;
    _onConsentFormError = onConsentFormError;
    _onConsentFormOpened = onConsentFormOpened;
    _onConsentFormClosed = onConsentFormClosed;
  }

  static void _setConsentInfoUpdateListener() {
    _channel.setMethodCallHandler((call) async {
      if (call.method.startsWith('onConsentInfoUpdated')) {
        _onConsentInfoUpdated?.call(call.method, call.arguments['consent']);
      } else if (call.method.startsWith('onFailedToUpdateConsentInfo')) {
        _onFailedToUpdateConsentInfo?.call(
            call.method, call.arguments['error']);
      }
    });
  }

  static void setConsentInfoUpdateListener(
      Function(String event, String consent) onConsentInfoUpdated,
      Function(String event, String error) onFailedToUpdateConsentInfo) {
    _onConsentInfoUpdated = onConsentInfoUpdated;
    _onFailedToUpdateConsentInfo = onFailedToUpdateConsentInfo;
  }
}
