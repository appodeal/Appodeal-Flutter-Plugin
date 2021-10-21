import 'dart:developer';

import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'package:flutter/material.dart';

class BannerViewPage extends StatefulWidget {
  const BannerViewPage({Key? key}) : super(key: key);

  @override
  _BannerViewPageState createState() => _BannerViewPageState();
}

class _BannerViewPageState extends State<BannerViewPage> {
  bool isShow = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isShow = false;
    });

    Appodeal.setBannerCallbacks(
        (onBannerLoaded, isPrecache) =>
            showToast('$onBannerLoaded - isPrecache - $isPrecache'),
        (onBannerFailedToLoad) => showToast('$onBannerFailedToLoad'),
        (onBannerShown) => showToast('$onBannerShown'),
        (onBannerShowFailed) => showToast('$onBannerShowFailed'),
        (onBannerClicked) => showToast('$onBannerClicked'),
        (onBannerExpired) => showToast('$onBannerExpired'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Banner View'),
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
                    setState(() {
                      isShow = true;
                    });
                  },
                  child: const Text('SHOW BANNER VIEW'),
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
                    setState(() {
                      isShow = false;
                    });
                  },
                  child: const Text('HIDE BANNER VIEW'),
                ),
              ],
            ),
            //Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Visibility(
                  visible: isShow,
                  child: AppodealBannerView(placementName: "default")),
            ),
            //Interstitial
          ]),
        ),
      ),
    );
  }

  static void showToast(String message) {
    log(message);
  }
}
