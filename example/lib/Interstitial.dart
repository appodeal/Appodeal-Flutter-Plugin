import 'dart:developer';

import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InterstitialPage extends StatefulWidget {
  @override
  _InterstitialPageState createState() => _InterstitialPageState();
}

class _InterstitialPageState extends State<InterstitialPage> {
  @override
  void initState() {
    super.initState();

    Appodeal.setInterstitialCallbacks(
        (onInterstitialLoaded, isPrecache) => {
              showToast('$onInterstitialLoaded isPrecache - $isPrecache')},
        (onInterstitialFailedToLoad) =>
            {showToast('$onInterstitialFailedToLoad')},
        (onInterstitialShown) =>
            {showToast('$onInterstitialShown')},
        (onInterstitialShowFailed) =>
            {showToast('$onInterstitialShowFailed')},
        (onInterstitialClicked) =>
            {showToast('$onInterstitialClicked')},
        (onInterstitialClosed) =>
            {showToast('$onInterstitialClosed')},
        (onInterstitialExpired) =>
            {showToast('$onInterstitialExpired')});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Interstitial'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () {
                    Appodeal.cache(Appodeal.INTERSTITIAL);
                  },
                  child: const Text('CACHE INTERSTITIAL'),
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
                    Appodeal.show(Appodeal.INTERSTITIAL);
                  },
                  child: const Text('SHOW INTERSTITIAL'),
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
                        await Appodeal.canShow(Appodeal.INTERSTITIAL);
                    showToast('Interstitial canShow - $isCanShow');
                  },
                  child: const Text('CAN SHOW?'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () async {
                    var isInitialized =
                        await Appodeal.isInitialized(Appodeal.INTERSTITIAL);
                    showToast('Interstitial isInitialized - $isInitialized');
                  },
                  child: const Text('IS INITIALIZED?'),
                ),
              ],
            ),
            //Interstitial
          ]),
        ),
      ),
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    log(message);
  }
}
