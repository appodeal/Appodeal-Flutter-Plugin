import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

class NativeIconOptions extends ViewOptions {
  final int size, margin;

  const NativeIconOptions({this.size = 70, this.margin = 4})
      : super(margin: margin);

  @override
  Map<String, dynamic>? toMap() => {
        'margin': margin,
        'size': size,
      };
}
