import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of ratings.
class AdStarsConfig with AppodealPlatformArguments {
  final bool visible;
  final int size;

  /// hex color code required
  final String starsColor;

  /// hex color code required
  final String emptyStarsColor;

  AdStarsConfig({
    this.visible = true,
    this.size = 14,
    this.starsColor = '#0747A1',
    this.emptyStarsColor = '#FFFFFF',
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'size': size,
        'visible': visible,
        'starsColor': starsColor.toLowerCase(),
        'emptyStarsColor': emptyStarsColor.toLowerCase(),
      };
}
