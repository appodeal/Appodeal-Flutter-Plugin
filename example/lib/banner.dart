import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  void initState() {
    super.initState();

    Appodeal.setBannerCallbacks(
        onBannerLoaded: (isPrecache) =>
            print('onBannerLoaded: isPrecache - $isPrecache'),
        onBannerFailedToLoad: () => print('onBannerFailedToLoad'),
        onBannerShown: () => print('onBannerShown'),
        onBannerShowFailed: () => print('onBannerShowFailed'),
        onBannerClicked: () => print('onBannerClicked'),
        onBannerExpired: () => print('onBannerExpired'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Banner'),
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
                        await Appodeal.isInitialized(AppodealAdType.Banner);
                    print('Banner isInitialized - $isInitialized');
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
                        await Appodeal.canShow(AppodealAdType.Banner);
                    print('Banner canShow - $isCanShow');
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
                    Appodeal.show(AppodealAdType.BannerBottom);
                  },
                  child: const Text('SHOW BANNER BOTTOM'),
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
                    Appodeal.show(AppodealAdType.BannerTop);
                  },
                  child: const Text('SHOW BANNER TOP'),
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
                    Appodeal.show(AppodealAdType.BannerRight);
                  },
                  child: const Text('SHOW BANNER RIGHT'),
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
                    Appodeal.show(AppodealAdType.BannerLeft);
                  },
                  child: const Text('SHOW BANNER LEFT'),
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
                    Appodeal.hide(AppodealAdType.Banner);
                  },
                  child: const Text('HIDE BANNER'),
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
