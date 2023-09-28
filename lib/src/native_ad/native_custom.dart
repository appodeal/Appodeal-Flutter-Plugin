import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_custom_options.dart';

class WidgetCustomParams extends WidgetAdParams {
  final NativeCustomOptions widgetOptions;
  final double widgetHeight, widgetWidth;
  final AdChoicePosition? adChoicePosition;

  WidgetCustomParams({
    required this.widgetOptions,
    required this.widgetHeight,
    required this.widgetWidth,
    AdChoicePosition? adChoicePosition,
  })  : adChoicePosition = adChoicePosition ?? AdChoicePosition.START_TOP,
        super(
            widgetOptions: widgetOptions,
            widgetHeight: widgetHeight,
            widgetWidth: widgetWidth,
            adChoicePosition: adChoicePosition);

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'widgetHeight': widgetHeight.toInt(),
        'widgetWidth': widgetWidth.toInt(),
        'customOptions': widgetOptions.toMap,
        'adChoicePosition': adChoicePosition.toString()
      };
}
