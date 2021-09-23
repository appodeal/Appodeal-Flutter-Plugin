import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealMrecView extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealMrecView({Key? key, String? placementName}) : super(key: key) {
    _args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Platform.isIOS
          ? UiKitView(
              key: UniqueKey(),
              viewType: 'com.appodeal.appodeal_flutter/mrecview',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            )
          : AndroidView(
              key: UniqueKey(),
              viewType: 'com.appodeal.appodeal_flutter/mrecview',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }
}
