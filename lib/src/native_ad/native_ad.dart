import '../../stack_appodeal_flutter.dart';
import 'options/native_options.dart';

abstract class NativeAd with AppodealPlatformArguments {
  final double widgetHeight, widgetWidth;
  final AdChoicePosition? adChoicePosition;
  final NativeOptions options;
  final bool isTemplate;

  NativeAd(
      {this.adChoicePosition,
      required this.options,
      required this.widgetHeight,
      required this.widgetWidth,
      required this.isTemplate});
}

enum AdChoicePosition { START_TOP, START_BOTTOM, END_TOP, END_BOTTOM }
