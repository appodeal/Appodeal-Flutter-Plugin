import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of layout
/// In case of inline ad ad all the height to the parent container widget.
/// Container height mediaContentHeight +adTileHeight +adActionHeight +10 margin pixels
class AdLayoutConfig with AppodealPlatformArguments {
  /// Image/Video content height
  final int mediaContentHeight;

  /// Tile height that will show advertiser id/stars/store
  final int adTileHeight;

  /// Action container height that contains body and button
  final int adActionHeight;

  /// Ad layout container margin
  final int margin;

  AdLayoutConfig({
    this.mediaContentHeight = 250,
    this.adTileHeight = 70,
    this.adActionHeight = 50,
    this.margin = 4,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'mediaContentHeight': mediaContentHeight,
        'adTileHeight': adTileHeight,
        'adActionHeight': adActionHeight,
      };
}
