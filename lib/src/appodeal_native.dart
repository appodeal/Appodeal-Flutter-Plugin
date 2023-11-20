import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';

class AppodealNativeAd extends StatefulWidget {
  final WidgetAdParams nativeAdParams;
  final String? placement;

  const AppodealNativeAd({
    Key? key,
    required this.nativeAdParams,
    this.placement = "default",
  }) : super(key: key);

  @override
  _AppodealNativeAdState createState() => _AppodealNativeAdState();
}

class _AppodealNativeAdState extends State<AppodealNativeAd> {
  int _keyCounter = 0;
  String get _currentKey => 'appodeal_native_ad_$_keyCounter';

  final String _viewType = 'appodeal_flutter/native_view';

  @override
  void initState() {
    super.initState();
    _keyCounter++;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.nativeAdParams.widgetWidth,
      height: widget.nativeAdParams.widgetHeight,
      child: Platform.isAndroid
          ? PlatformViewLink(
              key: Key(_currentKey),
              viewType: _viewType,
              surfaceFactory:
                  (BuildContext context, PlatformViewController controller) {
                return AndroidViewSurface(
                  controller: controller as AndroidViewController,
                  gestureRecognizers: const <Factory<
                      OneSequenceGestureRecognizer>>{},
                  hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                );
              },
              onCreatePlatformView: (PlatformViewCreationParams params) {
                return PlatformViewsService.initSurfaceAndroidView(
                  id: params.id,
                  viewType: _viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: _nativeCreationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                  onFocus: () {
                    params.onFocusChanged(true);
                  },
                )
                  ..addOnPlatformViewCreatedListener(
                      params.onPlatformViewCreated)
                  ..create();
              },
            )
          : UiKitView(
              key: Key(_currentKey),
              viewType: _viewType,
              creationParams: _nativeCreationParams,
              creationParamsCodec: const StandardMessageCodec(),
            ),
    );
  }

  Map<String, dynamic> get _nativeCreationParams => {
        'key': _currentKey.toString(),
        'nativeAd': widget.nativeAdParams.toMap,
        'adSize': "NATIVE",
        'placement': widget.placement,
      };
}
