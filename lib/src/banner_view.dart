import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealBannerView extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealBannerView({String? placementName}) {
    this._args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 50,
      child: Platform.isIOS
          ? UiKitView(
              key: UniqueKey(),
              viewType: 'com.appodeal/bannerview',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            )
          : AndroidView(
              key: UniqueKey(),
              viewType: 'com.appodeal/bannerview',
              creationParams: _args,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }
}
