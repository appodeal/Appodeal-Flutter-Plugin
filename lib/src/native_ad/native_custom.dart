import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_custom_options.dart';

class NativeCustom extends NativeAd {
  final NativeCustomOptions options;
  final double widgetHeight, widgetWidth;
  final AdChoicePosition? adChoicePosition;

  NativeCustom({
    required this.options,
    required this.widgetHeight,
    required this.widgetWidth,
    AdChoicePosition? adChoicePosition,
  })  : adChoicePosition = adChoicePosition ?? AdChoicePosition.START_TOP,
        super(
          options: options,
          widgetHeight: widgetHeight,
          widgetWidth: widgetWidth,
          adChoicePosition: adChoicePosition,
          isTemplate: false,
        );

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'isTemplate': isTemplate,
        'widgetHeight': widgetHeight,
        'widgetWidth': widgetWidth,
        'customOptions': options.toMap,
        'adChoicePosition': adChoicePosition.toString()
      };
}
