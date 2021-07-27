import 'dart:async';

import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String androidAppKey = "fee50c333ff3825fd6ad6d38cff78154de3025546d47a84f";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Appodeal.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
    Appodeal.setAutoCache(Appodeal.BANNER, true);
    Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
    Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, true);
    Appodeal.setTesting(true);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Appodeal Flutter Demo'),
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Appodeal.initialize(androidAppKey, [Appodeal.REWARDED_VIDEO, Appodeal.INTERSTITIAL, Appodeal.BANNER], false);
                },
                child: const Text('Initialize'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () async {
                  var isInitialized = await Appodeal.isInitialized(Appodeal.INTERSTITIAL);
                  Fluttertoast.showToast(msg: '[AF Plugin]: Appodeal.isInitialized(Appodeal.INTERSTITIAL) - $isInitialized',
                      toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                },
                child: const Text('isInitialized Interstitial'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () async {
                  var isInitialized = await Appodeal.isAutoCacheEnabled(Appodeal.INTERSTITIAL);
                  Fluttertoast.showToast(msg: '[AF Plugin]: Appodeal.isAutoCacheEnabled(Appodeal.INTERSTITIAL) - $isInitialized',
                      toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                  Appodeal.updateConsent(true);
                },
                child: const Text('isAutoCacheEnabled Interstitial'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () async {
                  Appodeal.cache(Appodeal.INTERSTITIAL);
                },
                child: const Text('Cache Interstitial'),
              ),
            ],
          ),
          Center(
            child: Text('Running on: $_platformVersion\n'),
          ),
        ]),
      ),
    );
  }
}
