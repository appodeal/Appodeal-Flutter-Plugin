import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

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
                  child: AppodealBanner(
                      adSize: AppodealBannerSize.BANNER, placement: "default")),
            ),
            //Interstitial
          ]),
        ),
      ),
    );
  }
}
