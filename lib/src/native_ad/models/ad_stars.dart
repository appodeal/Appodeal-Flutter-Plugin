/// This is the configuration of ratings.
class AdStarsConfig {
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

  Map<String, Object> get toMap {
    return {
      'size': size,
      'visible': visible,
      'starsColor': starsColor.toLowerCase(),
      'emptyStarsColor': emptyStarsColor.toLowerCase(),
    };
  }
}
