import 'dart:developer';

import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BannerViewPage extends StatefulWidget {
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

    Appodeal.setBannerCallbacks((event, isPrecache) => showToast('$event - isPrecache - $isPrecache'), (event) => showToast('$event'), (event) => showToast('$event'), (event) => showToast('$event'), (event) => showToast('$event'), (event) => showToast('$event'));
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
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), fixedSize: Size(300, 20)),
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
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), fixedSize: Size(300, 20)),
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
              child: Visibility(visible: isShow, child: AppodealBannerView(placementName: "default")),
            ),
            //Interstitial
          ]),
        ),
      ),
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    log(message);
  }
}
