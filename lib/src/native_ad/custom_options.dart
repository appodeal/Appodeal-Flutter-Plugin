/// Custom options builder

import 'models/ad_action_button.dart';
import 'models/ad_advertiser.dart';
import 'models/ad_choice.dart';
import 'models/ad_description.dart';
import 'models/ad_icon.dart';
import 'models/ad_layout.dart';
import 'models/ad_media.dart';
import 'models/ad_price.dart';
import 'models/ad_stars.dart';
import 'models/ad_store.dart';
import 'models/ad_title.dart';

class NativeAdCustomOptions {
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

  NativeAdCustomOptions({
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

  /// Generates default options
  static NativeAdCustomOptions defaultConfig({
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
    return NativeAdCustomOptions(
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
  Map<String, Object> get toMap {
    return {
      'adMediaConfig': adMediaConfig.toMap,
      'adStarsConfig': adStarsConfig.toMap,
      'adPriceConfig': adPriceConfig.toMap,
      'adStoreConfig': adStoreConfig.toMap,
      'adTitleConfig': adTitleConfig.toMap,
      'adAdvertiserConfig': adAdvertiserConfig.toMap,
      'adIconConfig': adIconConfig.toMap,
      'adDescriptionConfig': adDescriptionConfig.toMap,
      'adActionButtonConfig': adActionButtonConfig.toMap,
      'adLayoutConfig': adLayoutConfig.toMap,
    };
  }
}
