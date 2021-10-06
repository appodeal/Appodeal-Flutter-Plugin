import 'dart:developer';
import 'dart:io';

import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:appodeal_flutter_example/main.dart';
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
        (onConsentInfoUpdated, consent) => {
              showToast('$onConsentInfoUpdated'),
              print('$onConsentInfoUpdated consent - $consent'),
            },
        (onFailedToUpdateConsentInfo, error) => {
              showToast('$onFailedToUpdateConsentInfo error'),
              print('$onFailedToUpdateConsentInfo error - $error')
            });

    ConsentManager.setConsentFormListener(
      (onConsentFormLoaded) => showToast('$onConsentFormLoaded'),
      (onConsentFormError, error) => {
        showToast('$onConsentFormError error'),
        print('$onConsentFormError error - $error')
      },
      (onConsentFormOpened) => showToast('$onConsentFormOpened'),
      (onConsentFormClosed, consent) => {
        initialization(consent),
        showToast('$onConsentFormClosed'),
        print('$onConsentFormClosed consent - $consent'),
      },
    );
  }

  Future<void> initialization(String consent) async {
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);
    Appodeal.setTesting(true);
    Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
    Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, false);
    Appodeal.setTriggerOnLoadedOnPrecache(Appodeal.INTERSTITIAL, true);
    Appodeal.setSharedAdsInstanceAcrossActivities(true);
    Appodeal.setSmartBanners(false);
    Appodeal.setTabletBanners(false);
    Appodeal.setBannerAnimation(false);
    Appodeal.setBannerRotation(90, 90);
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
    Appodeal.initializeWithConsent(
        AppodealDemoApp.appKey,
        [
          Appodeal.REWARDED_VIDEO,
          Appodeal.INTERSTITIAL,
          Appodeal.BANNER,
          Appodeal.MREC
        ],
        consent);
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
