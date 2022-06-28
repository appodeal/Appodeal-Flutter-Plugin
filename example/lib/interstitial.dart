import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class InterstitialPage extends StatefulWidget {
  @override
  _InterstitialPageState createState() => _InterstitialPageState();
}

class _InterstitialPageState extends State<InterstitialPage> {
  @override
  void initState() {
    super.initState();

    Appodeal.setInterstitialCallbacks(
        onInterstitialLoaded: (isPrecache) => print('onInterstitialLoaded: isPrecache - $isPrecache'),
        onInterstitialFailedToLoad: () => print('onInterstitialFailedToLoad'),
        onInterstitialShown: () => print('onInterstitialShown'),
        onInterstitialShowFailed: () => print('onInterstitialShowFailed'),
        onInterstitialClicked: () => print('onInterstitialClicked'),
        onInterstitialClosed: () => print('onInterstitialClosed'),
        onInterstitialExpired: () => print('onInterstitialExpired'));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      fixedSize: Size(300, 20)),
                  onPressed: () async {
                    var isInitialized =
                        await Appodeal.isInitialized(Appodeal.INTERSTITIAL);
                    print('Interstitial isInitialized - $isInitialized');
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
                        await Appodeal.canShow(Appodeal.INTERSTITIAL);
                    print('Interstitial canShow - $isCanShow');
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
            //Interstitial
          ]),
        ),
      ),
    );
  }
}
