import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

class NativeMediaOptions extends ViewOptions {
  final int? margin;

  const NativeMediaOptions({this.margin = 4}) : super(margin: margin);

  @override
  Map<String, dynamic>? toMap() => {
        'margin': margin,
      };
}
