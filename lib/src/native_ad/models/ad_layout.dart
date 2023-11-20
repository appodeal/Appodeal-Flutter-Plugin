import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of layout
/// In case of inline ad ad all the height to the parent container widget.
/// Container height mediaContentHeight +adTileHeight +adActionHeight +10 margin pixels
class AdLayoutConfig with AppodealPlatformArguments {
  /// Image/Video content height
  final int mediaContentHeight;

  /// Ad layout container margin
  final int margin;

  AdLayoutConfig({
    this.mediaContentHeight = 250,
    this.margin = 10,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'mediaContentHeight': mediaContentHeight,
        'margin': margin,
      };
}
