import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_custom.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_template.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_custom_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_template_options.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class NativePage extends StatefulWidget {
  @override
  _NativePageState createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> {
  AppodealNative? appodealNative;
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
                    final nativeAd = NativeCustom(
                        adChoicePosition: AdChoicePosition.END_TOP,
                        options: NativeCustomOptions(
                            viewPosition: NativeBannerViewPosition.ICON_START,
                            mediaViewPosition: null,
                            containerMargin: 4,
                            iconSize: 80,
                            iconMargin: 4,
                            titleTextSize: 16,
                            titleMargin: 4,
                            descriptionTextSize: 14,
                            descriptionMargin: 4,
                            ctaTextSize: 14,
                            ctaMargin: 4,
                            titleColor: Colors.black,
                            descriptionColor: Colors.black,
                            ctaBackground: Colors.orangeAccent,
                            ctaTextColor: Colors.black));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNative(nativeAd: nativeAd);
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
                    final nativeAd = NativeCustom(
                        adChoicePosition: AdChoicePosition.END_TOP,
                        options: NativeCustomOptions(
                            viewPosition: NativeBannerViewPosition.ICON_START,
                            mediaViewPosition: MediaViewPosition.TOP,
                            containerMargin: 4,
                            iconSize: 80,
                            iconMargin: 4,
                            titleTextSize: 16,
                            titleMargin: 4,
                            descriptionTextSize: 14,
                            descriptionMargin: 4,
                            ctaTextSize: 14,
                            ctaMargin: 4,
                            titleColor: Colors.black,
                            descriptionColor: Colors.black,
                            ctaBackground: Colors.orangeAccent,
                            ctaTextColor: Colors.black));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNative(nativeAd: nativeAd);
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
                    final nativeAd = NativeTemplate(
                        adChoicePosition: AdChoicePosition.END_BOTTOM,
                        templateType: TemplateType.NEWS_FEED,
                        options: NativeTemplateOptions(
                            iconSize: 50,
                            titleTextSize: 14,
                            ctaTextSize: 14,
                            descriptionTextSize: 12,
                            adAttributionBackgroundColor:
                                Colors.deepOrangeAccent,
                            adAttributionTextColor: Colors.black));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNative(nativeAd: nativeAd);
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
                    final nativeAd = NativeTemplate(
                        adChoicePosition: AdChoicePosition.START_TOP,
                        templateType: TemplateType.APP_WALL,
                        options: NativeTemplateOptions(
                            iconSize: 70,
                            titleTextSize: 20,
                            ctaTextSize: 20,
                            descriptionTextSize: 14,
                            adAttributionBackgroundColor: Colors.green,
                            adAttributionTextColor: Colors.black));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNative(nativeAd: nativeAd);
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
                    final nativeAd = NativeTemplate(
                        adChoicePosition: AdChoicePosition.END_TOP,
                        templateType: TemplateType.CONTENT_STREAM,
                        options: NativeTemplateOptions(
                            iconSize: 70,
                            titleTextSize: 16,
                            ctaTextSize: 16,
                            descriptionTextSize: 14,
                            adAttributionBackgroundColor:
                                Colors.deepOrangeAccent,
                            adAttributionTextColor: Colors.black));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNative(nativeAd: nativeAd);
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
                  child: const Text('HIDE NATIVE'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Visibility(
                  visible: isShow,
                  child: Container(
                    height: 400,
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
