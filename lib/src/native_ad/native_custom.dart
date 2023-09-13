import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_custom_options.dart';

class NativeCustom extends NativeAd {
  final AdChoicePosition? adChoicePosition;
  final NativeCustomOptions options;

  NativeCustom(
      {required this.options,
      this.adChoicePosition = AdChoicePosition.START_TOP})
      : super(adChoicePosition: adChoicePosition);

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'customOptions': options.toMap,
        'adChoicePosition': adChoicePosition.toString()
      };
}
