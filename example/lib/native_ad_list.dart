import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';

class NativeAdListPage extends StatefulWidget {
  @override
  State<NativeAdListPage> createState() => _NativeAdListPageState();
}

class _NativeAdListPageState extends State<NativeAdListPage> {
  List<Widget> adsList = [];

  /// Loads ad after every 5th widget
  int showAdAfter = 6;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });

    Appodeal.setNativeCallbacks(
      onNativeLoaded: () => print('onNativeLoaded'),
      onNativeFailedToLoad: () => print('onNativeFailedToLoad'),
      onNativeShown: () => print('onNativeShown'),
      onNativeShowFailed: () => print('onNativeShowFailed'),
      onNativeClicked: () => print('onNativeClicked'),
      onNativeExpired: () => print('onNativeExpired'),
    );
  }

  _initialize() {
    for (var i = 0; i < 50; i++) {
      adsList.add(ListTile(
        title: Text('Sample title $i'),
        subtitle: Text('Sample sub title $i'),
      ));
    }
    setState(() {});
  }

  Widget get _adWidget {
    NativeAdOptions options = NativeAdOptions.customOptions(
      adIconConfig: AdIconConfig(height: 55, width: 55),
      adAttributionConfig: AdAttributionConfig(textColor: Colors.black),
      adTitleConfig: AdTitleConfig(textColor: Colors.black),
      adLayoutConfig: AdLayoutConfig(adTileHeight: 55),
      adMediaConfig: AdMediaConfig(visible: true),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: const Text(
            'Sponsored content',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Container(
            height: options.getInlineAdHeight,
            alignment: Alignment.center,
            child: NewAppodealNativeAd(
              options: options,
            )),
      ],
    );
  }

  Widget get _mainBody {
    int length = adsList.length;
    length = length + (length ~/ showAdAfter);
    return ListView.separated(
      itemCount: length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return Container(
          height: 10,
          alignment: Alignment.center,
          color: Colors.blueGrey.shade50,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        int mainIndex = index;
        if ((index % showAdAfter == 0) && (index != 0)) {
          return _adWidget;
        } else {
          mainIndex = index - (index ~/ showAdAfter);
        }
        return adsList.elementAt(mainIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Native Ad List'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _mainBody,
      ),
    );
  }
}
