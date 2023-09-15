import 'package:stack_appodeal_flutter/src/native_ad/options/views/ad_attrubution_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/cta_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/description_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/native_icon_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/native_media_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/title_options.dart';

import 'native_options.dart';

class NativeCustomOptions extends NativeOptions {
  final NativeBannerViewPosition? viewPosition;
  final MediaViewPosition? mediaViewPosition;
  final int? containerMargin;
  final AdAttributionOptions? adAttributionOptions;
  final CTAOptions? ctaOptions;
  final DescriptionOptions? descriptionOptions;
  final NativeIconOptions? nativeIconOptions;
  final NativeMediaOptions? nativeMediaOptions;
  final TitleOptions? titleOptions;

  NativeCustomOptions({
    this.viewPosition = NativeBannerViewPosition.ICON_START,
    this.mediaViewPosition,
    this.containerMargin,
    this.adAttributionOptions,
    this.ctaOptions,
    this.descriptionOptions,
    this.nativeIconOptions,
    this.nativeMediaOptions,
    this.titleOptions,
  }) : super();

  Map<String, dynamic> get toMap => <String, dynamic>{
        'mediaViewPosition': mediaViewPosition?.toString(),
        'viewPosition': viewPosition?.toString(),
        'containerMargin': containerMargin,
        'adAttributionOptions': adAttributionOptions?.toMap,
        'ctaOptions': ctaOptions?.toMap,
        'descriptionOptions': descriptionOptions?.toMap,
        'nativeIconOptions': nativeIconOptions?.toMap,
        'nativeMediaOptions': nativeMediaOptions?.toMap,
        'titleOptions': titleOptions?.toMap,
      };
}

enum NativeBannerViewPosition { ICON_START, CTA_START }

enum MediaViewPosition { TOP, BOTTOM }
