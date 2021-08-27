import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealMrecView extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealMrecView({String? placementName}) {
    this._args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      child: Platform.isIOS
          ? UiKitView(
              viewType: 'com.appodeal.appodeal/mrec_view',
              creationParams: this._args,
              creationParamsCodec: const StandardMessageCodec(),
            )
          : AndroidView(
              viewType: 'com.appodeal.appodeal/mrec_view',
              creationParams: this._args,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }
}