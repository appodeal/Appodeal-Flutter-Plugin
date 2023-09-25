import '../../../../stack_appodeal_flutter.dart';

class IconOptions with AppodealPlatformArguments {
  final double margin, size;

  IconOptions({
    this.margin = 4.0,
    this.size = 70.0,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'size': size,
      };
}
