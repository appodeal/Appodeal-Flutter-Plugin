import 'package:flutter/cupertino.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_template_options.dart';

class WidgetTemplateParams extends WidgetAdParams {
  final BuildContext context;
  final TemplateType templateType;
  final AdChoicePosition? adChoicePosition;
  final NativeTemplateOptions widgetOptions;

  WidgetTemplateParams({
    required this.widgetOptions,
    required this.context,
    required this.templateType,
    this.adChoicePosition = AdChoicePosition.START_TOP,
  }) : super(
          adChoicePosition: adChoicePosition,
          widgetHeight: getWidgetHeight(context, templateType),
          widgetWidth: getWidgetWidth(context),
          widgetOptions: widgetOptions,
        );

  static double getWidgetWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getWidgetHeight(
      BuildContext context, TemplateType templateType) {
    double width = getWidgetWidth(context);
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
