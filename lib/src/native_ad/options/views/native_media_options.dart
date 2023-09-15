import 'package:stack_appodeal_flutter/src/native_ad/options/views/view_options.dart';

class NativeMediaOptions extends ViewOptions {
  final int? margin;

  NativeMediaOptions({this.margin = 4});

  @override
  Map<String, dynamic> get toMap => <String, dynamic>{
        'margin': margin,
      };
}
