/// Native options builder

import 'package:flutter/material.dart';

import '../../stack_appodeal_flutter.dart';

class NativeAdOptions with AppodealPlatformArguments {
  final AdStarsConfig adStarsConfig;
  final AdPriceConfig adPriceConfig;
  final AdStoreConfig adStoreConfig;
  final AdTitleConfig adTitleConfig;
  final AdAdvertiserConfig adAdvertiserConfig;
  final AdChoiceConfig adChoiceConfig;
  final AdIconConfig adIconConfig;
  final AdDescriptionConfig adDescriptionConfig;
  final AdActionButtonConfig adActionButtonConfig;
  final AdLayoutConfig adLayoutConfig;
  final AdMediaConfig adMediaConfig;

  NativeAdOptions._({
    required this.adStarsConfig,
    required this.adPriceConfig,
    required this.adStoreConfig,
    required this.adTitleConfig,
    required this.adAdvertiserConfig,
    required this.adChoiceConfig,
    required this.adIconConfig,
    required this.adDescriptionConfig,
    required this.adActionButtonConfig,
    required this.adLayoutConfig,
    required this.adMediaConfig,
  });

  /// Generates custom Native Ad View options
  static NativeAdOptions customOptions({
    AdStarsConfig? adStarsConfig,
    AdPriceConfig? adPriceConfig,
    AdStoreConfig? adStoreConfig,
    AdTitleConfig? adTitleConfig,
    AdAdvertiserConfig? adAdvertiserConfig,
    AdChoiceConfig? adChoiceConfig,
    AdIconConfig? adIconConfig,
    AdDescriptionConfig? adDescriptionConfig,
    AdActionButtonConfig? adActionButtonConfig,
    AdLayoutConfig? adLayoutConfig,
    AdMediaConfig? adMediaConfig,
  }) {
    return NativeAdOptions._(
      adStarsConfig: adStarsConfig ?? AdStarsConfig(),
      adPriceConfig: adPriceConfig ?? AdPriceConfig(),
      adStoreConfig: adStoreConfig ?? AdStoreConfig(),
      adTitleConfig: adTitleConfig ?? AdTitleConfig(),
      adAdvertiserConfig: adAdvertiserConfig ?? AdAdvertiserConfig(),
      adChoiceConfig: adChoiceConfig ?? AdChoiceConfig(),
      adIconConfig: adIconConfig ?? AdIconConfig(),
      adDescriptionConfig: adDescriptionConfig ?? AdDescriptionConfig(),
      adActionButtonConfig: adActionButtonConfig ?? AdActionButtonConfig(),
      adLayoutConfig: adLayoutConfig ?? AdLayoutConfig(),
      adMediaConfig: adMediaConfig ?? AdMediaConfig(),
    );
  }

  /// Generates template Native Ad View options
  static NativeAdOptions templateOptions({
    int? adIconSize,
    int? adTitleFontSize,
    int? adActionButtonTextSize,
    int? adDescriptionFontSize,
    Color? adAdvertiserTextColor,
    Color? adAdvertiserBackgroundColor,
    AdChoicePosition? adChoicePosition,
  }) {
    return NativeAdOptions.customOptions(
      adTitleConfig: AdTitleConfig(fontSize: adTitleFontSize ?? 16),
      adAdvertiserConfig: AdAdvertiserConfig(
          textColor: adAdvertiserTextColor ?? Colors.black,
          backgroundColor: adAdvertiserBackgroundColor ?? Colors.transparent),
      adChoiceConfig: AdChoiceConfig(
          position: adChoicePosition ?? AdChoicePosition.startTop),
      adIconConfig:
          AdIconConfig(height: adIconSize ?? 50, width: adIconSize ?? 50),
      adDescriptionConfig:
          AdDescriptionConfig(fontSize: adDescriptionFontSize ?? 14),
      adActionButtonConfig:
          AdActionButtonConfig(fontSize: adActionButtonTextSize ?? 12),
    );
  }

  double get getInlineAdHeight {
    int height = 0;
    if (adMediaConfig.visible) {
      height = height + adLayoutConfig.mediaContentHeight;
    }
    if (adActionButtonConfig.visible || adDescriptionConfig.visible) {
      height = height + adLayoutConfig.adActionHeight;
    }
    if (adIconConfig.visible ||
        adStarsConfig.visible ||
        adPriceConfig.visible ||
        adStoreConfig.visible ||
        adTitleConfig.visible ||
        adAdvertiserConfig.visible) {
      height = height + adLayoutConfig.adTileHeight;
    }
    if (height != 0) {
      height = height + 10;
    }
    return height.toDouble();
  }

  /// Convert to map to pass to customOptions in NativeAd
  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'adMediaConfig': adMediaConfig.toMap,
        'adStarsConfig': adStarsConfig.toMap,
        'adPriceConfig': adPriceConfig.toMap,
        'adStoreConfig': adStoreConfig.toMap,
        'adTitleConfig': adTitleConfig.toMap,
        'adAdvertiserConfig': adAdvertiserConfig.toMap,
        'adChoiceConfig': adChoiceConfig.toMap,
        'adIconConfig': adIconConfig.toMap,
        'adDescriptionConfig': adDescriptionConfig.toMap,
        'adActionButtonConfig': adActionButtonConfig.toMap,
        'adLayoutConfig': adLayoutConfig.toMap,
      };
}
