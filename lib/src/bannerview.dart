import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppodealBannerView extends StatelessWidget {
  final Map<String, dynamic> _args = {};

  AppodealBannerView({Key? key, String? placementName}) : super(key: key) {
    _args["placementName"] = placementName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 50,
      child: Platform.isIOS
          ? UiKitView(
        key: UniqueKey(),
        viewType: 'com.appodeal.appodeal_flutter/bannerview',
        creationParams: _args,
        creationParamsCodec: const StandardMessageCodec(),
      )
          : AndroidView(
        key: UniqueKey(),
        viewType: 'com.appodeal.appodeal_flutter/bannerview',
        creationParams: _args,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}