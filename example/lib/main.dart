import 'dart:async';
import 'dart:io';

import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(AppodealDemoApp());
}

class AppodealDemoApp extends StatefulWidget {
  @override
  _AppodealDemoAppState createState() => _AppodealDemoAppState();
}

class _AppodealDemoAppState extends State<AppodealDemoApp> {
  String androidAppKey = Platform.isAndroid ? "fee50c333ff3825fd6ad6d38cff78154de3025546d47a84f" : "466de0d625e01e8811c588588a42a55970bc7c132649eede";

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
    Appodeal.setTesting(true);
    Appodeal.setAutoCache(Appodeal.BANNER, true);
    Appodeal.setAutoCache(Appodeal.INTERSTITIAL, true);
    Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, true);
    Appodeal.setTriggerOnLoadedOnPrecache(Appodeal.INTERSTITIAL, true);
    Appodeal.setSharedAdsInstanceAcrossActivities(true);
    Appodeal.setSmartBanners(false);
    Appodeal.setTabletBanners(false);
    Appodeal.setBannerAnimation(false);
    Appodeal.setBannerRotation(Appodeal.BANNER_RIGHT, Appodeal.BANNER_LEFT);
    Appodeal.disableNetwork("admob");
    Appodeal.disableNetworkForSpecificAdType("vungle", Appodeal.INTERSTITIAL);
    Appodeal.disableLocationPermissionCheck();
    Appodeal.disableWriteExternalStoragePermissionCheck();

    Appodeal.setUserId("1");
    Appodeal.setUserAge(22);
    Appodeal.setUserGender(Appodeal.GENDER_FEMALE);

    Appodeal.setCustomFilterString("key", "value");
    Appodeal.setCustomFilterBool("key", true);
    Appodeal.setCustomFilterInt("setCustomFilterInt", 123);
    Appodeal.setCustomFilterDouble("setCustomFilterDouble", 2.1);

    Appodeal.muteVideosIfCallsMuted(true);
    Appodeal.setChildDirectedTreatment(true);

    Appodeal.setExtraDataBool("setExtraDataBool", true);
    Appodeal.setExtraDataInt("setExtraDataInt", 123);
    Appodeal.setExtraDataDouble("setExtraDataDouble", 1.2);
    Appodeal.setExtraDataString("setExtraDataString", "value");

    Appodeal.setUseSafeArea(true);

    Appodeal.setBannerCallbacks(
            (onBannerLoaded, isPrecache) => {showToast('BannerCallback - $onBannerLoaded  isPrecache - $isPrecache')},
            (onBannerFailedToLoad) => {showToast('BannerCallback - $onBannerFailedToLoad')},
            (onBannerShown) => {showToast('BannerCallback - $onBannerShown')},
            (onBannerShowFailed) => {showToast('BannerCallback - $onBannerShowFailed')},
            (onBannerClicked) => {showToast('BannerCallback - $onBannerClicked')},
            (onBannerExpired) => {showToast('BannerCallback - $onBannerExpired')});

    Appodeal.setInterstitialCallbacks(
            (onInterstitialLoaded, isPrecache) => {showToast('InterstitialCallBack - $onInterstitialLoaded isPrecache - $isPrecache')},
            (onInterstitialFailedToLoad) => {showToast('InterstitialCallBack - $onInterstitialFailedToLoad')},
            (onInterstitialShown) => {showToast('InterstitialCallBack - $onInterstitialShown')},
            (onInterstitialShowFailed) => {showToast('InterstitialCallBack - $onInterstitialShowFailed')},
            (onInterstitialClicked) => {showToast('InterstitialCallBack - $onInterstitialClicked')},
            (onInterstitialClosed) => {showToast('InterstitialCallBack - $onInterstitialClosed')},
            (onInterstitialExpired) => {showToast('InterstitialCallBack - $onInterstitialExpired')});

    Appodeal.setRewardedVideoCallbacks(
      (onRewardedVideoLoaded, isPrecache) => {showToast('RewardedVideoCallback - $onRewardedVideoLoaded isPrecache - $isPrecache')},
      (onRewardedVideoFailedToLoad) => {showToast('RewardedVideoCallback - $onRewardedVideoFailedToLoad')},
      (onRewardedVideoShown) => {showToast('RewardedVideoCallback - $onRewardedVideoShown')},
      (onRewardedVideoShowFailed) => {showToast('RewardedVideoCallback - $onRewardedVideoShowFailed')},
      (onRewardedVideoFinished, amount, reward) => {showToast('RewardedVideoCallback - $onRewardedVideoFinished amount - $amount reward - $reward')},
      (onRewardedVideoClosed, isFinished) => {showToast('RewardedVideoCallback - $onRewardedVideoClosed isFinished - $isFinished')},
      (onRewardedVideoExpired) => {showToast('RewardedVideoCallback - $onRewardedVideoExpired')},
      (onRewardedVideoClicked) => {showToast('RewardedVideoCallback - $onRewardedVideoClicked')},
    );

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
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
          //Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Appodeal.initialize(androidAppKey, [Appodeal.BANNER], false);
                },
                child: const Text('Initialize'),
              ),
            ],
          ),
          //Interstitial
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Interstitial')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        var isInitialized = await Appodeal.isInitialized(Appodeal.INTERSTITIAL);
                        Fluttertoast.showToast(msg: 'isInitialized Interstitial - $isInitialized', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      },
                      child: const Text('isInitialized'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        var isLoaded = await Appodeal.isLoaded(Appodeal.INTERSTITIAL);
                        Fluttertoast.showToast(msg: 'isLoaded Interstitial - $isLoaded', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      },
                      child: const Text('isLoaded'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        await Appodeal.showWithPlacement(Appodeal.INTERSTITIAL, "default");
                      },
                      child: const Text('show'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //Rewarded video
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Rewarded video')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        var isInitialized = await Appodeal.isInitialized(Appodeal.REWARDED_VIDEO);
                        Fluttertoast.showToast(msg: 'isInitialized Rewarded video - $isInitialized', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      },
                      child: const Text('isInitialized'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        var isLoaded = await Appodeal.isLoaded(Appodeal.REWARDED_VIDEO);
                        Fluttertoast.showToast(msg: 'isLoaded Rewarded video - $isLoaded', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      },
                      child: const Text('isLoaded'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        await Appodeal.show(Appodeal.REWARDED_VIDEO);
                      },
                      child: const Text('show'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          //Banner
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Banner')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        var isInitialized = await Appodeal.isInitialized(Appodeal.BANNER);
                        showToast('isInitialized - $isInitialized');
                      },
                      child: const Text('isInitialized'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        Appodeal.show(Appodeal.BANNER_BOTTOM);
                      },
                      child: const Text('bottom'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        await Appodeal.hide(Appodeal.BANNER);
                        var nativeSDKVersion = await Appodeal.getNativeSDKVersion();
                        Fluttertoast.showToast(msg: 'Appodeal.getNativeSDKVersion - $nativeSDKVersion', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                      },
                      child: const Text('hide'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        Appodeal.show(Appodeal.BANNER_LEFT);
                      },
                      child: const Text('left'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        Appodeal.show(Appodeal.BANNER_RIGHT);
                      },
                      child: const Text('right'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        Appodeal.show(Appodeal.BANNER_TOP);
                      },
                      child: const Text('top'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('Test Panel')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                      onPressed: () async {
                        var getNativeSDKVersion = await Appodeal.getNativeSDKVersion();
                        showToast("getNativeSDKVersion - $getNativeSDKVersion");
                      },
                      child: const Text('getNativeSDKVersion'),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                  //     onPressed: () async {
                  //       Appodeal.show(Appodeal.BANNER_BOTTOM);
                  //     },
                  //     child: const Text('show'),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                  //     onPressed: () async {
                  //       await Appodeal.hide(Appodeal.BANNER);
                  //       var nativeSDKVersion = await Appodeal.getNativeSDKVersion();
                  //       Fluttertoast.showToast(msg: 'Appodeal.getNativeSDKVersion - $nativeSDKVersion', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
                  //     },
                  //     child: const Text('hide'),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
  }
}
