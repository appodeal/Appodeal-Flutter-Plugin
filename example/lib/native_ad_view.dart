import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_ad.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_custom.dart';
import 'package:stack_appodeal_flutter/src/native_ad/native_template.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_custom_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/native_template_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/ad_attrubution_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/cta_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/description_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/title_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/media_options.dart';
import 'package:stack_appodeal_flutter/src/native_ad/options/views/icon_options.dart';
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
                    double screenWidth = MediaQuery.of(context).size.width;
                    final nativeAd = NativeCustom(
                      widgetWidth: screenWidth,
                      widgetHeight: screenWidth * 0.2,
                      adChoicePosition: AdChoicePosition.END_TOP,
                      options: NativeCustomOptions(
                        viewPosition: NativeBannerViewPosition.ICON_START,
                        mediaViewPosition: null,
                        containerMargin: 4,
                        adAttributionOptions: AdAttributionOptions(margin: 4, color: Colors.black, backgroundColor: Colors.teal),
                        ctaOptions: CTAOptions(margin: 4, fontSize: 16, color: Colors.black, backgroundColor: Colors.orangeAccent),
                        descriptionOptions: DescriptionOptions(margin: 4, fontSize: 14, color: Colors.black),
                        nativeIconOptions: IconOptions(margin: 4, size: 50),
                        nativeMediaOptions: MediaOptions(margin: 4),
                        titleOptions: TitleOptions(margin: 4, fontSize: 16, color: Colors.black),
                      ),
                    );
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNativeAd(nativeAd: nativeAd);
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
                    final nativeAd = NativeCustom(
                        widgetWidth: screenWidth,
                        widgetHeight: screenWidth * 0.7,
                        adChoicePosition: AdChoicePosition.END_TOP,
                        options: NativeCustomOptions(
                          viewPosition: NativeBannerViewPosition.ICON_START,
                          mediaViewPosition: MediaViewPosition.TOP,
                          containerMargin: 4,
                          adAttributionOptions: AdAttributionOptions(margin: 4, color: Colors.black, backgroundColor: Colors.teal),
                          ctaOptions: CTAOptions(margin: 4, fontSize: 16, color: Colors.black, backgroundColor: Colors.orangeAccent),
                          descriptionOptions: DescriptionOptions(margin: 4, fontSize: 14, color: Colors.black),
                          nativeIconOptions: IconOptions(margin: 4, size: 50),
                          nativeMediaOptions: MediaOptions(margin: 4),
                          titleOptions: TitleOptions(margin: 4, fontSize: 16, color: Colors.black),
                        ));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNativeAd(nativeAd: nativeAd);
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
                        context: context,
                        adChoicePosition: AdChoicePosition.END_BOTTOM,
                        templateType: TemplateType.NEWS_FEED,
                        options: NativeTemplateOptions(
                            iconSize: 50,
                            titleTextSize: 14,
                            ctaTextSize: 14,
                            descriptionTextSize: 12,
                            adAttributionBackgroundColor: Colors.deepOrangeAccent,
                            adAttributionTextColor: Colors.black));
                    setState(() {
                      isShow = true;
                      appodealNative = AppodealNativeAd(nativeAd: nativeAd);
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
                        context: context,
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
                      appodealNative = AppodealNativeAd(nativeAd: nativeAd);
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
                        context: context,
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
                      appodealNative = AppodealNativeAd(nativeAd: nativeAd);
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
