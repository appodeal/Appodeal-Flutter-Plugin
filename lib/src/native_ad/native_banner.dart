import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_banner_options.dart';

class NativeBanner extends NativeAd {
  final NativeBannerOptions options;

  NativeBanner({required this.options, AdChoicePosition? adChoicePosition})
      : super(adChoicePosition: adChoicePosition);

  Map<String, dynamic> get toMap => <String, dynamic>{
        'options': options,
        'adChoicePosition': adChoicePosition
      };
}
