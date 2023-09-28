import '../../stack_appodeal_flutter.dart';
import 'options/native_options.dart';

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
