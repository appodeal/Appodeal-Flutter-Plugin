import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of media that will show up as image/video.
class AdMediaConfig with AppodealPlatformArguments {
  final bool visible;
  final AdMediaPosition position;
  final int margin;

  AdMediaConfig({
    this.visible = true,
    this.position = AdMediaPosition.top,
    this.margin = 0,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'position': position.index,
        'margin': margin
      };
}

enum AdMediaPosition { top, bottom }
