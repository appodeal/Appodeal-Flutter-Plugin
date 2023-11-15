/// This is the configuration of price text.
class AdPriceConfig {
  final bool visible;
  final int fontSize;

  /// hex color code required
  final String textColor;

  AdPriceConfig({
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
