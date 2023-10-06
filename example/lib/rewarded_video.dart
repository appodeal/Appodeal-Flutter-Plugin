import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class RewardedVideoPage extends StatefulWidget {
  @override
  _RewardedVideoPageState createState() => _RewardedVideoPageState();
}

class _RewardedVideoPageState extends State<RewardedVideoPage> {
  @override
  void initState() {
    super.initState();

    Appodeal.setRewardedVideoCallbacks(
      onRewardedVideoLoaded: (isPrecache) =>
          print('onRewardedVideoLoaded: isPrecache - $isPrecache'),
      onRewardedVideoFailedToLoad: () => print('onRewardedVideoFailedToLoad'),
      onRewardedVideoShown: () => print('onRewardedVideoShown'),
      onRewardedVideoShowFailed: () => print('onRewardedVideoShowFailed'),
      onRewardedVideoFinished: (amount, reward) =>
          print('onRewardedVideoFinished: amount - $amount, reward - $reward'),
      onRewardedVideoClosed: (isFinished) =>
          print('onRewardedVideoClosed isFinished - $isFinished'),
      onRewardedVideoExpired: () => print('onRewardedVideoExpired'),
      onRewardedVideoClicked: () => print('onRewardedVideoClicked'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Rewarded Video'),
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
                    var isInitialized = await Appodeal.isInitialized(
                        AppodealAdType.RewardedVideo);
                    print('Rewarded video isInitialized - $isInitialized');
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
                        await Appodeal.canShow(AppodealAdType.RewardedVideo);
                    print('Rewarded video canShow - $isCanShow');
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
                    Appodeal.cache(AppodealAdType.RewardedVideo);
                  },
                  child: const Text('CACHE REWARDED VIDEO'),
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
                    Appodeal.show(AppodealAdType.RewardedVideo);
                  },
                  child: const Text('SHOW REWARDED VIDEO'),
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
