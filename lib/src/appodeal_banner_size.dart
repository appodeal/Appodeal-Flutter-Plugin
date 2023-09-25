import 'package:stack_appodeal_flutter/src/appodeal_platform_arguments.dart';

class AppodealBannerSize with AppodealPlatformArguments {
  final int width, height;
  final String? name;

  static const AppodealBannerSize BANNER =
      AppodealBannerSize(width: 320, height: 50, name: 'BANNER');
  static const AppodealBannerSize MEDIUM_RECTANGLE =
      AppodealBannerSize(width: 300, height: 250, name: 'MEDIUM_RECTANGLE');

  const AppodealBannerSize({
    required this.width,
    required this.height,
    this.name,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'width': width,
        'height': height,
        'name': name,
      };
}
