import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';

class AppodealNative extends StatefulWidget {
  final NativeAd nativeAd;
  final String placement;

  const AppodealNative({
    Key? key,
    required this.nativeAd,
    this.placement = "default",
  }) : super(key: key);

  @override
  _AppodealNativeState createState() => _AppodealNativeState();
}

class _AppodealNativeState extends State<AppodealNative> {
  final UniqueKey _key = UniqueKey();
  final String _viewType = 'appodeal_flutter/native';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder<Map<String, double>>(
        future: fetchViewSize(),
        builder: (context, snapshot) {
          final sizeMap = snapshot.data;
          if (sizeMap == null) {
            return SizedBox.shrink();
          }

          final width = sizeMap['width'] ?? 0.0;
          final height = sizeMap['height'] ?? 0.0;

          return SizedBox(
            width: width,
            height: height,
            child: Platform.isAndroid
                ? PlatformViewLink(
                    key: _key,
                    viewType: _viewType,
                    surfaceFactory: (BuildContext context,
                        PlatformViewController controller) {
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
          );
        },
      ),
    );
  }

  Future<Map<String, double>> fetchViewSize() async {
    if (Platform.isAndroid) {
      final Map<String, dynamic> sizeMap =
          //TODO get channel?
          <String, dynamic>{'width': 300, 'height': 250};
      return sizeMap.map((key, value) => MapEntry(key, value.toDouble()));
    } else {
      return {'width': 0.0, 'height': 0.0};
    }
  }

  Map<String, dynamic> get _nativeCreationParams => {
        'nativeAd': widget.nativeAd,
        'placement': widget.placement,
      };
}