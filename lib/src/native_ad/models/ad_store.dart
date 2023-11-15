/// This is the configuration of store , eg: Google play.
class AdStoreConfig {
  final bool visible;
  final int fontSize;

  /// hex color code required
  final String textColor;

  AdStoreConfig({
    this.visible = true,
    this.fontSize = 11,
    this.textColor = '#FFFFFF',
  });

  Map<String, Object> get toMap {
    return {
      'visible': visible,
      'fontSize': fontSize,
      'textColor': textColor.toLowerCase(),
    };
  }
}
