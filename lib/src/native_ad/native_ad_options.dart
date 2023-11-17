/// Native options builder

import 'package:flutter/material.dart';

import '../../stack_appodeal_flutter.dart';

class NativeAdOptions with AppodealPlatformArguments {
  final _NativeAdType nativeAdType;
  final AdTitleConfig adTitleConfig;
  final AdAttributionConfig adAttributionConfig;
  final AdChoiceConfig adChoiceConfig;
  final AdIconConfig adIconConfig;
  final AdDescriptionConfig adDescriptionConfig;
  final AdActionButtonConfig adActionButtonConfig;
  final AdLayoutConfig adLayoutConfig;
  final AdMediaConfig adMediaConfig;

  NativeAdOptions._({
    required this.nativeAdType,
    required this.adTitleConfig,
    required this.adAttributionConfig,
    required this.adChoiceConfig,
    required this.adIconConfig,
    required this.adDescriptionConfig,
    required this.adActionButtonConfig,
    required this.adLayoutConfig,
    required this.adMediaConfig,
  });

  /// Generates custom Native Ad View options
  static NativeAdOptions customOptions({
    AdTitleConfig? adTitleConfig,
    AdAttributionConfig? adAttributionConfig,
    AdChoiceConfig? adChoiceConfig,
    AdIconConfig? adIconConfig,
    AdDescriptionConfig? adDescriptionConfig,
    AdActionButtonConfig? adActionButtonConfig,
    AdLayoutConfig? adLayoutConfig,
    AdMediaConfig? adMediaConfig,
  }) {
    return NativeAdOptions._(
      nativeAdType: _NativeAdType.custom,
      adTitleConfig: adTitleConfig ?? AdTitleConfig(),
      adAttributionConfig: adAttributionConfig ?? AdAttributionConfig(),
      adChoiceConfig: adChoiceConfig ?? AdChoiceConfig(),
      adIconConfig: adIconConfig ?? AdIconConfig(),
      adDescriptionConfig: adDescriptionConfig ?? AdDescriptionConfig(),
      adActionButtonConfig: adActionButtonConfig ?? AdActionButtonConfig(),
      adLayoutConfig: adLayoutConfig ?? AdLayoutConfig(),
      adMediaConfig: adMediaConfig ?? AdMediaConfig(),
    );
  }

  /// Generates template Native Ad View options
  static NativeAdOptions _templateOptions({
    required _NativeAdType nativeAdType,
    int? adIconSize,
    int? adTitleFontSize,
    int? adActionButtonTextSize,
    int? adDescriptionFontSize,
    Color? adAttributionTextColor,
    Color? adAttributionBackgroundColor,
    AdChoicePosition? adChoicePosition,
  }) {
    return NativeAdOptions._(
      nativeAdType: nativeAdType,
      adTitleConfig: AdTitleConfig(fontSize: adTitleFontSize ?? 14),
      adAttributionConfig: AdAttributionConfig(
          textColor: adAttributionTextColor ?? Colors.black,
          backgroundColor: adAttributionBackgroundColor ?? Colors.transparent),
      adChoiceConfig:
          AdChoiceConfig(position: adChoicePosition ?? AdChoicePosition.endTop),
      adIconConfig:
          AdIconConfig(height: adIconSize ?? 50, width: adIconSize ?? 50),
      adDescriptionConfig:
          AdDescriptionConfig(fontSize: adDescriptionFontSize ?? 12),
      adActionButtonConfig:
          AdActionButtonConfig(fontSize: adActionButtonTextSize ?? 12),
      adLayoutConfig: AdLayoutConfig(),
      adMediaConfig: AdMediaConfig(),
    );
  }

  /// Generates Content Stream template Native Ad View options
  static NativeAdOptions contentStreamOptions({
    int? adIconSize,
    int? adTitleFontSize,
    int? adActionButtonTextSize,
    int? adDescriptionFontSize,
    Color? adAttributionTextColor,
    Color? adAttributionBackgroundColor,
    AdChoicePosition? adChoicePosition,
  }) {
    return NativeAdOptions._templateOptions(
      nativeAdType: _NativeAdType.contentStream,
      adIconSize: adIconSize,
      adTitleFontSize: adTitleFontSize,
      adActionButtonTextSize: adActionButtonTextSize,
      adDescriptionFontSize: adDescriptionFontSize,
      adAttributionTextColor: adAttributionTextColor,
      adAttributionBackgroundColor: adAttributionBackgroundColor,
      adChoicePosition: adChoicePosition,
    );
  }

  /// Generates App Wall template Native Ad View options
  static NativeAdOptions appWallOptions({
    int? adIconSize,
    int? adTitleFontSize,
    int? adActionButtonTextSize,
    int? adDescriptionFontSize,
    Color? adAttributionTextColor,
    Color? adAttributionBackgroundColor,
    AdChoicePosition? adChoicePosition,
  }) {
    return NativeAdOptions._templateOptions(
      nativeAdType: _NativeAdType.appWall,
      adIconSize: adIconSize,
      adTitleFontSize: adTitleFontSize,
      adActionButtonTextSize: adActionButtonTextSize,
      adDescriptionFontSize: adDescriptionFontSize,
      adAttributionTextColor: adAttributionTextColor,
      adAttributionBackgroundColor: adAttributionBackgroundColor,
      adChoicePosition: adChoicePosition,
    );
  }

  /// Generates News Feed template Native Ad View options
  static NativeAdOptions newsFeedOptions({
    int? adIconSize,
    int? adTitleFontSize,
    int? adActionButtonTextSize,
    int? adDescriptionFontSize,
    Color? adAttributionTextColor,
    Color? adAttributionBackgroundColor,
    AdChoicePosition? adChoicePosition,
  }) {
    return NativeAdOptions._templateOptions(
      nativeAdType: _NativeAdType.newsFeed,
      adIconSize: adIconSize,
      adTitleFontSize: adTitleFontSize,
      adActionButtonTextSize: adActionButtonTextSize,
      adDescriptionFontSize: adDescriptionFontSize,
      adAttributionTextColor: adAttributionTextColor,
      adAttributionBackgroundColor: adAttributionBackgroundColor,
      adChoicePosition: adChoicePosition,
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
        adTitleConfig.visible ||
        adAttributionConfig.visible) {
      height = height + adLayoutConfig.adTileHeight;
    }
    if (height != 0) {
      height = height + 10;
    }
    return height.toDouble();
  }

  /// Convert to map to pass to NativeAdOptions in NativeAd
  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'nativeAdType': nativeAdType.index,
        'adMediaConfig': adMediaConfig.toMap,
        'adTitleConfig': adTitleConfig.toMap,
        'adAttributionConfig': adAttributionConfig.toMap,
        'adChoiceConfig': adChoiceConfig.toMap,
        'adIconConfig': adIconConfig.toMap,
        'adDescriptionConfig': adDescriptionConfig.toMap,
        'adActionButtonConfig': adActionButtonConfig.toMap,
        'adLayoutConfig': adLayoutConfig.toMap,
      };
}

enum _NativeAdType { custom, contentStream, appWall, newsFeed }
