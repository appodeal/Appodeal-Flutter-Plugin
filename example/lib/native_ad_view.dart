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
                    double screenWidth = MediaQuery.of(context).size.width;
                    //      widgetWidth: screenWidth,
                    //      widgetHeight: screenWidth * 0.2,
                    //      adChoicePosition: AdChoicePosition.END_BOTTOM,
                    //      widgetOptions: NativeCustomOptions(
                    //        viewPosition: NativeBannerViewPosition.ICON_START,
                    //        mediaViewPosition: null,
                    //        containerMargin: 4,
                    //        adAttributionOptions: AdAttributionOptions(
                    //            margin: 4,
                    //            color: Colors.black,
                    //            backgroundColor: Colors.teal),
                    //        ctaOptions: CTAOptions(
                    //            margin: 4,
                    //            fontSize: 16,
                    //            color: Colors.black,
                    //            backgroundColor: Colors.orangeAccent),
                    //        descriptionOptions: DescriptionOptions(
                    //            margin: 4, fontSize: 14, color: Colors.black),
                    //        nativeIconOptions: IconOptions(margin: 4, size: 50),
                    //        nativeMediaOptions: MediaOptions(margin: 4),
                    //        titleOptions: TitleOptions(
                    //            margin: 4, fontSize: 16, color: Colors.black),
                    //      ),
                    final nativeAdOptions = NativeAdOptions.customOptions();
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
                    final nativeAdOptions = NativeAdOptions.customOptions();
                    // widgetWidth: screenWidth,
                    // widgetHeight: screenWidth * 0.7,
                    // adChoicePosition: AdChoicePosition.END_BOTTOM,
                    // widgetOptions: NativeCustomOptions(
                    //   viewPosition: NativeBannerViewPosition.ICON_START,
                    //   mediaViewPosition: MediaViewPosition.TOP,
                    //   containerMargin: 4,
                    //   adAttributionOptions: AdAttributionOptions(
                    //       margin: 4,
                    //       color: Colors.black,
                    //       backgroundColor: Colors.teal),
                    //   ctaOptions: CTAOptions(
                    //       margin: 4,
                    //       fontSize: 16,
                    //       color: Colors.black,
                    //       backgroundColor: Colors.orangeAccent),
                    //   descriptionOptions: DescriptionOptions(
                    //       margin: 4, fontSize: 14, color: Colors.black),
                    //   nativeIconOptions: IconOptions(margin: 4, size: 50),
                    //   nativeMediaOptions: MediaOptions(margin: 4),
                    //   titleOptions: TitleOptions(
                    //       margin: 4, fontSize: 16, color: Colors.black),
                    // ));
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
                    final nativeAdParams = NativeAdOptions.newsFeedOptions();
                    // context: context,
                    // adChoicePosition: AdChoicePosition.END_BOTTOM,
                    // templateType: TemplateType.NEWS_FEED,
                    // widgetOptions: NativeTemplateOptions(
                    //     iconSize: 50,
                    //     titleTextSize: 14,
                    //     ctaTextSize: 14,
                    //     descriptionTextSize: 12,
                    //     adAttributionBackgroundColor:
                    //         Colors.deepOrangeAccent,
                    //     adAttributionTextColor: Colors.black));
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
                    final nativeAdParams = NativeAdOptions.appWallOptions();
                    // context: context,
                    // adChoicePosition: AdChoicePosition.END_BOTTOM,
                    // templateType: TemplateType.APP_WALL,
                    // widgetOptions: NativeTemplateOptions(
                    //     iconSize: 70,
                    //     titleTextSize: 20,
                    //     ctaTextSize: 20,
                    //     descriptionTextSize: 14,
                    //     adAttributionBackgroundColor: Colors.green,
                    //     adAttributionTextColor: Colors.black));
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
                        NativeAdOptions.contentStreamOptions();
                    // context: context,
                    // adChoicePosition: AdChoicePosition.END_BOTTOM,
                    // templateType: TemplateType.CONTENT_STREAM,
                    // widgetOptions: NativeTemplateOptions(
                    //     iconSize: 70,
                    //     titleTextSize: 16,
                    //     ctaTextSize: 16,
                    //     descriptionTextSize: 14,
                    //     adAttributionBackgroundColor:
                    //         Colors.deepOrangeAccent,
                    //     adAttributionTextColor: Colors.black));
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
                      dispose();
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
