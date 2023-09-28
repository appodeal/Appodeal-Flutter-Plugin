import '../../../../stack_appodeal_flutter.dart';

class MediaOptions with AppodealPlatformArguments {
  final int margin;

  MediaOptions({
    this.margin = 4,
  });

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{'margin': margin};
}