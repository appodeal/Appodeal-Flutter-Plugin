import 'package:flutter/material.dart';
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
                        options: NativeCustomOptions(mediaViewPosition: null));
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
                        options: NativeCustomOptions());
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
                        templateType: TemplateType.NEWS_FEED,
                        options: NativeTemplateOptions());
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
                        templateType: TemplateType.APP_WALL,
                        options: NativeTemplateOptions());
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
                        templateType: TemplateType.CONTENT_STREAM,
                        options: NativeTemplateOptions());
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
                  onPressed: () {},
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
