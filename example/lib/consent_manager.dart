import 'package:appodeal_flutter_example/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stack_appodeal_flutter/stack_appodeal_flutter.dart';
import 'ext.dart';

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
              showToast('$onConsentInfoUpdated consent - $consent'),
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
    Appodeal.setTesting(kReleaseMode ? false : true); //only not release mode
    Appodeal.setLogLevel(Appodeal.LogLevelVerbose);

    Appodeal.setAutoCache(Appodeal.INTERSTITIAL, false);
    Appodeal.setAutoCache(Appodeal.REWARDED_VIDEO, false);
    Appodeal.setUseSafeArea(true);

    Appodeal.initialize(
      appodealKey,
      [
        Appodeal.REWARDED_VIDEO,
        Appodeal.INTERSTITIAL,
        Appodeal.BANNER,
        Appodeal.MREC
      ],
    ); // without consent because the plugin knows about of using the consent manager
  }

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
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
                        ConsentManager.requestConsentInfoUpdate(appodealKey);
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
                        print('Consent - $consent');
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
                        var isLoaded =
                            await ConsentManager.consentFormIsLoaded();
                        showToast('isLoaded - $isLoaded');
                      },
                      child: const Text('FORM IS LOADED?'),
                    ),
                  ],
                ),
                //Interstitial
              ]),
            )),
      ),
    );
  }
}
