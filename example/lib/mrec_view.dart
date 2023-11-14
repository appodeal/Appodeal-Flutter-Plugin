import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class MrecViewPage extends StatefulWidget {
  @override
  _MrecViewPageState createState() => _MrecViewPageState();
}

class _MrecViewPageState extends State<MrecViewPage> {
  bool isShow = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isShow = false;
    });

    Appodeal.setMrecCallbacks(
        onMrecLoaded: (isPrecache) =>
            print('onMrecLoaded: isPrecache - $isPrecache'),
        onMrecFailedToLoad: () => print('onMrecFailedToLoad'),
        onMrecShown: () => print('onMrecShown'),
        onMrecShowFailed: () => print('onMrecShowFailed'),
        onMrecClicked: () => print('onMrecClicked'),
        onMrecExpired: () => print('onMrecExpired'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mrec View'),
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
                  child: const Text('SHOW MREC VIEW'),
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
                  child: const Text('HIDE MREC VIEW'),
                ),
              ],
            ),
            //Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Visibility(
                  visible: isShow,
                  child: AppodealBanner(
                      adSize: AppodealBannerSize.MEDIUM_RECTANGLE,
                      placement: "default")),
            ),
            //Interstitial
          ]),
        ),
      ),
    );
  }
}
