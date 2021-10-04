import 'dart:developer';
import 'dart:io';

import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConsentManagerPage extends StatefulWidget {
  @override
  _ConsentManagerState createState() => _ConsentManagerState();
}

class _ConsentManagerState extends State<ConsentManagerPage> {
  @override
  void initState() {
    super.initState();

    ConsentManager.setConsentInfoUpdateListener(
        (event, consent) => {
              showToast('$event'),
              print('$event consent - $consent'),
            },
        (event, error) =>
            {showToast('$event error'), print('$event error - $error')});

    ConsentManager.setConsentFormListener(
      (event) => showToast('$event'),
      (event, error) =>
          {showToast('$event error'), print('$event error - $error')},
      (event) => showToast('$event'),
      (event, consent) => {
        showToast('$event'),
        print('$event consent - $consent'),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String appKey = Platform.isAndroid
        ? "fee50c333ff3825fd6ad6d38cff78154de3025546d47a84f"
        : "466de0d625e01e8811c588588a42a55970bc7c132649eede";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Consent Manager'),
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
                    ConsentManager.setCustomVendor(
                        "name",
                        "com.appodeal.test",
                        "policyUrl",
                        [1, 2, 3, 4, 5],
                        [1, 2, 3, 4, 5],
                        [1, 2, 3, 4, 5]);
                  },
                  child: const Text('SET VENDOR'),
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
                    ConsentManager.setStorage(Storage.SHARED_PREFERENCE);
                  },
                  child: const Text('SET STORAGE'),
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
                    ConsentManager.requestConsentInfoUpdate(appKey);
                  },
                  child: const Text('REQUEST CONSENT INFO'),
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
                    var vendor = await ConsentManager.getCustomVendor(
                        "com.appodeal.test");
                    showToast('Vendor - $vendor');
                  },
                  child: const Text('GET VENDOR'),
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
                    var storage = await ConsentManager.getStorage();
                    showToast('Vendor - $storage');
                  },
                  child: const Text('GET STORAGE'),
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
                    var shouldShow =
                        await ConsentManager.shouldShowConsentDialog();
                    showToast('SHOULD SHOW? - $shouldShow');
                  },
                  child: const Text('SHOULD SHOW?'),
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
                    var zone = await ConsentManager.getConsentZone();
                    showToast('Zone - $zone');
                  },
                  child: const Text('GET ZONE'),
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
                    var status = await ConsentManager.getConsentStatus();
                    showToast('Status - $status');
                  },
                  child: const Text('GET STATUS'),
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
                    var consent = await ConsentManager.getConsent();
                    print('Status - $consent');
                  },
                  child: const Text('GET CONSENT'),
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
                    ConsentManager.loadConsentForm();
                  },
                  child: const Text('LOAD CONSENT FORM'),
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
                    ConsentManager.showAsActivityConsentForm();
                  },
                  child: const Text('SHOW AS ACTIVITY'),
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
                    ConsentManager.showAsDialogConsentForm();
                  },
                  child: const Text('SHOW AS DIALOG'),
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
                    var isLoaded = await ConsentManager.consentFormIsLoaded();
                    showToast('isLoaded - $isLoaded');
                  },
                  child: const Text('FORM IS LOADED?'),
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
