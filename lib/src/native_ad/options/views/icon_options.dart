import '../../../../stack_appodeal_flutter.dart';

class IconOptions with AppodealPlatformArguments {
  final int margin, size;

  IconOptions({
    this.margin = 4,
    this.size = 70,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'size': size,
      };
}