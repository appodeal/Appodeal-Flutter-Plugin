import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_template_options.dart';

class NativeTemplate extends NativeAd {
  final TemplateType templateType;
  final AdChoicePosition? adChoicePosition;
  final NativeTemplateOptions? options;

  NativeTemplate(
      {required this.templateType,
      this.options,
      this.adChoicePosition = AdChoicePosition.START_TOP})
      : super(adChoicePosition: adChoicePosition);

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'templateType': templateType.toString(),
        'adChoicePosition': adChoicePosition.toString(),
        'templateOptions': options?.toMap,
      };
}

enum TemplateType { CONTENT_STREAM, APP_WALL, NEWS_FEED }
