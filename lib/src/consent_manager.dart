import 'dart:async';

import 'package:flutter/services.dart';

enum Storage { NONE, SHARED_PREFERENCE }

class Consent {}

class Vendor {
  late String name;
  late String bundle;
  late String policyUrl;
  late List<int> purposeIds;
  late List<int> featureIds;
  late List<int> legitimateInterestPurposeIds;

  Vendor(this.name, this.bundle, this.policyUrl, this.purposeIds, this.featureIds, this.legitimateInterestPurposeIds);

}

class ConsentManager {
  static const MethodChannel _channel = const MethodChannel('appodeal_flutter');

  static Function(String event, Consent consent)? _onConsentInfoUpdated;
  static Function(String event, String error)? _onFailedToUpdateConsentInfo;

  static Future<void> requestConsentInfoUpdate(String appKey) async {
    _setConsentInfoUpdateListener();
    return _channel.invokeMethod('requestConsentInfoUpdate', {'appKey': appKey});
  }

  static Future<void> setCustomVendor(Vendor vendor) async {
    return _channel.invokeMethod('setCustomVendor', {'name': vendor.name, 'bundle': vendor.bundle, 'policyUrl': vendor.policyUrl, 'purposeIds': vendor.purposeIds, 'featureIds': vendor.featureIds, 'legitimateInterestPurposeIds': vendor.legitimateInterestPurposeIds});
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

  static void _setConsentInfoUpdateListener() {
    _channel.setMethodCallHandler((call) async {
      if (call.method.startsWith('onConsentInfoUpdated')) {
        _onConsentInfoUpdated?.call(call.method, call.arguments['consent']);
      } else if (call.method.startsWith('onFailedToUpdateConsentInfo')) {
        _onFailedToUpdateConsentInfo?.call(call.method, call.arguments['error']);
      }
    });
  }
}
