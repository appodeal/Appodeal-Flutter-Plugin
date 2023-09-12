import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_banner.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_full_options.dart';

class NativeFull extends NativeAd {
  final NativeBanner nativeBanner;
  final NativeFullOptions options;

  NativeFull(
      {required this.options,
      required this.nativeBanner,
      AdChoicePosition? adChoicePosition})
      : super(adChoicePosition: adChoicePosition);

  Map<String, dynamic> get toMap => <String, dynamic>{
    'nativeBanner' : nativeBanner.toMap,
    'nativeFullOptions': options.toMap,
  };
}
