import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of ad choice view.
class AdChoiceConfig with AppodealPlatformArguments {
  final AdChoicePosition position;

  AdChoiceConfig({
    this.position = AdChoicePosition.endTop,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'position': position.index,
      };
}

enum AdChoicePosition { startTop, startBottom, endTop, endBottom }
