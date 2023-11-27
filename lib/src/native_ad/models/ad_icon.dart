import '../../../stack_appodeal_flutter.dart';

/// This is the configuration of advertiser icon.
class AdIconConfig with AppodealPlatformArguments {
  final bool visible;

  /// size in dp
  final int size;

  final AdIconPosition position;

  final int margin;

  AdIconConfig({
    this.visible = true,
    this.size = 50,
    this.position = AdIconPosition.start,
    this.margin = 0,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'visible': visible,
        'size': size,
        'position': position.index,
        'margin': margin,
      };
}

enum AdIconPosition { start, end }
