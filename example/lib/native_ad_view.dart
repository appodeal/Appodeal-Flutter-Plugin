import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class NativePage extends StatefulWidget {
  @override
  _NativePageState createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  AppodealNativeAd? appodealNative;
  bool isShow = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      appodealNative = null;
      isShow = false;
    });

    Appodeal.setNativeCallbacks(
      onNativeLoaded: () => print('onNativeLoaded'),
      onNativeFailedToLoad: () => print('onNativeFailedToLoad'),
      onNativeShown: () => print('onNativeShown'),
      onNativeShowFailed: () => print('onNativeShowFailed'),
      onNativeClicked: () => print('onNativeClicked'),
      onNativeExpired: () => ('onNativeExpired'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Native'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () async {
                    var isInitialized =
                        await Appodeal.isInitialized(AppodealAdType.NativeAd);
                    print('Native isInitialized - $isInitialized');
                  },
                  child: const Text('IS INITIALIZED?'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () async {
                    var isCanShow =
                        await Appodeal.canShow(AppodealAdType.NativeAd);
                    print('Native canShow - $isCanShow');
                  },
                  child: const Text('CAN SHOW?'),
                ),
              ],
            ),
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    final nativeAdOptions = NativeAdOptions.customOptions(
                        adTitleConfig: AdTitleConfig(
                            fontSize: 16,
                            textColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            margin: 4),
                        adAttributionConfig: AdAttributionConfig(
                            fontSize: 12,
                            textColor: Colors.black,
                            backgroundColor: Colors.orangeAccent,
                            margin: 4),
                        adChoiceConfig: AdChoiceConfig(
                            position: AdChoicePosition.endBottom),
                        adIconConfig: AdIconConfig(
                            visible: true,
                            size: 70,
                            position: AdIconPosition.start,
                            margin: 4),
                        adDescriptionConfig: AdDescriptionConfig(
                            fontSize: 14,
                            textColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            margin: 4),
                        adActionButtonConfig: AdActionButtonConfig(
                            textColor: Colors.black,
                            fontSize: 16,
                            backgroundColor: Colors.transparent,
                            margin: 4,
                            radius: 12),
                        adMediaConfig: AdMediaConfig(visible: false));
                    setState(() {
                      isShow = true;
                      appodealNative =
                          AppodealNativeAd(options: nativeAdOptions);
                    });
                  },
                  child: const Text('NativeBanner'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    double screenWidth = MediaQuery.of(context).size.width;
                    final nativeAdOptions = NativeAdOptions.customOptions(
                        adTitleConfig: AdTitleConfig(
                            fontSize: 16,
                            textColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            margin: 4),
                        adAttributionConfig: AdAttributionConfig(
                            fontSize: 12,
                            textColor: Colors.black,
                            backgroundColor: Colors.orangeAccent,
                            margin: 4),
                        adChoiceConfig: AdChoiceConfig(
                            position: AdChoicePosition.endBottom),
                        adIconConfig: AdIconConfig(
                            visible: true,
                            size: 70,
                            position: AdIconPosition.start,
                            margin: 4),
                        adDescriptionConfig: AdDescriptionConfig(
                            fontSize: 14,
                            textColor: Colors.black,
                            backgroundColor: Colors.transparent,
                            margin: 4),
                        adActionButtonConfig: AdActionButtonConfig(
                            textColor: Colors.black,
                            fontSize: 16,
                            backgroundColor: Colors.transparent,
                            margin: 4,
                            radius: 12),
                        adMediaConfig: AdMediaConfig(
                          visible: true,
                          position: AdMediaPosition.top,
                          margin: 4,
                        ));
                    setState(() {
                      isShow = true;
                      appodealNative =
                          AppodealNativeAd(options: nativeAdOptions);
                    });
                  },
                  child: const Text('NativeFull'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    final nativeAdParams = NativeAdOptions.newsFeedOptions(
                        context: context,
                        adTitleFontSize: 14,
                        adActionButtonTextSize: 14,
                        adDescriptionFontSize: 12,
                        adAttributionTextColor: Colors.black,
                        adAttributionBackgroundColor: Colors.deepOrangeAccent,
                        adChoicePosition: AdChoicePosition.endBottom);
                    setState(() {
                      isShow = true;
                      appodealNative =
                          AppodealNativeAd(options: nativeAdParams);
                    });
                  },
                  child: const Text('NativeNewsFeed'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    final nativeAdParams = NativeAdOptions.appWallOptions(
                        context: context,
                        adTitleFontSize: 20,
                        adActionButtonTextSize: 20,
                        adDescriptionFontSize: 14,
                        adAttributionTextColor: Colors.black,
                        adAttributionBackgroundColor: Colors.green,
                        adChoicePosition: AdChoicePosition.endBottom);
                    setState(() {
                      isShow = true;
                      appodealNative =
                          AppodealNativeAd(options: nativeAdParams);
                    });
                  },
                  child: const Text('NativeAppWall'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    final nativeAdOptions =
                        NativeAdOptions.contentStreamOptions(
                            context: context,
                            adTitleFontSize: 16,
                            adActionButtonTextSize: 16,
                            adDescriptionFontSize: 14,
                            adAttributionTextColor: Colors.black,
                            adAttributionBackgroundColor:
                                Colors.deepOrangeAccent,
                            adChoicePosition: AdChoicePosition.endBottom);
                    if (isShow) {
                      setState(() {
                        isShow = false;
                      });
                    }
                    setState(() {
                      isShow = true;
                      appodealNative =
                          AppodealNativeAd(options: nativeAdOptions);
                    });
                  },
                  child: const Text('NativeContentStream'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    setState(() {
                      isShow = false;
                      appodealNative = null;
                    });
                  },
                  child: const Text('DISPOSE NATIVE'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Visibility(
                  visible: isShow,
                  child: Container(
                    height: appodealNative?.options.getWidgetHeight(context),
                    child: appodealNative == null
                        ? SizedBox.shrink()
                        : appodealNative!,
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
