/// Enum representing banner sizes for Appodeal ads.
enum AppodealBannerSize {
  /// Standard banner size (320x50).
  BANNER(320, 50, 'BANNER'),

  /// Medium rectangle banner size (300x250).
  MEDIUM_RECTANGLE(300, 250, 'MEDIUM_RECTANGLE');

  /// Width of the banner in pixels.
  final int width;

  /// Height of the banner in pixels.
  final int height;

  /// Name for the banner size (e.g., 'BANNER', 'MEDIUM_RECTANGLE').
  final String name;

  /// Private constructor for initializing enum values.
  const AppodealBannerSize(this.width, this.height, this.name);

  /// Converts the banner size to a `Map` for serialization.
  ///
  /// The returned map contains:
  /// - `width`: The width of the banner.
  /// - `height`: The height of the banner.
  /// - `name`: The name of the banner size.
  Map<String, dynamic> get toMap => <String, dynamic>{
        'width': width,
        'height': height,
        'name': name,
      };

  @override
  String toString() =>
      'AppodealBannerSize(name: $name, width: $width, height: $height)';
}
