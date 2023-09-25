import '../../../../stack_appodeal_flutter.dart';

class MediaOptions with AppodealPlatformArguments {
  final double margin;

  MediaOptions({
    this.margin = 4.0,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{'margin': margin};
}
