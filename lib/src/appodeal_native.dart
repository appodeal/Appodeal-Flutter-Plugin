import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';

class AppodealNativeAd extends StatefulWidget {
  final NativeAd nativeAd;
  final String? placement;

  const AppodealNativeAd({
    Key? key,
    required this.nativeAd,
    this.placement = "default",
  }) : super(key: key);

  @override
  _AppodealNativeAdState createState() => _AppodealNativeAdState();
}

class _AppodealNativeAdState extends State<AppodealNativeAd> {
  final UniqueKey _key = UniqueKey();
  final String _viewType = 'appodeal_flutter/native_view';

  static const MethodChannel _nativeChannel =
      const MethodChannel('appodeal_flutter/native');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.nativeAd.widgetWidth,
      height: widget.nativeAd.widgetHeight,
      child: Container(
        width: double.infinity,
        child: Platform.isAndroid
            ? PlatformViewLink(
                key: _key,
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
                key: _key,
                viewType: _viewType,
                creationParams: _nativeCreationParams,
                creationParamsCodec: const StandardMessageCodec(),
              ),
      ),
    );
  }

  Map<String, dynamic> get _nativeCreationParams => {
        'nativeAd': widget.nativeAd.toMap,
        'adSize': "NATIVE",
        'placement': widget.placement,
      };
}
