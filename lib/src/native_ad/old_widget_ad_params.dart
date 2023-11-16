import 'package:flutter/cupertino.dart';

import '../../stack_appodeal_flutter.dart';

abstract class WidgetAdParams with AppodealPlatformArguments {
  final double widgetHeight, widgetWidth;
  final AdChoicePosition? adChoicePosition;
  final NativeOptions widgetOptions;

  WidgetAdParams(
      {this.adChoicePosition,
        required this.widgetOptions,
        required this.widgetHeight,
        required this.widgetWidth});
}

enum AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }

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

class WidgetTemplateParams extends WidgetAdParams {
  final TemplateType templateType;
  final AdChoicePosition? adChoicePosition;
  final NativeTemplateOptions widgetOptions;

  WidgetTemplateParams({
    required this.widgetOptions,
    context,
    required this.templateType,
    this.adChoicePosition = AdChoicePosition.START_TOP,
  }) : super(
    adChoicePosition: adChoicePosition,
    widgetHeight: _getWidgetHeight(context, templateType),
    widgetWidth: _getWidgetWidth(context),
    widgetOptions: widgetOptions,
  );

  static double _getWidgetHeight(
      BuildContext context, TemplateType templateType) {
    double width = _getWidgetWidth(context);
    switch (templateType) {
      case TemplateType.NEWS_FEED:
        return width * 0.146;
      case TemplateType.APP_WALL:
        return width * 0.195;
      case TemplateType.CONTENT_STREAM:
        return width * 0.764;
      default:
        return 0.0;
    }
  }

  static double _getWidgetWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
    'widgetHeight': widgetHeight.toInt(),
    'widgetWidth': widgetWidth.toInt(),
    'templateType': templateType.toString(),
    'adChoicePosition': adChoicePosition.toString(),
    'templateOptions': widgetOptions.toMap,
  };
}

enum TemplateType { CONTENT_STREAM, APP_WALL, NEWS_FEED }
