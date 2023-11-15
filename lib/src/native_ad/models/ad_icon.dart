import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of advertiser icon.
class AdIconConfig with AppodealPlatformArguments {
  final bool visible;

  /// height in dp
  final int height;

  /// width in dp
  final int width;

  final int margin;

  AdIconConfig({
    this.visible = true,
    this.height = 50,
    this.width = 50,
    this.margin = 4,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'height': height,
        'width': width,
        'margin': margin,
      };
}
