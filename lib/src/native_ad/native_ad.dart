import 'options/native_options.dart';

abstract class NativeAd {
  final AdChoicePosition? adChoicePosition;
  final NativeOptions options;
  final double widgetHeight, widgetWidth;
  final bool isTemplate;

  NativeAd(
      {this.adChoicePosition,
      required this.options,
      required this.widgetHeight,
      required this.widgetWidth,
      required this.isTemplate});

  Map<String, dynamic> toMap();
}

enum AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }
