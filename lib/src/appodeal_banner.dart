import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class AppodealBanner extends StatefulWidget {
  final AppodealBannerSize adSize;
  final String placement;

  const AppodealBanner({
    Key? key,
    required this.adSize,
    this.placement = "default",
  }) : super(key: key);

  @override
  _AppodealBannerState createState() => _AppodealBannerState();
}

class _AppodealBannerState extends State<AppodealBanner> {
  final UniqueKey _key = UniqueKey();
  final String _viewType = 'appodeal_flutter/banner_view';
  Future<Size>? adSize;

  @override
  void initState() {
    super.initState();
    adSize = Future.value(Size(
      widget.adSize.width.toDouble(),
      widget.adSize.height.toDouble(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Size>(
      future: adSize,
      builder: (context, snapshot) {
        final adSize = snapshot.data;
        if (adSize == null) {
          return SizedBox.shrink();
        }
        return SizedBox.fromSize(
            size: adSize,
            child: Platform.isIOS
                ? UiKitView(
                    key: _key,
                    viewType: _viewType,
                    creationParams: _bannerCreationParams,
                    creationParamsCodec: const StandardMessageCodec(),
                  )
                : PlatformViewLink(
                    key: _key,
                    viewType: _viewType,
                    surfaceFactory: (BuildContext context,
                        PlatformViewController controller) {
                      return AndroidViewSurface(
                        controller: controller as AndroidViewController,
                        gestureRecognizers: const <
                            Factory<OneSequenceGestureRecognizer>>{},
                        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                      );
                    },
                    onCreatePlatformView: (PlatformViewCreationParams params) {
                      return PlatformViewsService.initSurfaceAndroidView(
                        id: params.id,
                        viewType: _viewType,
                        layoutDirection: TextDirection.ltr,
                        creationParams: _bannerCreationParams,
                        creationParamsCodec: const StandardMessageCodec(),
                        onFocus: () {
                          params.onFocusChanged(true);
                        },
                      )
                        ..addOnPlatformViewCreatedListener(
                            params.onPlatformViewCreated)
                        ..create();
                    },
                  ));
      },
    );
  }

  Map<String, dynamic> get _bannerCreationParams => {
        'adSize': widget.adSize.toMap,
        'placement': widget.placement,
      };
}
