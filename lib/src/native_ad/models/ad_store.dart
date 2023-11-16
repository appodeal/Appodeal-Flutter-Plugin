import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of store , eg: Google play.
class AdStoreConfig with AppodealPlatformArguments {
  final bool visible;
  final int fontSize;

  /// hex color code required
  final String textColor;

  AdStoreConfig({
    this.visible = true,
    this.fontSize = 11,
    this.textColor = '#FFFFFF',
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'fontSize': fontSize,
        'textColor': textColor.toLowerCase(),
      };
}
