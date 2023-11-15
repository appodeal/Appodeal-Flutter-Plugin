import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of media that will show up as image/video.
class AdMediaConfig with AppodealPlatformArguments {
  final bool visible;

  final int margin;

  AdMediaConfig({
    this.visible = true,
    this.margin = 4,
  });

  @override
  Map<String, dynamic> get toMap =>
      <String, dynamic>{'visible': visible, 'margin': margin};
}
