import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

class NativeIconOptions extends ViewOptions {
  final int size, margin;

  NativeIconOptions({this.size = 70, this.margin = 4});

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
        'size': size,
      };
}